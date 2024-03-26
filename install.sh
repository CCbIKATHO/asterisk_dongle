yum -y install git wget vim  net-tools sqlite-devel psmisc ncurses-devel libtermcap-devel newt-devel libxml2-devel libtiff-devel gtk2-devel libtool libuuid-devel subversion kernel-devel crontabs cronie-anacron libedit libedit-devel git usb_modeswitch* usbutils
yum install asterisk11-devel
mkdir /home/asterisk/install
cd /home/asterisk/install
git clone https://github.com/wdoekes/asterisk-chan-dongle.git
cd asterisk-chan-dongle
./bootstrap
./configure --with-astversion=16.24.1
make
make install
touch /etc/asterisk/dongle.conf

tee -a /etc/asterisk/dongle.conf << EOF
[general]
interval=15                    
;jbenable = yes  
;jbforce = no 
;jbmaxsize = 200
;jbresyncthreshold = 1000 
;jbimpl = fixed
;jbtargetextra = 40
;jblog = no

[GSM]
imei=353142035180556
;exten=+380630000000

[defaults]
context=from-trunk
group=0
rxgain=0
txgain=0
autodeletesms=yes
resetdongle=yes
u2diag=-1
usecallingpres=yes 
callingpres=allowed_passed_screen
disablesms=no 
default = no
language=en
smsaspdu=yes
mindtmfgap=45
mindtmfduration=80
mindtmfinterval=200
callwaiting=auto
disable=no
initstate=start
dtmf=relax
EOF

groupadd -f -r asterisk
usermod -a -G dialout,lock,asterisk asterisk
chown -R asterisk:asterisk /var/lib/asterisk
chown -R asterisk:asterisk /var/spool/asterisk
chown -R asterisk:asterisk /var/log
chown -R asterisk:asterisk /var/log/asterisk
chown -R asterisk:asterisk /var/run/asterisk

touch /etc/asterisk/lockfiles.sh

tee -a /etc/asterisk/lockfiles.sh << EOF
#!/bin/bash
chown asterisk:asterisk /var/lock/
EOF

chmod 755 /etc/asterisk/lockfiles.sh

touch /etc/systemd/system/donglepermissions.service

tee -a /etc/systemd/system/donglepermissions.service << EOF
[Unit]
Description=Description for sample script goes here
After=network.target
[Service]
Type=simple
ExecStart=/etc/asterisk/lockfiles.sh
TimeoutStartSec=0
[Install]
WantedBy=default.target
EOF

systemctl enable donglepermissions.service

rm -f /etc/sysconfig/asterisk
touch /etc/sysconfig/asterisk

tee -a /etc/sysconfig/asterisk << EOF
AST_USER=asterisk
AST_GROUP=asterisk
OPTIONS="-U asterisk"
COREDUMP=yes
EOF

touch /etc/udev/rules.d/92-dongle.rules

tee -a /etc/udev/rules.d/92-dongle.rules << EOF
KERNEL=="ttyUSB*", MODE="0666", OWNER="_asterisk", GROUP="asterisk"
EOF
