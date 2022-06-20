#!/bin/bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

users="spawn ipa user-add ricardo --first=ricardo --last=andrade --email=ricardo@taskforce171.br
spawn ipa user-add jose --first=jose --last=cavalcante --email=jose@taskforce171.br
spawn ipa user-add roberto --first=roberto --last=silva --email=roberto@taskforce171.br
spawn ipa user-add felipe --first=felipe --last=augusto --email=felipe@taskforce171.br"

groups="ipa group-add --desc=group\ all allgroup
ipa group-add-member allgroup --users=ricardo --users=roberto --users=jose --users=felipe"

log_in () {

    /usr/bin/expect<<EOF
    spawn kinit admin
    expect "Password for admin@MADDOGS.BR:" {
	    send "KQtR#03;B@hM1jyzi:g-rCx5C\r"
    }
    expect eof
EOF

}

create_users () {
		
    for namesusers in $users
    do
        nome=$(awk '{ print $4 }' <<<${namesusers})
        /usr/bin/expect<<EOF
        ${namesusers}
        expect eof

        eval spawn ipa user-mod $nome --password
        expect "Password:" {
	        send "utn8,IxgW0r6j?M:L5ATXs+S@\r"

	        expect "Enter Password again to verify:" {
                send "utn8,IxgW0r6j?M:L5ATXs+S@\r"
            }
        }
        expect eof
EOF
    done
}

create_group () {

    for namesgroups in $groups
    do
        eval ${namesgroups}
    done
}


log_in
create_users
create_group

IFS=$SAVEIFS

IP=$(ip addr show eth0 | grep -oE 'inet ([0-9]{1,3}\.){3}[0-9]{1,3}')
IP=$(sed "s/inet //" <<<${IP})
sed -i "s/192.168.122.87   idm.maddogs.br/$IP\tidm.maddogs.br/" /etc/hosts
