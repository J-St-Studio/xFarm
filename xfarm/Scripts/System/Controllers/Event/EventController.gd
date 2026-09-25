class_name EventController extends Controller

# input event signals
signal input_escape_pressed
signal input_up_pressed
signal input_down_pressed
signal input_left_pressed
signal input_input_right_pressed
signal input_confirm_pressed
signal input_left_mouse_pressed
signal input_right_mouse_pressed

# game event signals
signal game_paused
signal game_unpaused
signal game_over
signal game_set_control_type
signal game_spawn_player
signal game_go_to_main_menu
signal game_start_game
signal game_generate_world

func BroadcastStartGame() -> void:
	game_start_game.emit()

func BroadcastGameGenerateWorld() -> void:
	game_generate_world.emit()
