(*
	SVGOdrop 1.0.2
	(c) 2016 Superpixel, Nico Rohrbach
*)

property extension_list : {"svg"}

property pretty_code : true
property remove_title : true
property remove_desc : true

on run
	if isSVGOInstalled() is false then
		beep
		display alert "SVGO seem not to be installed!" message Â
			"Install the tool via \"npm install -g svgo\" and try again." buttons Â
			{"OK"} default button "OK" as critical
		return
	end if
	set these_items to choose file with multiple selections allowed
	check_files(these_items)
end run

on open these_items
	if isSVGOInstalled() is false then
		beep
		display alert "SVGO seem not to be installed!" message Â
			"Install the tool via \"npm install -g svgo\" and try again." buttons Â
			{"OK"} default button "OK" as critical
		return
	end if
	check_files(these_items)
end open

on isSVGOInstalled()
	try
		set temp to do shell script "/bin/bash -l -c 'svgo'"
	on error err_msg number err_num
		if err_num is equal to 127 then
			return false
		else
			return true
		end if
	end try
end isSVGOInstalled

on check_files(these_items)
	repeat with i from 1 to the count of these_items
		set this_item to item i of these_items
		set the item_info to info for this_item
		if folder of the item_info is false then
			try
				set this_extension to the name extension of item_info
			on error
				set this_extension to ""
			end try
			if (this_extension is in the extension_list) then
				process_file(this_item)
			end if
		end if
	end repeat
end check_files

on process_file(this_item)
	set the file_path to the POSIX path of this_item
	-- set options
	set svgo_options to ""
	if pretty_code is true then
		set svgo_options to "--pretty"
	end if
	if remove_title is true then
		set svgo_options to svgo_options & " --enable=removeTitle"
	end if
	if remove_desc is true then
		set svgo_options to svgo_options & " --enable=removeDesc"
	end if
	-- do the job
	try
		do shell script "/bin/bash -l -c 'svgo" & space & svgo_options & space & "\"" & file_path & "\"" & "'"
	on error err_msg number err_num
		beep
		display alert "Error" message err_msg buttons {"OK"} default button "OK" as critical
		return err_num
	end try
end process_file