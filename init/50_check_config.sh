#!/bin/bash
# The template config file can be found here: 
# https://github.com/nzbget/nzbget/blob/develop/nzbget.conf
# The linux substitutions should be here:
# https://github.com/nzbget/nzbget/blob/develop/linux/build-nzbget#L341 

chown -R abc:abc /app

if [ ! -f /config/nzbget.conf ]; then
  echo "No config found, copys default now"
  cp -v /app/nzbget.conf /config/nzbget.conf
  echo "Changeing some defaults to match our container"
  # MainDir=${AppDir}/downloads            -> MainDir=/downloads
  sed -i -e "s#\(MainDir=\).*#\1/downloads#g" /config/nzbget.conf
  # Umask=1000                             -> Umask=1000
  sed -i -e "s#\(UMask=\).*#\1000#g" /config/nzbget.conf
  # ScriptDir=${AppDir}/scripts            -> ScriptDir=${MainDir}/scripts
  sed -i -e "s#\(ScriptDir=\).*#\1$\{MainDir\}/scripts#g" /config/nzbget.conf
  # ControlIP=0.0.0.0                      -> ControlIP=0.0.0.0
  sed -i -e "s#\(ControlIP=\).*#\10.0.0.0#g" /config/nzbget.conf
  chown abc:abc /config/nzbget.conf
  chmod u+rw /config/nzbget.conf
  chown -R abc:abc /downloads
fi

echo "Checking some config options"
# WebDir=${AppDir}/webui                    -> WebDir=${AppDir}/webui
sed -i -e "s#\(WebDir=\).*#\1$\{AppDir\}/webui#g" /config/nzbget.conf
# ConfigTemplate=${AppDir}/webui/nzbget.conf.tempate    -> ConfigTemplate=${WebDir}/nzbget.conf.template
sed -i -e "s#\(ConfigTemplate=\).*#\1$\{WebDir\}/nzbget.conf.template#g" /config/nzbget.conf
# LogFile=${MainDir}/nzbget.log             -> LogFile=/logs/nzbget.log
sed -i -e "s#\(LogFile=\).*#\1/logs/nzbget.log#g" /config/nzbget.conf
# LockFile=${MainDir}/nzbget.lock           -> LockFile=/logs/nzbget.lock
sed -i -e "s#\(LockFile=\).*#\1/logs/nzbget.lock#g" /config/nzbget.conf
