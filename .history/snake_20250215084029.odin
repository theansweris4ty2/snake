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
tail: Vec2i
tail2: Vec2i
move_direction: Vec2i


snake: [MAX_LENGTH]Vec2i
snake_length: int

main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")

	head := Vec2i{GRID_WIDTH / 2, GRID_WIDTH / 2}
	tail := Vec2i{1, 0}
	tail2 := Vec2i{2, 0}
	food_position = {100, 100}
	snake[0] = head
	snake[1] = tail
	snake[2] = tail2

	for !rl.WindowShouldClose() {
		tick_timer := rl.GetFrameTime()
		move_direction = {0, 0}


		if rl.IsKeyDown(.RIGHT) {
			for i in 0 ..< snake_length {

			}
			move_direction = {1, 0}
			tail = {-1, 0}
			tail2 = {-2, 0}


		}
		if rl.IsKeyDown(.LEFT) {
			move_direction = {-1, 0}
			tail = {1, 0}
			tail2 = {2, 0}


		}
		if rl.IsKeyDown(.UP) {
			move_direction = {0, -1}
			tail = {0, 1}
			tail2 = {0, 2}


		}
		if rl.IsKeyDown(.DOWN) {
			move_direction = {0, 1}
			tail = {0, -1}
			tail2 = {0, -2}


		}
		head += move_direction
		rl.SetConfigFlags({.VSYNC_HINT})
		rl.SetTargetFPS(60)
		rl.BeginDrawing()
		rl.ClearBackground({76, 53, 83, 255})

		camera := rl.Camera2D {
			zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		}

		head_rect := rl.Rectangle {
			f32(head.x) * CELL_SIZE,
			f32(head.y) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}
		tail_rect := rl.Rectangle {
			f32(head.x + tail.x) * (CELL_SIZE) + 1,
			f32(head.y + tail.y) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}
		tail2_rect := rl.Rectangle {
			f32(head.x + (tail.x * 2)) * (CELL_SIZE) + 1,
			f32(head.y + (tail.y * 2)) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}

		rl.DrawRectangleRec(head_rect, {0, 255, 0, 255})
		rl.DrawRectangleRec(tail_rect, {255, 0, 0, 255})
		rl.DrawRectangleRec(tail2_rect, {0, 255, 0, 255})

		rl.EndDrawing()
	}
	rl.CloseWindow()

}
