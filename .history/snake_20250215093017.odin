package snake_game

import "core:fmt"
import rl "vendor:raylib"

WINDOW_SIZE :: 1000
GRID_WIDTH :: 20
CELL_SIZE :: 16
CANVAS_SIZE :: GRID_WIDTH / CELL_SIZE
TICK_RATE :: 0.13
Vec2i :: [2]int
MAX_LENGTH :: GRID_WIDTH * GRID_WIDTH

move_direction: Vec2i
game_over: bool


snake: [MAX_LENGTH]Vec2i
snake_length: int

main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")

	head := Vec2i{GRID_WIDTH / 2, GRID_WIDTH / 2}
	tail := Vec2i{1, 0}
	tail2 := Vec2i{2, 0}
	snake[0] = head
	snake[1] = head - {1, 0}
	snake[2] = head - {2, 0}
	snake_length = len(snake)

	for !rl.WindowShouldClose() {
		tick_timer := rl.GetFrameTime()
		move_direction = {0, 0}
		next_part_position := snake[0]
		snake[0] += move_direction

		for i in 0 ..< snake_length {
			cur_pos := snake[i]
			snake[i] = next_part_position
			next_part_position = cur_pos
		}


		if rl.IsKeyDown(.RIGHT) {
			move_direction = {1, 0}

		}

		if rl.IsKeyDown(.LEFT) {
			move_direction = {-1, 0}
		}
		if rl.IsKeyDown(.UP) {
			move_direction = {0, -1}
		}
		if rl.IsKeyDown(.DOWN) {
			move_direction = {0, 1}
		}

		rl.SetConfigFlags({.VSYNC_HINT})
		rl.SetTargetFPS(60)
		rl.BeginDrawing()
		rl.ClearBackground({76, 53, 83, 255})

		camera := rl.Camera2D {
			zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		}


		for i in 0 ..< snake_length {
			rl.DrawRectangleRec(
				rl.Rectangle {
					f32(snake[i].x) * CELL_SIZE,
					f32(snake[i].y) * CELL_SIZE,
					CELL_SIZE,
					CELL_SIZE,
				},
				{0, 255, 0, 255},
			)

		}
		// rl.DrawRectangleRec(head_rect, {0, 255, 0, 255})
		// rl.DrawRectangleRec(tail_rect, {255, 0, 0, 255})
		// rl.DrawRectangleRec(tail2_rect, {0, 255, 0, 255})

		rl.EndDrawing()
	}
	rl.CloseWindow()

}
