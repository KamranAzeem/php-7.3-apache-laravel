# About this image:
This iamge caters for the primary needs for the [laravel software](https://laravel.com)
Once we have base image, we avoid compilation of all these base PHP modules for every change we make in the RUN command.

# How to build and use:
Well, on your local computer, do:
```
docker built -t local/php:7.3-apache-laravel
```

Then in your other Dockerfile, which you will use to pull in actual laravel software, reference this image as **FROM**.

i.e.
```
FROM local/php:7.3-apache-laravel

. . . 
(Rest of your Dockerfile)
```

# DockerHub:
This image is available on DockerHub under the user `kamranazeem` . You should be able to pull it by using:
```
docker pull kamranazeem/php:7.3-apache-laravel
```


