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
#     VERSION: 1.0
#========================================================================================================

#uname -r 
#ls /boot | grep vmlinuz | cut -d'-' -f2,3
#dpkg -l |grep ^ii| grep 4.4.0-34|awk -F' ' '{ print $2 }'|xargs -I % sh -c 'echo sudo apt remove -y %'

for KERNEL in $(ls /boot | grep vmlinuz| cut -d'-' -f2,3|grep -v $(uname -r|cut -d'-' -f1,2))
do
	dpkg -l |grep ^ii| grep $KERNEL|awk -F' ' '{ print $2 }'|xargs -I % sh -c 'sudo apt remove -y %';
done



