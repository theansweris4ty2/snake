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
food_position: Vec2i

snake: [MAX_LENGTH]Vec2i
snake_length: int

main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")

	head := Vec2i{GRID_WIDTH / 2, GRID_WIDTH / 2}
	food_position = {100, 100}
	snake[0] = head
	snake[1] = tail
	snake[2] = tail2

	for !rl.WindowShouldClose() {
		tick_timer := rl.GetFrameTime()
		move_direction = {0, 0}


		if rl.IsKeyDown(.RIGHT) {
			move_direction = {1, 0}
			snake[1] = {-1, 0}
			snake[2] = {-2, 0}


		}
		if rl.IsKeyDown(.LEFT) {
			move_direction = {-1, 0}
			snake[1] = {1, 0}
			snake[2] = {2, 0}


		}
		if rl.IsKeyDown(.UP) {
			move_direction = {0, -1}
			snake[1] = {0, 1}
			snake[2] = {0, 2}


		}
		if rl.IsKeyDown(.DOWN) {
			move_direction = {0, 1}
			snake[1] = {0, -1}
			snake[2] = {0, -2}


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
			f32(snake[0].x + snake[1].x) * (CELL_SIZE) + 1,
			f32(snake[0].y + snake[1].y) * CELL_SIZE,
			CELL_SIZE,
			CELL_SIZE,
		}
		tail2_rect := rl.Rectangle {
			f32(snake[0].x + (snake[1].x * 2)) * (CELL_SIZE) + 1,
			f32(head.y + (tail.y * 2)) * CELL_SIZE,
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
