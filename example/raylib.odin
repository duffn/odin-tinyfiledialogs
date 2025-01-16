package example

import tfd "../tinyfiledialogs"
import "core:fmt"
import "core:thread"
import rl "vendor:raylib"

BUTTON_WIDTH :: 140
BUTTON_HEIGHT :: 70
BUTTON_WIDTH_HALF :: BUTTON_WIDTH / 2
BUTTONS_START_Y :: 75

color_picked: bool = false
picked_color: cstring
t: ^thread.Thread

color_chooser_open :: proc(t: ^thread.Thread) {
	default_color := raw_data([]u8{0, 128, 128})
	return_color := raw_data([]u8{0, 0, 0})
	picked_color = tfd.colorChooser("Color Chooser", nil, default_color, return_color)
	if picked_color != nil {
		color_picked = true
	}
}

main :: proc() {
	rl.InitWindow(800, 600, "odin-tinyfiledialogs example")
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

		// Save file dialog
		if rl.GuiButton(
			{
				f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
				BUTTONS_START_Y + 300,
				BUTTON_WIDTH,
				BUTTON_HEIGHT,
			},
			"Save File Dialog",
		) {
			ret := tfd.saveFileDialog(
				"Save File Dialog",
				nil,
				2,
				raw_data([]cstring{"*.png", "*.txt"}),
				nil,
			)
			fmt.printfln("You saved to this file: %s", ret)
		}

		// Color picker
		// Note that the color picker only opens in a new thread otherwise it blocks up the app.
		if rl.GuiButton(
			{
				f32(rl.GetScreenWidth()) / 2 - BUTTON_WIDTH_HALF,
				BUTTONS_START_Y + 375,
				BUTTON_WIDTH,
				BUTTON_HEIGHT,
			},
			"Color Picker",
		) {
			t = thread.create(color_chooser_open)
			if t != nil {
				t.init_context = context
				thread.start(t)
			}
		}
		if t != nil && thread.is_done(t) {
			thread.destroy(t)
		}
		if (color_picked) {
			fmt.printfln("You picked this color: %s", picked_color)
			color_picked = false
		}

		rl.EndDrawing()
	}
}
