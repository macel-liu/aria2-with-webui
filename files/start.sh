#!/bin/sh

# Create aria2.conf
cp -f /conf-copy/aria2.conf /conf/aria2.conf
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
if [ $aria2BtRequireCrypto ]; then
	echo "bt-require-crypto=${aria2BtRequireCrypto}" >> /conf/aria2.conf
fi
if [ $aria2BtMinCryptoLevel ]; then
	echo "bt-min-crypto-level=${aria2BtMinCryptoLevel}" >> /conf/aria2.conf
fi
if [ $aria2BtSaveMetadata ]; then
	echo "bt-save-metadata=${aria2BtSaveMetadata}" >> /conf/aria2.conf
fi
if [ $aria2BtLoadSavedMetadata ]; then
	echo "bt-load-saved-metadata=${aria2BtLoadSavedMetadata}" >> /conf/aria2.conf
fi
if [ $aria2SaveSessionInterval ]; then
	echo "save-session-interval=${aria2SaveSessionInterval}" >> /conf/aria2.conf
fi
if [ $aria2ListenPort ]; then
	echo "listen-port=${aria2ListenPort}" >> /conf/aria2.conf
fi
if [ $aria2EnableDht ]; then
	echo "enable-dht=${aria2EnableDht}" >> /conf/aria2.conf
fi
if [ $aria2DhtListenPort ]; then
	echo "dht-listen-port=${aria2DhtListenPort}" >> /conf/aria2.conf
fi

# Extra aria2 option file
if [ ! -f /conf/aria2_ext.conf ]; then
	touch /conf/aria2_ext.conf
fi
cat /conf/aria2_ext.conf >> /conf/aria2.conf

# Create hook files, if not exists
if [ ! -f /conf/on-bt-download-complete.sh ]; then
	cp /conf-copy/on-bt-download-complete.sh /conf/on-bt-download-complete.sh
fi
if [ ! -f /conf/on-download-complete.sh ]; then
	cp /conf-copy/on-download-complete.sh /conf/on-download-complete.sh
fi
if [ ! -f /conf/on-download-error.sh ]; then
	cp /conf-copy/on-download-error.sh /conf/on-download-error.sh
fi
if [ ! -f /conf/on-download-pause.sh ]; then
	cp /conf-copy/on-download-pause.sh /conf/on-download-pause.sh
fi
if [ ! -f /conf/on-download-start.sh ]; then
	cp /conf-copy/on-download-start.sh /conf/on-download-start.sh
fi
if [ ! -f /conf/on-download-stop.sh ]; then
	cp /conf-copy/on-download-stop.sh /conf/on-download-stop.sh
fi

chmod +x /conf/on-bt-download-complete.sh
chmod +x /conf/on-download-complete.sh
chmod +x /conf/on-download-error.sh
chmod +x /conf/on-download-pause.sh
chmod +x /conf/on-download-start.sh
chmod +x /conf/on-download-stop.sh

if [ ! -f /conf/aria2.session ]; then
	touch /conf/aria2.session
fi

cat /conf/aria2.conf

# Change /aria2-webui/configuration.js
#if [ $aria2Secret ]; then
    export aria2webuiPlaceholderToken = "// token: '$YOUR_SECRET_TOKEN$'"
    export aria2webuiToken = "token: ${aria2Secret}"
    echo ${aria2webuiPlaceholderToken}
    echo ${aria2webuiToken}
    #sed -i -e 's/${aria2webuiPlaceholderToken}/${aria2webuiToken}/g' /aria2-webui/configuration.js
#fi

#echo "/aria2-webui/configuration.js"
#cat /aria2-webui/configuration.js

# Start aria2 and aria2-webui
darkhttpd /aria2-webui --port 80 &
aria2c --conf-path=/conf/aria2.conf
