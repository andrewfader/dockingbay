![Screenshot](screenshot.png "screenshot")
Docking Bay
===========

Docking Bay, a.k.a. FaderStack, is a Rails front-end for managing a process infrastructure using lightweight linux containers or modular VMs (Docker/future Vagrant). 

Because I am building against the idea of OpenStack, currently uses ldap via devise ldap_authenticatable. You will need an ldap.yml in config/ and I have not provided an example. Sorry, but I am sure if you really want to run this you can figure out where to get the ldap.yml.example. Note to self, make a sane ldap.yml.example for a docker LDAP server that then in turn configures itself according to the ...?

You will need to install docker and run it according to BaseResource::DOCKER_URL and the port in config/initializers/docker.rb. Maybe I will move this config somewhere else later.

Currently I am sometimes hitting docker through the docker-api gem which makes an object called Docker, along with Docker::Container etc that implement API methods. Container and Image are implemented as ActiveResource objects which follow the REST conventions. I have also used Excon to make API connections directly, which seems like the way I will end up implementing streaming. Currently I have consigned streaming to ContainerData and a Resque job, start with redis-server && resque work, I need to re-implement the streaming block logic using, I guess EventMachine? Actually - https://github.com/ngauthier/tubesock

![Logo](app/assets/images/starfox_logo.png "logo")
