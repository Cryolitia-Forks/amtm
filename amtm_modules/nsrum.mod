#!/bin/sh
#bof
nsrum_installed(){
	scriptname='NVRAM Save/Restore Utility'
	localVother="v$(grep "^VERSION=" "$scriptloc" | sed -e 's/VERSION=//;s/"//g')"
	if [ "$su" = 1 ]; then
		remoteurl="https://raw.githubusercontent.com/Xentrk/nvram-save-restore-utility/master/nsrum"
		remoteVother="v$(c_url "$remoteurl" | grep "^VERSION=" | sed -e 's/VERSION=//;s/"//g')"
		grepcheck=Xentrk
	fi
	script_check
	if [ -z "$su" -a -z "$tpu" ] && [ "$NVRAM_Save_Restore_UtilityUpate" ]; then
		localver="$lvtpu"
		upd="${E_BG}$NVRAM_Save_Restore_UtilityUpate${NC}"
		if [ "$NVRAM_Save_Restore_UtilityMD5" != "$(md5sum "$scriptloc" | awk '{print $1}')" ]; then
			sed -i '/^NVRAM_Save_Restore_Utility.*/d' "${add}"/availUpd.txt
			upd="${E_BG}${NC}$lvtpu"
			unset localver NVRAM_Save_Restore_UtilityUpate NVRAM_Save_Restore_UtilityMD5
		fi
	fi
	[ -z "$updcheck" ] && printf "${GN_BG} 8 ${NC} %-9s%-21s%${COR}s\\n" "open" "nsrum         $localver" " $upd"
	case_8(){
		/jffs/scripts/nsrum
		sleep 2
		show_amtm menu
	}
}
install_nsrum(){
	version_check(){ echo "$@" | awk -F. '{ printf("%d%03d%03d%03d\n", $1,$2,$3,$4); }';}
	if [ "$(version_check $(nvram get buildno))" -gt "$(version_check 384.19)" ]; then
		am=;show_amtm " ! This router runs on $(nvram get buildno) firmware.\\n nsrum is deprecated and only available for\\n routers running on outdated 384.XX or older\\n firmware.\\n\\n Installation aborted."
	fi
	p_e_l
	echo " This installs nsrum - NVRAM Save/Restore Utility"
	echo " on your router."
	echo
	echo " Author: Xentrk"
	echo " https://www.snbforums.com/forums/asuswrt-merlin-addons.60/?prefix_id=28"
	c_d

	c_url "https://raw.githubusercontent.com/Xentrk/nvram-save-restore-utility/master/nsrum" -o "/jffs/scripts/nsrum" && sleep 5 && chmod 755 /jffs/scripts/nsrum && sh /jffs/scripts/nsrum
	sleep 2
	if [ -f /jffs/scripts/nsrum ]; then
		show_amtm " nsrum NVRAM Save/Restore Utility installed"
	else
		am=;show_amtm " nsrum NVRAM Save/Restore Utility installation failed"
	fi
}
#eof
