# 2>&1 | tee -a log.txt  # 出力を画面とファイル両方に出力 (ex: ./x.sh 2>&1 | tee -a log.txt)
# curl -fsSL -c c -o /dev/null 'https://github.com'
i=0
cat all_name.txt | while read line
do
  if [ $i -lt 11260 ]; then
    i=`expr 1 + $i`
    continue
  fi
  # code=`curl -d "value=$line" -fsSL -b c -w '%{http_code}' -o /dev/null 'https://github.com/signup_check/username'`
  code=`curl -sS -o /dev/null -w '%{response_code}' "https://github.com/$line"`
  if [ $code -eq 404 ]; then
    echo $i: [$code] $line 'available'
    echo $line >> available_name.txt
  elif [ $code -eq 200 ]; then
    echo $i: [$code] $line no
  elif [ $code -eq 301 -o $code -eq 410 ]; then
    echo $i: [$code] $line '???'
    echo $line >> other.txt
  else
    echo $i: [$code] $line error
    echo $line >> error.txt
  fi
  sleep $(echo 0.8 + $(awk 'BEGIN { print rand() }') | bc)
  i=`expr 1 + $i`
done
