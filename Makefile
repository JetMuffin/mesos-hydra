all: upload

.PHONY: package upload download_egg

download_egg:
	wget https://s3.amazonaws.com/downloads.mesosphere.io/master/ubuntu/13.10/mesos_0.16.0_amd64.egg

upload: package example
	rm -rf $(NFS_PATH)/hydra
	mkdir -p $(NFS_PATH)/hydra
	cp hydra.tgz $(NFS_PATH)/hydra/hydra.tgz
	cp hello_world $(NFS_PATH)/hydra/hello_world

package:
	cd export && tar -cvzf ../hydra.tgz *

example: hello_world.cpp
	mpicc -o hello_world -g -O2 hello_world.cpp
	
