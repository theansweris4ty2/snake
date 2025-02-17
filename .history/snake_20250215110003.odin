package snake_game

import "core:fmt"
import rl "vendor:raylib"

WINDOW_SIZE :: 1000
GRID_WIDTH :: 20
CELL_SIZE :: 16
CANVAS_SIZE :: GRID_WIDTH / CELL_SIZE
TICK_RATE :: 0.13
tick_timer: f32 = TICK_RATE
Vec2i :: [2]int
MAX_LENGTH :: GRID_WIDTH * GRID_WIDTH
move_direction: Vec2i
game_over: bool


snake: [MAX_LENGTH]Vec2i
snake_length: int

main :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")

	head := Vec2i{GRID_WIDTH / 2, GRID_WIDTH / 2}
	snake[0] = head
	snake[1] = head + {1, 0}
	snake[2] = head + {2, 0}
	snake_length = len(snake)
	move_direction = {-1, 0}

	for !rl.WindowShouldClose() {
		tick_timer -= rl.GetFrameTime()
		next_part_position := snake[0]
		snake[0] += move_direction

		// if tick_timer <= 0 {
		// 	head += move_direction
		// 	tick_timer = TICK_RATE + tick_timer
		// }

		// for i in 1 ..< snake_length {
		// 	cur_pos := snake[i]
		// 	snake[i] = next_part_position
		// 	next_part_position = cur_pos
		// }

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


		rl.SetTargetFPS(60)
		rl.BeginDrawing()
		rl.ClearBackground({76, 53, 83, 255})

		// camera := rl.Camera2D {
		// 	zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		// }

		// rl.BeginMode2D(camera)


		for i in 0 ..< snake_length {
			part_rect := rl.Rectangle {
				f32(snake[i].x) * CELL_SIZE,
				f32(snake[i].y) * CELL_SIZE,
				CELL_SIZE,
				CELL_SIZE,
			}
			rl.DrawRectangleRec(part_rect, rl.WHITE)
		}


		rl.EndDrawing()
	}
	rl.CloseWindow()

}
