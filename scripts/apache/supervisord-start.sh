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

MYSQL_HOST=${MYSQL_HOST:-127.0.0.1}
MYSQL_PORT=${MYSQL_PORT:-3306}

if [ "$MYSQL_HOST" != "127.0.0.1" ]
then
    echo "Not initializing embedded MySQL due to user configuration"
    echo "autostart=false" >> /etc/supervisor/conf.d/mysqld.conf
fi

exec /usr/sbin/service supervisor start

