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

sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/sites-available/default
a2enmod rewrite ssl

mkdir /etc/apache2/ssl
mkdir /var/run/apache2


# Setup SSL
/scripts/apache/generate-ssl.sh

