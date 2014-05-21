#!/bin/bash
#######################################################################
#
# Copyright (c) 2014 Eclipse Foundation and others.
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#
# Contributors:
#   Thanh Ha (Eclipse Foundation) - initial implementation
#
#######################################################################

if [ ! -f /etc/apache2/ssl/server.key ]; then
        mkdir -p /etc/apache2/ssl
        KEY=/etc/apache2/ssl/server.key
        DOMAIN=$(hostname)
        export PASSPHRASE=$(head -c 128 /dev/urandom  | uuencode - | grep -v "^end" | tr "\n" "d")
        SUBJ="
C=CA
ST=Ontario
O=Eclipse
localityName=Ottawa
commonName=$DOMAIN
organizationalUnitName=
emailAddress=webmaster@eclipse.org
"
        openssl genrsa -des3 -out /etc/apache2/ssl/server.key -passout env:PASSPHRASE 2048
        openssl req -new -batch -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key $KEY -out /tmp/$DOMAIN.csr -passin env:PASSPHRASE
        cp $KEY $KEY.orig
        openssl rsa -in $KEY.orig -out $KEY -passin env:PASSPHRASE
        openssl x509 -req -days 365 -in /tmp/$DOMAIN.csr -signkey $KEY -out /etc/apache2/ssl/server.crt
fi
