package tinyfiledialogs

import "base:builtin"
import "core:c"

when ODIN_OS == .Darwin {
	foreign import lib "./macos-arm64/tinyfiledialogs.a"
} else when ODIN_OS == .Linux {
	// TODO: this is completely untested.
	foreign import lib "./linux/tinyfiledialogs.a"
} else when ODIN_OS == .Windows {
	foreign import lib {"./windows/tinyfiledialogs.lib", "system:User32.lib", "system:Shell32.lib", "system:Comdlg32.lib", "system:Ole32.lib"}
}


@(default_calling_convention = "c")
@(link_prefix = "tinyfd_")
foreign lib {
	version: [8]c.char
	needs: []c.char
	verbose: c.int
	silent: c.int
	allowCursesDialogs: c.int
	foceConsole: c.int
	assumeGraphicDisplay: c.int
	response: [1024]c.char

	beep :: proc() ---
	notifyPopup :: proc(aTitle: cstring, aMessage: cstring, aIconType: cstring) -> c.int ---
	messageBox :: proc(aTitle: cstring, aMessage: cstring, aDialogType: cstring, aIconType: cstring, aDefaultButton: c.int) -> c.int ---
	inputBox :: proc(aTitle: cstring, aMessage: cstring, aDefaultInput: cstring) -> cstring ---
	saveFileDialog :: proc(aTitle: cstring, aDefaultPathAndOrFile: cstring, aNumOfFilterPatterns: c.int, aFilterPatterns: [^]cstring, aSingleFilterDescription: cstring) -> cstring ---
	openFileDialog :: proc(aTitle: cstring, aDefaultPathAndOrFile: cstring, aNumOfFilterPatterns: c.int, aFilterPatterns: [^]cstring, aSingleFilterDescription: cstring, aAllowMultipleSelects: c.int) -> cstring ---
	selectFolderDialog :: proc(aTitle: cstring, aDefaultPath: cstring) -> cstring ---
	colorChooser :: proc(aTitle: cstring, aDefaultHexRGB: cstring, aDefaultRGB: [^]c.uchar, aoResultRGB: [^]c.uchar) -> cstring ---
}
