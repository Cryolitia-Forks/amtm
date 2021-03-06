#!/bin/sh
#bof
scmerlin_installed(){
	scriptname=scMerlin
	scriptgrep=' SCRIPT_VERSION=\| SCM_VERSION='
	if [ "$su" = 1 ]; then
		remoteurl="https://raw.githubusercontent.com/jackyaz/scMerlin/master/scmerlin.sh"
		grepcheck=jackyaz
	fi
	script_check
	if [ -z "$su" -a -z "$tpu" ] && [ "$scMerlinUpate" ]; then
		localver="$lvtpu"
		upd="${E_BG}$scMerlinUpate${NC}"
		if [ "$scMerlinMD5" != "$(md5sum "$scriptloc" | awk '{print $1}')" ]; then
			sed -i '/^scMerlin.*/d' "${add}"/availUpd.txt
			upd="${E_BG}${NC}$lvtpu"
			unset localver scMerlinUpate scMerlinMD5
		fi
	fi
	printf "${GN_BG} j3${NC} %-9s%-21s%${COR}s\\n" "open" "scMerlin      $localver" " $upd"
	case_j3(){
		trap trap_ctrl 2
		trap_ctrl(){
			sleep 2
			exec "$0"
		}
		/jffs/scripts/scmerlin
		trap - 2
		sleep 2
		show_amtm menu
	}
}
install_scmerlin(){
	p_e_l
	echo " This installs scMerlin - service and script control menu for AsusWRT-Merlin"
	echo " on your router."
	echo
	echo " Author: Jack Yaz"
	echo " https://www.snbforums.com/forums/asuswrt-merlin-addons.60/"
	c_d

	c_url "https://raw.githubusercontent.com/jackyaz/scmerlin/master/scmerlin.sh" -o "/jffs/scripts/scmerlin" && chmod 0755 /jffs/scripts/scmerlin && /jffs/scripts/scmerlin install
	sleep 2
	if [ -f /jffs/scripts/scmerlin ]; then
		show_amtm " scMerlin installed"
	else
		am=;show_amtm " scMerlin installation failed"
	fi
}
#eof
