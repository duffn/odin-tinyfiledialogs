package example

import tfd "../tinyfiledialogs"
import "core:c"
import "core:fmt"
import rl "vendor:raylib"

BUTTON_WIDTH :: 140
BUTTON_HEIGHT :: 48
BUTTON_WIDTH_HALF :: BUTTON_WIDTH / 2
BUTTON_HEIGHT_HALF :: BUTTON_HEIGHT / 2
BUTTONS_START_Y :: 100

main :: proc() {
	fmt.printfln("tinyfiledialogs version: %s", tfd.version)

	rl.InitWindow(800, 600, "tinyfiledialogs")
	rl.SetTargetFPS(60)

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)

		if rl.GuiButton(
			{
				f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
				BUTTONS_START_Y,
				BUTTON_WIDTH,
				BUTTON_HEIGHT,
			},
			"Beep",
		) {
			tfd.beep()
		}

		// Message Box
		if rl.GuiButton(
			{
				f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
				BUTTONS_START_Y + 75,
				BUTTON_WIDTH,
				BUTTON_HEIGHT,
			},
			"Message Box",
		) {
			ret := tfd.messageBox("Message Box", "Message", "okcancel", "info", 0)
			fmt.printfln("Message box response: %d", ret)
		}

		// Message Box
		if rl.GuiButton(
			{
				f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
				BUTTONS_START_Y + 150,
				BUTTON_WIDTH,
				BUTTON_HEIGHT,
			},
			"Input Box",
		) {
			ret := tfd.inputBox("Input Box", "Input", "")
			fmt.printfln("You typed: %s", ret)
		}

		// Open file dialog
		if rl.GuiButton(
			{
				f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
				BUTTONS_START_Y + 225,
				BUTTON_WIDTH,
				BUTTON_HEIGHT,
			},
			"Open File Dialog",
		) {
			ret := tfd.openFileDialog(
				"Open File Dialog",
				nil,
				2,
				raw_data([]cstring{"*.png", "*.txt"}),
				nil,
				0,
			)
			fmt.printfln("You chose this file: %s", ret)
		}

		// Color picker
		// TODO: this doesn't work yet.
		// if rl.GuiButton(
		// 	{
		// 		f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
		// 		BUTTONS_START_Y + 300,
		// 		BUTTON_WIDTH,
		// 		BUTTON_HEIGHT,
		// 	},
		// 	"Color Picker",
		// ) {
		// 	ret := tfd.colorChooser(
		// 		"Color Picker",
		// 		nil,
		// 		raw_data([]u8{0, 128, 128}),
		// 		raw_data([]u8{0, 0, 0}),
		// 	)
		// 	fmt.printfln("You picked this color: %s", ret)
		// }

		rl.EndDrawing()
	}

	rl.CloseWindow()
}
