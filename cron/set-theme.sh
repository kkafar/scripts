#! /bin/bash

cd "$HOME/scripts"
source "src/logutil.sh"

# gesettings requires this env var to be set!
# It is set normally in user session, but cron is running without env.
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

declare -r LOG_FILE_STEM="set-theme"
declare -r LOG_FILE="log/${LOG_FILE_STEM}.log"

# cron executes this script from $HOME as cwd
if [[ ! -f "$HOME/.guienv" ]]; then
	log_err ".guienv file not found under $HOME/.guienv path. Exiting." ${LOG_FILE} 100
	exit 1
fi

source "$HOME/.guienv"

mkdir -p log

CURRENT_TIME=$(date +%H%M)

DESKTOP_THEME=${KFR_DESKTOP_DARK}
MOUSE_THEME=${KFR_MOUSE_DARK}
CONTROLS_THEME=${KFR_CONTROLS_DARK}
ICONS_THEME=${KFR_ICONS_DARK}
WINDOW_BORDERS_THEME=${KFR_WINDOW_BORDERS_DARK}
WALLPAPER=${KFR_WALLPAPER_DARK}
KITTY_THEME=${KFR_KITTY_DARK_THEME}


if [[ "${CURRENT_TIME}" -ge 0700 ]] && [[ "${CURRENT_TIME}" -lt 1700 ]]; then
	DESKTOP_THEME=${KFR_DESKTOP_LIGHT}
	MOUSE_THEME=${KFR_MOUSE_LIGHT}
	CONTROLS_THEME=${KFR_CONTROLS_LIGHT}
	ICONS_THEME=${KFR_ICONS_LIGHT}
	WINDOW_BORDERS_THEME=${KFR_WINDOW_BORDERS_LIGHT}
	WALLPAPER=${KFR_WALLPAPER_LIGHT}
	KITTY_THEME=${KFR_KITTY_LIGHT_THEME}
fi

# Set the chosen theme
gsettings set org.cinnamon.desktop.interface gtk-theme "'${CONTROLS_THEME}'"
gsettings set org.cinnamon.desktop.interface icon-theme "'${ICONS_THEME}'"
gsettings set org.cinnamon.desktop.interface cursor-theme "'${MOUSE_THEME}'"
gsettings set org.cinnamon.theme name "'${DESKTOP_THEME}'"
gsettings set org.cinnamon.desktop.background picture-uri "'${WALLPAPER}'"
gsettings set org.cinnamon.desktop.wm.preferences theme "'${WINDOW_BORDERS_THEME}'"

kitty +kitten themes --reload-in=all ${KITTY_THEME}

log_info "Cinnamon theme changed to '${DESKTOP_THEME}'. Kitty theme changed to '${KITTY_THEME}'." ${LOG_FILE} 100
