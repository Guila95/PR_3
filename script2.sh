#!/bin/bash
#ДАННЫЕ ПРОЦЕССОРА
cpu_clock=`cat /proc/cpuinfo | grep "cpu MHz" | awk {'print $4'} | sed q`
let "cpu_clock=$(printf %.0f $cpu_clock)"
#cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | awk {'print $4'}`
cpu_cores=`grep -o "processor" <<< "$(cat /proc/cpuinfo)" | wc -l`
cpu_model=`cat /proc/cpuinfo | grep "model name" | sed q | sed -e "s/model name//" | sed -e "s/://" | sed -e 's/^[ \t]*//' | sed -e "s/(tm)/™/g" | sed -e "s/(C)/©/g" | sed -e "s/(R)/®/g"`
cpu_model=`echo $cpu_model | sed -e "s/ * / /g"`

#ОПРЕДЕЛЯЕМ ОС
osfamily=$(cat /etc/issue.net | awk {'print $1'})
osver2=$(cat /etc/issue.net | awk {'print $2'})


#РАЗРЯДНОСТЬ ОС
arc=`arch`
if [ "$arc" == "x86_64" ]; then arc=64 
else arc=32
fi 

#ВЕРСИЯ ЯДРА LINUX
kern=`uname -r | sed -e "s/-/ /" | awk {'print $1'}`

echo "┌──────────────────────────────────────────────────────────────┐"
echo "│                     Информация о системе                     │"
echo "└──────────────────────────────────────────────────────────────┘"
echo "                            CPU: $cpu_cores x $cpu_clock MHz ($cpu_model)"
echo "                             ОС: $osfamily $osver2"
echo "                 Разрядность ОС: $arc bit"
echo "              Версия ядра Linux: $kern"