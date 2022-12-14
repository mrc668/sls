#!/bin/bash
# source salt://salt/sls/perimiter/bin/

export PATH=$PATH:/sbin:/usr/sbin

ListName=$( basename $0 | sed -e "s/.sh$//")
ListNew="$ListName.new"

ipset list -n | grep $ListName -q || ipset create $ListName hash:net comment
ipset list -n | grep $ListName -q || {
  echo Failed to create ipset $ListName
  exit -1
}


ipset create $ListNew hash:net comment
ipset list -n | grep $ListNew -q || {
  echo Failed to create ipset $ListNew
  exit -2
}


urls="
http://rules.emergingthreats.net/blockrules/compromised-ips.txt
http://www.blocklist.de/lists/bruteforcelogin.txt
http://lists.blocklist.de/lists/all.txt
http://dragonresearchgroup.org/insight/sshpwauth.txt
http://dragonresearchgroup.org/insight/vncprobe.txt
http://www.nothink.org/blacklist/blacklist_malware_http.txt
http://www.nothink.org/blacklist/blacklist_ssh_all.txt
http://hosts-file.net/rss.asp
https://feodotracker.abuse.ch/blocklist/?download=ipblocklist
http://www.binarydefense.com/banlist.txt
http://www.talosintelligence.com/feeds/ip-filter.blf
http://spamsnapper.to/ssh-violations
"

for u in  $urls ; do
	echo Getting $u
	echo curl -SskL --connect-timeout 3 $u
	for i in $(curl -SskL --connect-timeout 3 $u | grep [0-9] | grep -Ev "[^0-9\.]" ); do
		ipset -q test whitelist $ip && {
      echo $u tried to add $i from whitelist
    } || {
      ipset -exist add $ListNew $i comment "$u" || echo Failed on $i
    }
	done
	ipset list $ListNew | head | grep entries
	echo 
done

echo Getting http://www.dshield.org/ipsascii.html?limit=20000
for i in $(curl -SsL http://www.dshield.org/ipsascii.html?limit=10000 | cut  -f1 | grep -Ev "[^0-9\.]" | sed -r "s/^0{1,2}//; s/\.0{1,2}/\./g; " ); do
	ipset -exist add $ListNew $i comment "dshield.org" || echo Failed on $i
done
ipset list $ListNew | head | grep entries
echo 

echo Getting https://isc.sans.edu/api/intelfeed
for ip in $(curl -sS 'https://isc.sans.edu/api/intelfeed?json&requestor=milton@calnek.com' | jq -c '.[] | select ( .ip != null ) | { ip } ' | cut -d\" -f4); do
	ipset -q test whitelist $ip || {
    ipset -q test isc-blocks $ip  || {
      ipset -exist add $ListNew $ip comment "isc intelfeed" || echo Failed on $ip
    }
  }
done
ipset list $ListNew | head 

ipset list $ListNew > /etc/sysconfig/ipsets/$ListName
ipset swap $ListName $ListNew && {
  ipset destroy $ListNew
  ipset save $ListName > /etc/sysconfig/ipsets/$ListName
}
