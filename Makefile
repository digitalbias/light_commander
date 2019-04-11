include .env
include .env.network
export $(shell sed 's/=.*//' .env)
export $(shell sed 's/=.*//' .env.network)

default: build

setup:
	cd ui; mix deps.get;
	cd ui; cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode production
	cd ui; mix phx.digest

build:
	cd lights; mix deps.get
	cd firmware; mix deps.get; mix firmware

burn:
	cd firmware; mix firmware.burn

push:
	cd firmware; ./upload.sh ${NETWORK_IP}

clean:
	cd firmware; rm -Rf _build

rebuild: clean build

screen:
	screen /dev/tty.SLAB_USBtoUART 115200