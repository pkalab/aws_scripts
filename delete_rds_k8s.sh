#!/bin/bash

export mysql_password="password"

kubectl run toolbox --image=sjourdan/toolbox:latest --rm -i --tty -- /bin/sh

# Inside the Toolbox pod, create a file with database names
cat << EOF > database_list.txt
#dbname
EOF


while read -r database
do

  echo -------------
  echo "checking $database"
  echo -------------
  mysql -h hostname-u root --password=$mysql_password $database -e "SHOW TABLES ;" | head
  echo -------------
done < database_list.txt
