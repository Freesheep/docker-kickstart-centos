[![Build Status](https://travis-ci.org/chasebolt/docker-kickstart-centos.svg?branch=master)](https://travis-ci.org/chasebolt/docker-kickstart-centos)

# cbolt/kickstart-centos

Builds an ISO with an embedded kickstart file for USB/CD installs.
By default it will install a basic kickstart and isolinux file. These can be overridden
by placing your version in /config/ks.cfg, /config/isolinux.cfg. The download URL can be
overridden through the environment variable.

## Usage

```
docker run \
  --name=kickstart-centos \
  -v </path/to/data>:/data \
  -v </path/to/config>:/config \
  cbolt/kickstart-centos
```

**Parameters**

* `-v /path/to/data:/data` - ISO output file location.
* `-v /path/to/config:/config` - ks.cfg, isolinux.cfg go here if you want to override defaults.
* `-e URL` - Set this to the full path of a CentOS install ISO file. `http://foobar.com/CentOS-7-x86_64-NetInstall-1503.iso`
