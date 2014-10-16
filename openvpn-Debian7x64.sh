#!/bin/bash
# init
function pause(){
   read -p "$*"
}
echo -e "\e[1;32mOpenVPN \e[1;37mInstaller \e[1;37m(\e[1;31mDebian7 x64\e[1;37m)"

# Schimba parola root
echo -e "\e[1;32mChanging root password\e[1;37m"
pause 'Press ENTER for continue'

echo -e "\e[1;37mPlease type a new root password:"
read -s rootpw1 
echo -e "\e[1;37mPlease repeat the new password:"
read -s rootpw2

if [ $rootpw1 != $rootpw2 ] ; then
	echo -e "\e[1;31mPasswords do not match"
exit
fi

echo -e "$rootpw1\n$rootpw1" | passwd root
clear

#Update
echo -e "\e[1;32mUpdating System\e[1;37m"
pause 'Press ENTER for continue'

apt-get update 
apt-get dist-upgrade -y 
apt-get upgrade -y
clear

#Instaleaza OpenVPN
echo -e "\e[1;32mInstalling OpenVPN\e[1;37m"
pause 'Press ENTER for continue'
cd /home
mkdir a
cd a
wget http://swupdate.openvpn.org/as/openvpn-as-2.0.10-Debian7.amd_64.deb
dpkg -i openvpn-as-2.0.10-Debian7.amd_64.deb
cd ..
rm -rf a
clear

#Schimbare parola openvpn
echo -e "\e[1;32mChanging openvpn password\e[1;37m"
pause 'Press ENTER for continue'

echo -e "\e[1;37mPlease type a new password:"
read -s vpnpw1
echo -e "\e[1;37mPlease repeat the new password:"
read -s vpnpw2

if [ $vpnpw1 != $vpnpw2 ] ; then
	echo -e "\e[1;31mPasswords do not match\e[1;37m"
exit
fi

echo -e "$vpnpw1\n$vpnpw1" | passwd openvpn
clear

ip=`ifconfig|xargs|awk '{print $7}'|sed -e 's/[a-z]*:/''/'`

clear
pause 'Press ENTER for more info about this installation'
echo -e "\e[1;32m=================================================\e[1;37m"
echo -e "\e[1;32mIP : \e[1;37m$ip"
echo -e "\e[1;32mUSERNAME :\e[1;37m root"
echo -e "\e[1;32mPASSWORD :\e[1;37m $rootpw1"
echo -e "\e[1;32m=================================================\e[1;37m"
echo -e "\e[1;32mVPN USER :\e[1;37m openvpn"
echo -e "\e[1;32mVPN PASS :\e[1;37m $vpnpw1"
echo -e "\e[1;32m=================================================\e[1;37m"
echo -e "\e[1;32mADMIN URL:\e[1;37m https://$ip:943/admin"
echo -e "\e[1;32mCLIENT URL:\e[1;37m https://$ip:943/"
echo -e "\e[1;32m=================================================\e[1;37m"
pause 'Done ! Copyright 2014 120704'
clear
