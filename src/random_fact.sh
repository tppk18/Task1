lines="1"
if [ $# -ne 0 ] && [ $1 -gt 1 ]; then
  lines=$1
fi
res="$(curl -s -X 'GET' 'https://catfact.ninja/facts?limit='$lines -H 'accept: application/json' -w '%{http_code}')"
status="$(echo $res | grep -o '...$')"
if [ "$status" -eq 200 ] ; then
  echo $res | grep -Po '.*(?=...$)' | jq -r '.data[].fact' >> "$(date '+%d-%m-%Y %T.txt')"
fi

