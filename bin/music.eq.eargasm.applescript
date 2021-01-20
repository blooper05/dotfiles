tell application "Music"
	activate
	set newPreset to make new EQ preset
	set name of newPreset to "Eargasm Explosion (Limiter ver.)"
	set band 1 of newPreset to -4.1
	set band 2 of newPreset to -1.1
	set band 3 of newPreset to 1.9
	set band 4 of newPreset to -0.1
	set band 5 of newPreset to -1.1
	set band 6 of newPreset to -2.1
	set band 7 of newPreset to -0.1
	set band 8 of newPreset to -3.1
	set band 9 of newPreset to 3.9
	set band 10 of newPreset to 0.9
	set preamp of newPreset to 0
	set current EQ preset to newPreset
end tell
