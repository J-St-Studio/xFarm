class_name EnemyController extends Node

var enemy_one: PackedScene = preload("res://Scenes/Enemy.tscn")

signal spawn_enemy_wave

func _ready() -> void:
	pass

func init() -> void:
	print("enemy spawner online")

func Spawn(Enemy: Dictionary) -> void:
	print("spawn enemy wave")
	get_parent().add_child(enemy_one.instantiate())
	pass
