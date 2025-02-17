package snake_game

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

restart :: proc() {

	start_head_pos := Vec2i{GRID_WIDTH / 2, GRID_WIDTH / 2}
	snake[0] = start_head_pos
	snake[1] = start_head_pos + {1, 0}
	snake[2] = start_head_pos + {2, 0}
	snake_length = 3
	cur_index = 2
	move_direction = {0, 1}
	is_game_over = false


}
game_over :: proc() {

	rl.DrawText("GAME OVER", 100, 100, 20, rl.RED)
	rl.DrawText("Push Enter to Start New Game", 80, 125, 10, rl.RED)
	score = 0
	if rl.IsKeyPressed(.ENTER) {
		restart()
	}
}

place_food :: proc() -> rl.Rectangle {
	choices: [15]int = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15}
	food_location: Vec2i
	food_location = {rand.choice(choices[:]), rand.choice(choices[:])}
	food_pellet := rl.Rectangle {
		f32(food_location.x) * CELL_SIZE,
		f32(food_location.y) * CELL_SIZE,
		CELL_SIZE / 2,
		CELL_SIZE / 2,
	}
	return food_pellet
}

eat_food :: proc() {
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
			new_snake_part: Vec2i = snake[cur_index] + move_direction
			ordered_remove(&snake_food, i)
			score += 1
			snake[cur_index + 1] = new_snake_part
			fmt.println(snake[3])
			fmt.println(snake[1])
			cur_index += 1
		}
	}
}
