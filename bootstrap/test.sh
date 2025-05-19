#! /bin/env bash

set -x

post-install() {
	local wm=$1
	
	local stow_wm_dir="$HOME/.dotfiles/stow-wm"
	local stow_dir="$HOME/.dotfiles/stow"
	
	local old_pwd=$(pwd)
	cd $stow_dir
	
	case $wm in
		"i3") stow -v -d $stow_wm_dir -t $HOME i3 ;; 
		"hyprland") stow -v -d $stow_wm_dir -t $HOME hyprland
	esac

	stow -v -d $stow_dir -t $HOME/test *

	cd $old_pwd
}

post-install $1
