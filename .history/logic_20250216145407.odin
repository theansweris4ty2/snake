package snake_game

import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

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
	choices: [4]int = {1, 2, 3, 4}
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
