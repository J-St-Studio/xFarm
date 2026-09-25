#
# UIController
# Responsible for rendering information to the UI.
# Will have "Render" functions to be called within other controllers OR
# will have reporting tools. IE: UIController.RenderInventory() OR
# UIController.UpdateInventory() / UIController.UpdateHealth() etc.
class_name UIController extends Controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# if the game is unpaused, no UI control? -> what about in-game menu?
	pass

func Update(GameState: GameController.GameState) -> void:
	# Implementation for broadcasting inventory full message
	# update game UI
	# this is gonna be a fucker of a function, not sure I like the design.
	pass

# maybe generic menu function with args passed in? Maybe.
func RenderMainMenu() -> void:
	return

func RenderPauseMenu() -> void:
	return
