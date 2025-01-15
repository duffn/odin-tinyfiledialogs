package example

import tfd "../tinyfiledialogs"
import "core:c"
import "core:flags"
import "core:fmt"
import "core:os"
import win32 "core:sys/windows"

Windows_Example_Type :: enum {
	beep,
	version,
	messagebox,
	colorchooser,
	input,
	openfile,
	savefile,
}

Windows_Options :: struct {
	type: Windows_Example_Type `usage:"Type of example to run"`,
}

main :: proc() {
	opt: Windows_Options
	style: flags.Parsing_Style = .Odin
	flags.parse_or_exit(&opt, os.args, style)

	switch opt.type {
	case .beep:
		tfd.beep()
	case .version:
		fmt.printfln("tinyfiledialogs version: %s", tfd.version)
	case .messagebox:
		ret := tfd.messageBoxW(
			win32.L("Message Box"),
			win32.L("Message"),
			win32.L("okcancel"),
			win32.L("info"),
			0,
		)
		fmt.printfln("Message box response: %d", ret)
	case .colorchooser:
		default_color := []c.uchar{128, 128, 128}
		return_color := []c.uchar{0, 0, 0}
		ret := tfd.colorChooserW(
			win32.L("Color Picker"),
			nil,
			raw_data(default_color),
			raw_data(return_color),
		)
		fmt.printfln("You picked this color in hex: %s", ret)
		fmt.printfln("You picked this color in rgb: %v", return_color)
	case .input:
		ret := tfd.inputBoxW(win32.L("Input Box"), win32.L("Input"), win32.L(""))
		fmt.printfln("You typed: %s", ret)
	case .openfile:
		filters := raw_data([]win32.wstring{win32.L("*.png"), win32.L("*.jpg")})
		ret := tfd.openFileDialogW(win32.L("Open File Dialog"), nil, 2, filters, nil, 0)
		fmt.printfln("You chose this file: %s", ret)
	case .savefile:
		filters := raw_data([]win32.wstring{win32.L("*.png"), win32.L("*.jpg")})
		ret := tfd.saveFileDialogW(win32.L("Save File Dialog"), nil, 2, filters, nil)
		fmt.printfln("You saved to this file: %s", ret)
	}
}
