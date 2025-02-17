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
snake_head_position: Vec2i
tail_position: Vec2i
tail2_position: Vec2i
move_direction: Vec2i
food_position: Vec2i


main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")

	snake_head_position = {GRID_WIDTH / 2, GRID_WIDTH / 2}
	food_position = {100, 100}

	for !rl.WindowShouldClose() {
		tick_timer := rl.GetFrameTime()
		move_direction = {0, 0}


		if rl.IsKeyDown(.RIGHT) {
			move_direction = {1, 0}
			tail_position = {-1, 0}
			tail2_position = {-2, 0}


		}
		if rl.IsKeyDown(.LEFT) {
			move_direction = {-1, 0}
			tail_position = {1, 0}
			tail2_position = {2, 0}


		}
		if rl.IsKeyDown(.UP) {
			move_direction = {0, -1}
			tail_position = {0, 1}
			tail2_position = {0, 2}


		}
		if rl.IsKeyDown(.DOWN) {
			move_direction = {0, 1}
			tail_position = {0, -1}
			tail2_position = {0, -2}


		}
		snake_head_position += move_direction
		rl.SetConfigFlags({.VSYNC_HINT})
		rl.SetTargetFPS(60)
		rl.BeginDrawing()
		rl.ClearBackground({76, 53, 83, 255})

		camera := rl.Camera2D {
			zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		}

		head_rect := rl.Rectangle {
			f32(snake_head_position.x) * CELL_SIZE,
			f32(snake_head_position.y) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}
		tail_rect := rl.Rectangle {
			f32(snake_head_position.x + tail_position.x) * (CELL_SIZE) + 1,
			f32(snake_head_position.y + tail_position.y) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}
		tail2_rect := rl.Rectangle {
			f32(snake_head_position.x + (tail_position.x * 2)) * (CELL_SIZE) + 1,
			f32(snake_head_position.y + (tail_position.y * 2)) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}
		food_rect := rl.Rectangle{f32(food_position.x), f32(food_position.y), CELL_SIZE, CELL_SIZE}

		rl.DrawRectangleRec(head_rect, {0, 255, 0, 255})
		rl.DrawRectangleRec(tail_rect, {255, 0, 0, 255})
		rl.DrawRectangleRec(tail2_rect, {0, 255, 0, 255})
		rl.DrawRectangleRec(food_rect, {255, 0, 0, 255})

		rl.EndDrawing()
	}
	rl.CloseWindow()

}
