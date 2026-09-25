class_name EnemyController extends Controller


var enemy_one: PackedScene = preload("res://Scenes/Enemy.tscn")


signal spawn_enemy_wave

func _ready() -> void:
	super._ready()
	pass

func init() -> void:
	pass

func Spawn(Enemy: Dictionary) -> void:
	print("spawn enemy wave")
	get_parent().add_child(enemy_one.instantiate())
	pass
