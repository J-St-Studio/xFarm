class_name EventController extends Controller

var LC = System.GetLogController()

# input event signals
signal input_escape_pressed
signal input_confirm_pressed
signal input_up_pressed
signal input_down_pressed
signal input_left_pressed
signal input_right_pressed
signal input_input_right_pressed
signal input_left_mouse_pressed
signal input_right_mouse_pressed

# Input Signals
func BroadcastInputEscapePressed() -> void:
	LC.message(self, "escape pressed")
	input_escape_pressed.emit()

func BroadcastInputUpPressed() -> void:
	LC.message(self, "up pressed")
	input_up_pressed.emit()

func BroadcastInputDownPressed() -> void:
	LC.message(self, "down pressed")
	input_down_pressed.emit()

func BroadcastInputLeftPressed() -> void:
	LC.message(self, "left pressed")
	input_left_pressed.emit()

func BroadcastInputRightPressed() -> void:
	LC.message(self, "right pressed")
	input_right_pressed.emit()

func BroadcastInputConfirmPressed() -> void:
	LC.message(self, "confirm pressed")
	input_confirm_pressed.emit()

func BroadcastInputLeftMousePressed() -> void:
	LC.message(self, "left mouse pressed")
	input_left_mouse_pressed.emit()

func BroadcastInputRightMousePressed() -> void:
	LC.message(self, "right mouse pressed")
	input_right_mouse_pressed.emit()

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
	LC.message(self, "start game")
	game_start_game.emit()

func BroadcastGameGenerateWorld() -> void:
	LC.message(self, "generate world")
	game_generate_world.emit()

func BroadcastGamePaused() -> void:
	LC.message(self, "game paused")
	game_paused.emit()

func BroadcastGameUnpaused() -> void:
	LC.message(self, "game unpaused")
	game_unpaused.emit()

func BroadcastGameOver() -> void:
	LC.message(self, "game over")
	game_over.emit()

func BroadcastGameSetControlType() -> void:
	LC.message(self, "game set control type")
	game_set_control_type.emit()

func BroadcastGameSpawnPlayer() -> void:
	LC.message(self, "spawn player")
	game_spawn_player.emit()

func BroadcastGameGoToMainMenu() -> void:
	LC.message(self, "go to main menu")
	game_go_to_main_menu.emit()
	
# player signals
signal player_current_location

func BroadcastPlayerLocation(location: Vector2) -> void:
	LC.message(self, "player current location")
	player_current_location.emit(location)

# world signals
signal world_generate_world

func BroadcastWorldGenerateWorld() -> void:
	LC.message(self, "world generate world")
	world_generate_world.emit()
	
# enemy controller signals
signal enemy_spawn_wave

func BroadcastEnemySpawnWave() -> void:
	LC.message(self, "enemy spawn wave")
	enemy_spawn_wave.emit()
