#! /usr/bin/python/2.7/bin/python

# USAGE: run_pipe.py <cmd1> <cmd2> [cmd3 [cmd4 ...]]
#
# Description: run a pipe of processes.
#   If 0th processes exits - that's a graceful exit
#   If one of the other stages exits - give 0th process a grace, then kill it !
#
# Motivation:
#   Usually, when one of pipe stages exits, all other stages are ripped off gracefully.
#   For example:
#       cat some-long-file | head -1
#   'head' exits before cat, then 'cat' exits with error code 1
#
#   Heavy weight tools like archlib funcsim may misbehave and not exit when pipe becomes broken.
#   Instead, it will keep running as if nothing happened.
#   This script handles exactly this, makes sure that when pipe becomes broken, all stages are terminated.

import os
import sys
import shlex
import subprocess
import time

def kill_with_grace(proc, grace):
    while grace > 0 and proc.poll() == None:
        time.sleep(1)
        grace -= 1

    try: proc.kill()
    except OSError, strerror:
        print "PID", proc.pid, "exited"
    else:
        print "PID", proc.pid, "was successfully killed, waiting to yield an exit code"
        # wait till proc actually terminates and yields a return code
        grace = 100
        while grace > 0 and proc.poll() == None:
            time.sleep(1)
            grace -= 1

        if proc.poll() == None:
            print "PID", proc.pid, "is <defunct> !!!"
        else:
            print "PID", proc.pid, "exit code", proc.poll()

    return proc.poll()

def dump_pipe_status(msg, pipe, cmds):
    print msg,\
        ", PID:", [p.pid for p in pipe],\
        ", rc:", [p.poll() for p in pipe],\
        ", cmds:", [os.path.basename(shlex.split(cmd)[0]) for cmd in cmds]

def main(argv):
    CI_ROOT = os.getenv("CI_ROOT")
    if not CI_ROOT:
        print "Exit: ERROR. Bad evironment"
        sys.exit(1)

    cmds = argv[1:]
    max_cmd = len(cmds)
    if max_cmd < 2:
        print "Exit: ERROR. Hey, it takes at least two commands to make a pipe:", cmds
        sys.exit(1)

    # Print the pipe line in a copy&paste friendly format
    print "\nPIPE cmd:", " \\\n  | ".join(cmds), "\n"
    sys.stdout.flush()

    # Assemble a pipe line:
    # - First stage in pipe: don't override stdin
    # - Mid stages: wire ins and outs
    # - Last stage in pipe: don't override stdout (the default is sys.stdout)
    pipe = []
    pipe.append(subprocess.Popen(shlex.split(cmds[0]), stdout=subprocess.PIPE))
    for i in range(1, max_cmd-1):
        pipe.append(subprocess.Popen(shlex.split(cmds[i]), stdin=pipe[-1].stdout, stdout=subprocess.PIPE))
    pipe.append(subprocess.Popen(shlex.split(cmds[-1]), stdin=pipe[-1].stdout))

    # Allow pipe[i] to receive a SIGPIPE if pipe[i+1] exits. Do not apply this to the last proc in pipe !!!
    for p in pipe[0:-1]:
        p.stdout.close()

    pipe[-1].communicate()

    # poll() returns None if process is still running
    rc = pipe[0].poll()
    if rc != None:
        if rc != 0: print "PID", pipe[0].pid, "exited with error:", rc
    else:
        # pipe[0] is still alive, give it a grace of 5sec then kill
        dump_pipe_status("One of the pipe stages has terminated", pipe, cmds)
        rc = kill_with_grace(pipe[0], 5)
        # If process is killed, the return code will be set to -9. But if the process became <defunct>
        # rc will be None and we want to treat it as an error !
        rc = 1 if rc == None else 0

    dump_pipe_status("Pipe done", pipe, cmds)
    return rc

if __name__ == "__main__":
    rc = main(sys.argv)
    print "Exiting with rc =", rc
    sys.exit(rc)
