Tested on the FreeBPX assembly downloaded from the official website https://www.freepbx.org/downloads/

after installation is complete, check your version of asterisk (tested on version 16.24.1)

[root@freepbx ~]#asterisk -vrrr
Asterisk 16.24.1, Copyright (C) 1999 - 2021, Sangoma Technologies Corporation and others.
Created by Mark Spencer <markster@digium.com>
Asterisk comes with ABSOLUTELY NO WARRANTY; type 'core show warranty' for details.
This is free software, with components licensed under the GNU General Public
License version 2 and other licenses; you are welcome to redistribute it under
certain conditions. Type 'core show license' for details.
=========================================================================
Connected to Asterisk 16.24.1 currently running on freepbx (pid = 10021)

install

[root@freepbx ~]#cd /home/asterisk/
[root@freepbx ~]#git clone https://github.com/CCbIKATHO/asterisk_dongle.git

if your version of asterisk is different from 16.24.1, before installation, edit the install.sh file indicating your version in line 8

[root@freepbx ~]#chmod +x /home/asterisk/asterisk_dongle/install.sh

[root@freepbx ~]#/home/asterisk/asterisk_dongle/install.sh

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
