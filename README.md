Tested on the FreeBPX assembly downloaded from the official website https://www.freepbx.org/downloads/

after installation is complete, check your version of asterisk (tested on version 16.24.1)

[root@freepbx ~]#asterisk -vrrr

Asterisk 16.24.1

install
[root@freepbx ~]#yum -y install git

[root@freepbx ~]#cd /home/asterisk/

[root@freepbx ~]#git clone https://github.com/CCbIKATHO/asterisk_dongle.git

if your version of asterisk is different from 16.24.1, before installation, edit the install.sh file indicating your version in line 8

[root@freepbx ~]#chmod +x /home/asterisk/asterisk_dongle/install.sh

[root@freepbx ~]#/home/asterisk/asterisk_dongle/install.sh

after installation, restart the system

Modem support
huawei e1550
huawei e173
huawei e171

Preparing modems

Install SIM in modem
unpack the modem files folder install the 3G modem driver open the Huawei Terminal.exe file using AT commands and enter the commands one after the other:

1) AT^U2DIAG=0
2) AT+CPMS="ME","ME","ME"
3) AT+CMGD=1,4
4) AT^SYSCFG=13,2,00000080,1,2 (if the modem did not respond correctly, then use the combination AT^SYSCFG=13,1,00000080,1,2)

After installing and configuring the modem, check:

[root@freepbx ~]#asterisk -vrrr

freepbx*CLI> dongle show devices
ID           Group State      RSSI Mode Submode Provider Name  Model      Firmware          IMEI             IMSI             Number
GSM          0     Free       17   0    0       Vodafone UA    E1550      11.608.12.00.143  353142035180556  255011676320550  Unknown



