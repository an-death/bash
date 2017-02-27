#!/bin/bash

#Скрипт для вывода закомвермленных тасков

#Загрузка сурсов с пасами и ip
source ~/Документы/scr/source/data.cfg

start_man_conf_task=true

  while $start_man_conf_task
  do
  	sleep 1
    until [[ $(date) != $(date -d 17:00:00) ]] && [[ $(date -d mon) && $(date -d tue) && $(date -d wed) && $(date -d thu) && $(date -d fri) ]]
    do
      tasks_id=$(MantisMYSQLBaseConnect -e "select mbt.id as 'ID' from mantis_bug_table mbt INNER JOIN mantis_category_table mct ON (mbt.category_id=mct.id) LEFT OUTER JOIN mantis_user_table mut ON (mbt.handler_id=mut.id) where mbt.status=40 and mut.username in ('a.simuskov') order by last_updated desc;")
      for tasks in $tasks_id 
      do
        if [[ $tasks =~ [0-9]{6} ]]
          then  
            echo "$(date)  $tasks" >> /tmp/mantis_comf_tasks.log
            google-chrome --app="http://office.tetra-soft.ru/mantis/view.php?id=${tasks}"
          #else
            # echo "is not tasks_id - $tasks"
        fi
      done
    done
  done  

