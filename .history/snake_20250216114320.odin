package snake_game


import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

WINDOW_SIZE :: 1000
GRID_WIDTH :: 20
CELL_SIZE :: 16
CANVAS_SIZE :: GRID_WIDTH * CELL_SIZE
MAX_LENGTH :: GRID_WIDTH * GRID_WIDTH
tick_rate: f32 = 0.15
tick_timer := tick_rate
Vec2i :: [2]int
move_direction: Vec2i
is_game_over: bool
snake: [MAX_LENGTH]Vec2i
snake_length: int

restart :: proc() {

	start_head_pos := Vec2i{GRID_WIDTH / 2, GRID_WIDTH / 2}
	snake[0] = start_head_pos
	snake[1] = start_head_pos + {1, 0}
	snake[2] = start_head_pos + {2, 0}
	snake_length = len(snake)
	move_direction = {0, 1}
	is_game_over = false
}
game_over :: proc() {

	rl.DrawText("GAME OVER", 100, 100, 20, rl.RED)
	rl.DrawText("Push Enter to Start New Game", 80, 125, 10, rl.RED)
	if rl.IsKeyPressed(.ENTER) {
		restart()
	}
}
place_food :: proc() -> rl.Rectangle {
	choices := {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
	food_pellet := rl.Rectangle
	food_pellet.x := choice(choices) * CELL_SIZE
	food_pellet.y := choice(choices) * CELL_SIZE
	food_pellet.width = CELL_SIZE
	food_pellet.height = CELL_SIZE
	return food_pellet
}

main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")
	rl.SetConfigFlags({.VSYNC_HINT})

	restart()


	for !rl.WindowShouldClose() {
		next_part_position := snake[0]

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

		tick_timer -= rl.GetFrameTime()

		if tick_timer <= 0 {
			snake[0] += move_direction
			head_pos := snake[0]

			if head_pos.x < 0 ||
			   head_pos.y < 0 ||
			   head_pos.x >= GRID_WIDTH ||
			   head_pos.y >= GRID_WIDTH {
				is_game_over = true
			}

			tick_timer = tick_rate + tick_timer
		}
		for i in 1 ..< snake_length {
			cur_pos := snake[i]
			snake[i] = next_part_position
			next_part_position = cur_pos
		}


		rl.BeginDrawing()
		rl.ClearBackground({76, 53, 83, 255})

		camera := rl.Camera2D {
			zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		}

		rl.BeginMode2D(camera)
		food := place_food()

		if !is_game_over {
			for i in 0 ..< snake_length {
				snake_part_rect := rl.Rectangle {
					f32(snake[i].x) * CELL_SIZE,
					f32(snake[i].y) * CELL_SIZE,
					CELL_SIZE,
					CELL_SIZE,
				}

				rl.DrawRectangleRec(snake_part_rect, rl.WHITE)
				rl.DrawRectangleRec(food, rl.RED)

			}
		} else {
			game_over()
		}


		rl.EndMode2D()
		rl.EndDrawing()
	}
	rl.CloseWindow()

}
