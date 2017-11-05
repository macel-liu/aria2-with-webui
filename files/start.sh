#!/bin/sh
if [ ! -f /conf/aria2.conf ]; then
	cp /conf-copy/aria2.conf /conf/aria2.conf
	if [ $SECRET ]; then
		echo "rpc-secret=${SECRET}" >> /conf/aria2.conf
	fi
	if [ $aria2-max-concurrent-downloads ]; then
		echo "max-concurrent-downloads=${aria2-max-concurrent-downloads}" >> /conf/aria2.conf
	fi
	if [ $aria2-seed-ratio ]; then
		echo "seed-ratio=${aria2-seed-ratio}" >> /conf/aria2.conf
	fi
	if [ $aria2-seed-time ]; then
		echo "seed-time=${aria2-seed-time}" >> /conf/aria2.conf
	fi
	if [ $aria2-disable-ipv6 ]; then
		echo "disable-ipv6=${aria2-disable-ipv6}" >> /conf/aria2.conf
	fi
	if [ $aria2-force-save ]; then
		echo "force-save=${aria2-force-save}" >> /conf/aria2.conf
	fi
	if [ $aria2-max-download-limit ]; then
		echo "max-download-limit=${aria2-max-download-limit}" >> /conf/aria2.conf
	fi
	if [ $aria2-max-overall-download-limit ]; then
		echo "max-overall-download-limit=${aria2-max-overall-download-limit}" >> /conf/aria2.conf
	fi
fi
if [ ! -f /conf/on-complete.sh ]; then
	cp /conf-copy/on-complete.sh /conf/on-complete.sh
fi

chmod +x /conf/on-complete.sh
touch /conf/aria2.session

cat /conf/aria2.conf

darkhttpd /aria2-webui --port 80 &
aria2c --conf-path=/conf/aria2.conf --continue
