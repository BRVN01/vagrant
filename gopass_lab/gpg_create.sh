#!/bin/bash

# Acesse cada usuário diretamente via SSH, se mudar de usuário com o comando SU vai dar erro de permissão ao tentar decriptar algo.

cat >foo <<EOF
     %echo Generating a basic OpenPGP key
     Key-Type: RSA
     Key-Length: 1024
     Subkey-Type: RSA
     Subkey-Length: 1024
     Name-Real: $USER Tester
     Name-Email: $USER@foo.bar
     Expire-Date: 0
     Passphrase: $USER
     # Do a commit here, so that we can later print "done" :-)
     %commit
     %echo done
EOF

gpg --batch --generate-key foo
