Aria2 with webui for unRaid
---
Only 11Mb. Inspired by XUJINKAI.  

Edit config file out of the image.  
Move file completed to another folder.  
(Tasks that contains more than one files will not be moved.)  

### Install
I. replace **/DOWNLOAD_DIR** and **/CONFIG_DIR** for save data, and **YOUR_SECRET_CODE** for security. Run command below  
```
sudo docker run -d \
--name unraid-aria2-with-webui \
-p 6880:80 \
-v /DOWNLOAD_DIR:/data \
-v /CONFIG_DIR:/conf \
-e SECRET=YOUR_SECRET_CODE \
fanningert/unraid-aria2-with-webui
```
  
II. Open `http://serverip:6880/` for aria2-webui.  

### Build:  
`sudo docker build -f Dockerfile -t fanningert/unraid-aria2-with-webui .`  

### Link:  
https://github.com/aria2/aria2  
https://github.com/ziahamza/webui-aria2  

https://github.com/acgotaku/BaiduExporter  
