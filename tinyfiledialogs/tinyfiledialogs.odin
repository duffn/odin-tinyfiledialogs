package tinyfiledialogs

import "base:builtin"
import "core:c"
import win32 "core:sys/windows"

when ODIN_OS == .Darwin {
	foreign import lib "./macos-arm64/tinyfiledialogs.a"
} else when ODIN_OS == .Linux {
	// TODO: this is completely untested.
	foreign import lib "./linux/tinyfiledialogs.a"

} else when ODIN_OS == .Windows {
	#panic("Windows not supported yet")
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
	// TODO: this doesn't work.
	// colorChooser :: proc(aTitle: cstring, aDefaultHexRGB: cstring, aDefaultRGB: [^]u8, aoResultRGB: [^]u8) -> cstring ---

	// TODO: this is completely and utterly untested.
	when ODIN_OS == .Windows {
		winUtf8: c.int

		utf8toMbcs :: proc(aUtf8string: cstring) -> cstring ---
		utf16toMbcs :: proc(aUtf16string: [^]win32.wchar_t) -> cstring ---
		mbcsTo16 :: proc(aMbcsString: cstring) -> [^]win32.wchar_t ---
		mbcsTo8 :: proc(aMbcsString: cstring) -> cstring ---
		utf8to16 :: proc(aUtf8string: cstring) -> [^]win32.wchar_t ---
		utf16to8 :: proc(aUtf16string: [^]win32.wchar_t) -> cstring ---
		// Windows only utf-16 versions
		notifyPopupW :: proc(aTitle: [^]win32.wchar_t, aMessage: [^]win32.wchar_t, aIconType: [^]win32.wchar_t) -> c.int ---
		messageBoxW :: proc(aTitle: [^]win32.wchar_t, aMessage: [^]win32.wchar_t, aDialogType: [^]win32.wchar_t, aIconType: [^]win32.wchar_t, aDefaultButton: c.int) -> c.int ---
		inputBoxW :: proc(aTitle: [^]win32.wchar_t, aMessage: [^]win32.wchar_t, aDefaultInput: [^]win32.wchar_t) -> [^]win32.wchar_t ---
		saveFileDialogW :: proc(aTitle: [^]win32.wchar_t, aDefaultPathAndOrFile: [^]win32.wchar_t, aNumOfFilterPatterns: c.int, aFilterPatterns: [^][^]win32.wchar_t, aSingleFilterDescription: [^]win32.wchar_t) -> [^]win32.wchar_t ---
		openFileDialogW :: proc(aTitle: [^]win32.wchar_t, aDefaultPathAndOrFile: [^]win32.wchar_t, aNumOfFilterPatterns: c.int, aFilterPatterns: [^][^]win32.wchar_t, aSingleFilterDescription: [^]win32.wchar_t, aAllowMultipleSelects: c.int) -> [^]win32.wchar_t ---
		selectFolderDialogW :: proc(aTitle: [^]win32.wchar_t, aDefaultPath: [^]win32.wchar_t) -> [^]win32.wchar_t ---
		// TODO: this doesn't work.
		// colorChooserW :: proc(aTitle: [^]win32.wchar_t, aDefaultHexRGB: [^]win32.wchar_t, aDefaultRGB: [3]c.uchar, aoResultRGB: [3]c.uchar) -> win32.wchar_t ---
	}
}
