extends Node2D

var InputTypes = preload("res://Scripts/InputTypes.gd")

@onready var CurrentControlType: int = InputTypes.ControlTypes.PLAYER
@onready var player: Sprite2D = $"../PlayerSprite"

@onready var GlobalDeltaTime: float = 0;
@onready var CurrentMovementSpeed: int = 150;
@onready var MovementSpeedMultiplier: int = 2;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalDeltaTime = delta;
	if (CurrentControlType == InputTypes.ControlTypes.PLAYER):
		ProcessPlayerInput()
	elif (CurrentControlType == InputTypes.ControlTypes.UI):
		ProcessUserInterfaceInput()
	elif (CurrentControlType == InputTypes.ControlTypes.NONE):
		pass
	pass
	

func PlayerSpeedCalculation() -> float:
	return CurrentMovementSpeed * MovementSpeedMultiplier * GlobalDeltaTime

# NOTES: Should the player controller handle playing animations?
#		Does that make sense to couple together?
func ProcessPlayerInput() -> void:
	if CurrentControlType != InputTypes.ControlTypes.PLAYER: return
	if (Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W)):
		player.translate(Vector2(0, -1) * PlayerSpeedCalculation())
	if (Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A)):
		player.translate(Vector2(-1, 0) * PlayerSpeedCalculation())
	if (Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D)):
		player.translate(Vector2(1, 0) * PlayerSpeedCalculation())
	if (Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S)):
		player.translate(Vector2(0, 1) * PlayerSpeedCalculation())
	pass

func ProcessUserInterfaceInput() -> void:
	pass
