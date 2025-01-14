package example

import tfd "../tinyfiledialogs"
import "core:c"
import "core:flags"
import "core:fmt"
import "core:os"

Example_Type :: enum {
	beep,
	version,
	messagebox,
	colorchooser,
	input,
	openfile,
	savefile,
}

Options :: struct {
	type: Example_Type `usage:"Type of example to run"`,
}

main :: proc() {
	opt: Options
	style: flags.Parsing_Style = .Odin
	flags.parse_or_exit(&opt, os.args, style)

	switch opt.type {
	case .beep:
		tfd.beep()
	case .version:
		fmt.printfln("tinyfiledialogs version: %s", tfd.version)
	case .messagebox:
		ret := tfd.messageBox("Message Box", "Message", "okcancel", "info", 0)
		fmt.printfln("Message box response: %d", ret)
	case .colorchooser:
		default_color := []c.uchar{128, 128, 128}
		return_color := []c.uchar{0, 0, 0}
		ret := tfd.colorChooser(
			"Color Picker",
			nil,
			raw_data(default_color),
			raw_data(return_color),
		)
		fmt.printfln("You picked this color in hex: %s", ret)
		fmt.printfln("You picked this color in rgb: %v", return_color)
	case .input:
		ret := tfd.inputBox("Input Box", "Input", "")
		fmt.printfln("You typed: %s", ret)
	case .openfile:
		ret := tfd.openFileDialog(
			"Open File Dialog",
			nil,
			2,
			raw_data([]cstring{"*.png", "*.txt"}),
			nil,
			0,
		)
		fmt.printfln("You chose this file: %s", ret)
	case .savefile:
		ret := tfd.saveFileDialog(
			"Save File Dialog",
			nil,
			2,
			raw_data([]cstring{"*.png", "*.txt"}),
			nil,
		)
		fmt.printfln("You saved to this file: %s", ret)
	}
}
