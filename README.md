# StreamSets demo

This project provides a simple way to spin up [StreamSets](https://streamsets.com/) and a standlone [Hadoop](http://hadoop.apache.org/) Docker containers. 
Linux, Windows and Mac are all supported. On Linux, the Docker containers are spun up directly. On Mac and Windows they are spun up in an Ubuntu 16.04 Virtualbox host VM. An example pipeline is provided, based on the [Taxi payments tutorial](https://streamsets.com/documentation/datacollector/latest/help/#Tutorial/ExtendedTutorial.html#concept_w4n_gjt_ls). The data is outputted to HDFS running in the Hadoop container.

## Getting started

### Install dependencies

#### Windows / Mac only

* Install [Vagrant](https://www.vagrantup.com/). Vagrant version 1.9.1 is tested.
* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads). VirtualBox version 5.1.14 is tested.

#### Linux only

NOTE: If running on Ubuntu, you can install all these dependencies by running 
```
sudo host/install.sh $USER
```

* Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
* Add your user to the docker group
```
sudo usermod -aG docker $USER
```
* Test that docker commands can be run without `sudo`
```
docker ps
```

### Start Docker hosts

#### Windows / Mac

From the root of the project, run 
```
vagrant up
```
Note you will be prompted by UAC to agree admin privileges. This is so that your `/etc/hosts` file can be modified automatically.

#### Linux

From the root of the project, run
```
docker-compose up -d
```

##### Making HDFS download links work

If you wish to access the HDFS GUI from another machine, you will need to add a redirect in `/etc/hosts` for `hdfs` to your Linux host. On the computer you want to access the HDFS GUI from, add the following to your
* (On Windows) `C:\Windows\System32\drivers\etc\hosts` file
* (On Linux / Mac) `/etc/hosts`
```
hdfs <IP of your Linux host>
```

### Import the example StreamSets pipeline and run it

* Wait for HDFS startup to finish. You can verify this by checking that "Safemode is off" appears beneath Summary in the [HDFS GUI Overview tab](http://dketley1:50070/dfshealth.html#tab-overview)
* From the [StreamSets GUI](http://localhost:18630), import the pipeline in `examples/` and run it
* Navigate to `http://localhost:50070/explorer.html#/opt/files/destination` to see the output files.
  Note the output will be prefixed `_tmp_` while the pipeline is running. Once you stop the pipeline, the files will be renamed to `out_`. You can download them from here.

## Other stuff that you probably won't need

### (Windows / Mac only) Accessing the Ubuntu host

* To SSH into the host VM, run
```
vagrant ssh
```

### To add a new StreamSets package

* From within the StreamSets app, navigate to Package Manager
* Copy the library name you want
* Add the library name to `PACKAGES_TO_INSTALL` in `docker/streamsets/Dockerfile`
* From the Linux host, run
```
docker-compose stop
docker-compose start
```

### License

MIT License

Copyright (c) 2017 Dominic Ketley

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
