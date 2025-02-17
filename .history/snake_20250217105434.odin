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
food_timer: int = 0
Vec2i :: [2]int
head_pos: Vec2i
move_direction: Vec2i
is_game_over: bool
snake: [MAX_LENGTH]Vec2i
snake_food: [dynamic]rl.Rectangle
snake_length: int
food: rl.Rectangle
score: int
new_snake_part: bool


main :: proc() {
	rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")
	rl.SetConfigFlags({.VSYNC_HINT})
	rl.InitAudioDevice()
	eating_sound := rl.LoadSound("rsc/eat.wav")
	// game_over_sound := rl.LoadSound("rsc/game_over.wav")


	for !rl.WindowShouldClose() {


		food_timer += 1
		i: int = 0
		if food_timer %% 10000 == 0 {
			if i < 5 {i += 1
				append(&snake_food, place_food())
			}
		}
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
		if !is_game_over {

			tick_timer -= rl.GetFrameTime()
		}

		if tick_timer <= 0 {
			snake[0] += move_direction
			head_pos = snake[0]

			if head_pos.x < 0 ||
			   head_pos.y < 0 ||
			   head_pos.x >= GRID_WIDTH ||
			   head_pos.y >= GRID_WIDTH {
				is_game_over = true
			}

			for i in 1 ..< snake_length - 1 {
				if snake[i] == head_pos {
					is_game_over = true
				}
			}

			for i in 1 ..< snake_length {
				cur_pos := snake[i]
				snake[i] = next_part_position
				next_part_position = cur_pos
			}

			for i in 0 ..< len(snake_food) {
				if rl.CheckCollisionRecs(
					snake_food[i],
					rl.Rectangle {
						f32(snake[i].x) * CELL_SIZE,
						f32(snake[i].y) * CELL_SIZE,
						CELL_SIZE,
						CELL_SIZE,
					},
				) {
					rl.PlaySound(eating_sound)
					snake_length += 1
					snake[snake_length - 1] = next_part_position

					ordered_remove(&snake_food, i)
					score += 1


				}

			}

			tick_timer = tick_rate + tick_timer

		}


		rl.BeginDrawing()
		rl.ClearBackground({76, 53, 83, 255})
		rl.DrawText(rl.TextFormat("Score: %8i", score), 0, 0, 25, rl.WHITE)

		camera := rl.Camera2D {
			zoom = f32(WINDOW_SIZE) / CANVAS_SIZE,
		}

		rl.BeginMode2D(camera)


		if !is_game_over {
			for i in 0 ..< snake_length {
				snake_part_rect := rl.Rectangle {
					f32(snake[i].x) * CELL_SIZE,
					f32(snake[i].y) * CELL_SIZE,
					CELL_SIZE,
					CELL_SIZE,
				}

				rl.DrawRectangleRec(snake_part_rect, rl.GREEN)
				for food in snake_food {
					if len(snake_food) > 0 {
						rl.DrawRectangleRec(food, rl.RED)
					}
				}

			}

		} else {
			// rl.PlaySound(game_over_sound)
			game_over()
		}


		rl.EndMode2D()
		rl.EndDrawing()
	}
	rl.UnloadSound(eating_sound)
	rl.UnloadSound(game_over_sound)
	rl.CloseAudioDevice()
	rl.CloseWindow()

}
