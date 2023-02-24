#    source: salt://sls/openvpn/Makefile
# do not edit here

default: /etc/openvpn/server/server.pid

/etc/openvpn/server/server.pid: /etc/openvpn/server/server.conf
	/usr/bin/systemctl enable openvpn-server@server
	/usr/bin/systemctl stop openvpn-server@server
	/usr/bin/systemctl start openvpn-server@server
	pgrep -u openvpn -f server.conf > $@

