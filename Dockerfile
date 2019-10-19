FROM php:7.3-apache
MAINTAINER kamranazeem@gmail.com

# This image is created to cater for the basic needs of laravel
# Having this image means we do not have to waste time compiling php modues everytime.


# Following php modules are already part of official PHP image , so no need to re-install them:
#   (use `php -m` in the base image to find the list of already installed/Compiled modules)
# ---------------------------------------------------------------------------------------------
# * Core ctype curl date dom fileinfo filter ftp hash iconv json libxml mbstring mysqlnd 
# * openssl pcre PDO pdo_sqlite Phar posix readline Reflection session SimpleXML 
# * sodium SPL sqlite3 standard tokenizer xml xmlreader xmlwriter zlib  

# To find what all modules are available for installation in the default php:x.y-apache image,
#   run the container image in interactive mode, and run the following command without any parameters.
# It will show you all the php modules available.
#   # docker-php-ext-install 

#  For php modules not available in the default image, you will need to download and compile them manually.

# Useful tools to find stuff in debian:
# ------------------------------------
# apt-get install apt-cache apt-file && apt-cache update
# apt-cache search libxml2
# apt-file find png.h 



#########################################################################################################
#
# Start building the image:
#
# Note: docker-php-ext-install also enables the module after installation.
#       * laravel needs bcmath module as a prerequisite.
#

RUN apt-get -y update \
 && apt-get -y install apt-utils curl iputils-ping unzip \
 && apt-get -y autoremove \
 && apt-get -y clean \
 && docker-php-ext-install bcmath mysqli pdo_mysql \
 && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php composer-setup.php --install-dir=/usr/bin/ --filename="composer" --quiet \
 && rm -f composer-setup.php

# 
# Main build process complete here.
#
#########################################################################################################



CMD ["apache2-foreground"]


# Adjust other aspects of the image:
####################################

# If you want to use the php.ini which comes with the official PHP image,
#   then use the following:
# mv ${PHP_INI_DIR}/php.ini-production ${PHP_INI_DIR}/php.ini

# If you want to customize php.ini settings, then copy in custom-php.ini file inside ${PHP_INI_DIR}/conf.d/ :
# COPY php.devpc.ini ${PHP_INI_DIR}/conf.d/

# Place in any httpd customization:
# COPY my-httpd-customization.conf /etc/apache2/conf-enabled/



# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> End of main Dockerfile <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



##################################################
# Build instructions:
# docker build -t kamranazeem/php:5.6-apache .
##################################################

