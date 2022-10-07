#!/bin/bash

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
