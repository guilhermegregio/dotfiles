#!/bin/bash

#========================================================================================================
#        FILE: remove-old-kernels.sh
#       USAGE: ./remove-old-kernels.sh
#
# DESCRIPTION: Remove all packages related with old kernels
#              Reference: https://www.vivaolinux.com.br/dica/Remover-kernel(s)-antigo(s)-no-Ubuntu
#
#      AUTHOR: Guilherme M Gregio <guilherme@gregio.net> (gregio.net)
#     CREATED: 20/04/2017
#     VERSION: 1.1
#========================================================================================================

#uname -r 
#ls /boot | grep vmlinuz | cut -d'-' -f2,3
#dpkg -l |grep ^ii| grep 4.4.0-34|awk -F' ' '{ print $2 }'|xargs -I % sh -c 'echo sudo apt remove -y %'

IS_REMOVED=0;

for KERNEL in $(ls /boot | grep vmlinuz| cut -d'-' -f2,3|grep -v $(uname -r|cut -d'-' -f1,2))
do
	dpkg -l |grep ^ii| grep $KERNEL|awk -F' ' '{ print $2 }'|xargs -I % sh -c 'sudo apt remove -y %';
	IS_REMOVED=$(($IS_REMOVED+1));
done

if [ $IS_REMOVED -gt 0 ]
then
	echo "Removed old kernel's !!!"
else
	echo "Kernel's older versions not found!"
fi

echo "Updating start"

sudo apt update;
sudo apt dist-upgrade -y;
sudo apt autoremove -y;
sudo apt autoclean

echo "Finish!!! :)"

exit 0;
