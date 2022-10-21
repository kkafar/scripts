#! /bin/bash

cd "scripts"
source "src/logutil.sh"

# gesettings requires this env var to be set!
# It is set normally in user session, but cron is running without env.
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

declare -r LOG_FILE_STEM="set-theme"
declare -r LOG_FILE="log/${LOG_FILE_STEM}.log"
declare -r CINNAMON_LIGHT_THEME="Mint-Y"
declare -r CINNAMON_DARK_THEME="Mint-Y-Dark-Grey"
declare -r KITTY_LIGHT_THEME="Atom One Light"
declare -r KITTY_DARK_THEME="Dark-mint-y"
declare -r WALLPAPER_LIGHT="file:///home/kkafara/Pictures/Wallpapers/macOS-Monterey-wallpaper-Light.jpg"
declare -r WALLPAPER_DARK="file:///home/kkafara/Pictures/Wallpapers/macOS-Monterey-wallpaper-Dark.jpg"

mkdir -p log

CURRENT_TIME=$(date +%H%M)

CINNAMON_NEW_THEME=${CINNAMON_DARK_THEME}
KITTY_NEW_THEME=${KITTY_DARK_THEME}
WALLPAPER_NEW=${WALLPAPER_DARK}

if [[ "${CURRENT_TIME}" -ge 0700 ]] && [[ "${CURRENT_TIME}" -lt 1700 ]]; then
	CINNAMON_NEW_THEME=${CINNAMON_LIGHT_THEME}
	KITTY_NEW_THEME=${KITTY_LIGHT_THEME}
	WALLPAPER_NEW=${WALLPAPER_LIGHT}
fi

# Set the chosen theme
gsettings set org.cinnamon.desktop.interface gtk-theme "'${CINNAMON_NEW_THEME}'"
gsettings set org.cinnamon.desktop.interface icon-theme "'${CINNAMON_NEW_THEME}'"
gsettings set org.cinnamon.theme name "'${CINNAMON_NEW_THEME}'"
gsettings set org.cinnamon.desktop.background picture-uri "'${WALLPAPER_NEW}'"

kitty +kitten themes --reload-in=all ${KITTY_NEW_THEME}

log_info "Cinnamon theme changed to '${CINNAMON_NEW_THEME}'. Kitty theme changed to '${KITTY_NEW_THEME}'." ${LOG_FILE} 100
