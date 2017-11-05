#!/bin/sh
if [ ! -f /conf/aria2.conf ]; then
	cp /conf-copy/aria2.conf /conf/aria2.conf
	if [ $aria2Secret ]; then
		echo "rpc-secret=${aria2Secret}" >> /conf/aria2.conf
	fi
	if [ $aria2MaxConcurrentDownloads ]; then
		echo "max-concurrent-downloads=${aria2MaxConcurrentDownloads}" >> /conf/aria2.conf
	fi
	if [ $aria2SeedRatio ]; then
		echo "seed-ratio=${aria2SeedRatio}" >> /conf/aria2.conf
	fi
	if [ $aria2SeedTime ]; then
		echo "seed-time=${aria2SeedTime}" >> /conf/aria2.conf
	fi
	if [ $aria2DisableIpv6 ]; then
		echo "disable-ipv6=${aria2DisableIpv6}" >> /conf/aria2.conf
	fi
	if [ $aria2ForceSave ]; then
		echo "force-save=${aria2ForceSave}" >> /conf/aria2.conf
	fi
	if [ $aria2MaxDownloadLimit ]; then
		echo "max-download-limit=${aria2MaxDownloadLimit}" >> /conf/aria2.conf
	fi
	if [ $aria2MaxOverallDownloadLimit ]; then
		echo "max-overall-download-limit=${aria2MaxOverallDownloadLimit}" >> /conf/aria2.conf
	fi
	if [ $aria2Continue ]; then
		echo "continue=${aria2Continue}" >> /conf/aria2.conf
	fi
	if [ $aria2MinSplitSize ]; then
		echo "min-split-size=${aria2MinSplitSize}" >> /conf/aria2.conf
	fi
	if [ $aria2Split ]; then
		echo "split=${aria2Split}" >> /conf/aria2.conf
	fi
	if [ $aria2MaxConnectionPerServer ]; then
		echo "max-connection-per-server=${aria2MaxConnectionPerServer}" >> /conf/aria2.conf
	fi
fi
if [ ! -f /conf/on-complete.sh ]; then
	cp /conf-copy/on-complete.sh /conf/on-complete.sh
fi

chmod +x /conf/on-complete.sh
touch /conf/aria2.session

cat /conf/aria2.conf

darkhttpd /aria2-webui --port 80 &
aria2c --conf-path=/conf/aria2.conf
