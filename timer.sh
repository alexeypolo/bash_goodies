# source me

function timer()
{
  let n=$1;
  let counter=0;
  while [ $counter -lt $n ]; do
    sleep 1;
    let counter+=1;
    echo -ne "$counter\r";
  done;
}
