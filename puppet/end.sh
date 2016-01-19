echo "..=#= . ....-==*#######***===++* -.==+==**###**--+===="
echo "=-------------+...Completed Tasks....+---------------="

url="localhost:80"
status_code=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $url)

if pgrep "mysql" > /dev/null
then
  echo "=-------------+...MySQL is Running...+---------------="
fi

if pgrep "php" > /dev/null
then
  echo "=-------------+...PHP7 is Running....+---------------="
fi

if pgrep "nginx" > /dev/null
then
  echo "=-------------+...NGINX is Running...+---------------="

    if [ $status_code -ne "200" ] && [ $status_code -ne "302" ]; then
      echo "--. -.......-==*#-|HTTP ERROR: $status_code|--=*##*=.  . . .  ."
    else
      echo "=----------------------------------------------------="
      echo "--.-.......-=*|http://localhost:8888/|-=*#*.  . . .  ."
    fi
fi
echo "=----------------------------------------------------="
echo "*==-..-.....-===*****======+++++----....+=***==   ..."
