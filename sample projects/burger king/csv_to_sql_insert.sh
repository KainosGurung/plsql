#! /bin/bash

filename="$1"
first_line="yes"
db_name="zip_db"
while read -r line #Read file line by line
do
	name="$line"
	values=""
	if [[ $first_line = "yes" ]]
	then
		var_names=${name//'"'/ ''}		
		first_line='no'
	else
		if [[ ${#name} > 0  ]]
		then
			IFS=',' read -r -a array <<< "$name" #split the string based on comma and store into an array
			
			counter=1
			for val in "${array[@]}"
			do
				if [[ $counter -eq 1 ]]
				then
					values=${val//'"'/ ''}
					first=0
				elif [[ $counter -eq 2 ]] 
				then
					values="$values,"${val//'"'/ "'"}
					second=0
				elif [[ $counter -eq 3 ]]
				then
					values="$values,"${val//'"'/ "'"}
					third=0
				else
					values="$values,"${val//'"'/ ''}
				fi
				counter=$((counter+1))
			done
			echo "INSERT INTO $db_name($var_names) values($values);" >> out.sql
		fi
	fi
done < "$filename"
