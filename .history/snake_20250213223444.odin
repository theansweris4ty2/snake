package snake_game

import "core:fmt"
import rl "vendor:raylib"

WINDOW_SIZE :: 1000
GRID_WIDTH :: 20
CELL_SIZE :: 16
TICK_RATE :: 0.13
Vec2i ::[2]int
snake_head_position: Vec2i
move_direction: Vec2i
tale_position: Vec2i
main :: proc(){
    rl.InitWindow(WINDOW_SIZE, WINDOW_SIZE, "Snake")

    snake_head_position = {GRID_WIDTH / 2, GRID_WIDTH / 2}
    move_direction = {0,0}
    tail_position = {0,0}

    for !rl.WindowShouldClose(){
        tick_timer := rl.GetFrameTime();
        
        move_direction = {0,0}
        tail_position = {0,0}

        if rl.IsKeyDown(.RIGHT){
            move_direction = {1, 0}
            tail_position = {1, 0}
        }
        if rl.IsKeyDown(.LEFT){
            move_direction = {-1, 0}
            tail_position = {-1, 0}
        }
        if rl.IsKeyDown(.UP){
            move_direction = {0, -1}
            tail_position = {0, 1}
        }
        if rl.IsKeyDown(.DOWN){
            move_direction = {0, 1}
            tail_position = {0, -1}
        }
        snake_head_position += move_direction
        rl.SetConfigFlags({.VSYNC_HINT})
        rl.SetTargetFPS(60)
        rl.BeginDrawing()
        rl.ClearBackground({76, 53, 83, 255})
        
        head_rect := rl.Rectangle{f32(snake_head_position.x)*CELL_SIZE,f32( snake_head_position.y)*CELL_SIZE, CELL_SIZE, CELL_SIZE}
        tail_rect := rl.Rectangle{f32(snake_head_position.x)*(CELL_SIZE)+1,f32( snake_head_position.y)*CELL_SIZE, CELL_SIZE, CELL_SIZE}

        
        rl.DrawRectangleRec(head_rect, {0, 255, 0, 255})
        rl.DrawRectangleRec(tail_rect, {0, 255, 0, 255})


        rl.EndDrawing()
    }
    rl.CloseWindow()
}