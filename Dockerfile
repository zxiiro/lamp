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

FROM zxiiro/mysql
MAINTAINER Thanh Ha <thanh.ha@alumni.carleton.ca>

RUN apt-get update

# --------------------
# Install Requirements
# --------------------

# Install Apache Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 php5 php5-mysql php5-gd php-xml-parser php5-xsl php5-curl sharutils php5-memcache memcached


# -----------------------------
# Pull in scripts and resources
# -----------------------------
ADD etc/supervisor/conf.d /etc/supervisor/conf.d
ADD scripts/apache /scripts/apache
RUN chmod 755 /scripts/apache/*.sh

# Apache
ADD etc/apache2/sites-enabled /etc/apache2/sites-enabled
ADD etc/apache2/ports.conf /etc/apache2/ports.conf

# -----
# Setup
# -----

RUN /scripts/apache/apache-setup.sh


# Apache HTTPS
EXPOSE 443

CMD ["/scripts/apache/supervisord-start.sh"]

