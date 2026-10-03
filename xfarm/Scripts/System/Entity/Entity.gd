class_name Entity extends Node2D


enum State {
	Idle,
	Moving,
	Busy
}

enum HealthState {
	Healthy,
	Sick,
	Dying,
	Dead
}

enum Direction {
	None,
	Up,
	Down,
	Left,
	Right,
}

# move this into it's own types file, will be used by other classes
enum DamageTypes {
	Fire,
	Water,
	Earth,
	Air,
	Arcane,
	Necromancy,
	Melee,
	Ranged,
}

# some of these variables may be extensible to enemies
# if so, maybe make a generic Entity class for shared attributes
# "Enemy" will have many children
# dont overcomplicate

var GlobalDamageMultiplier: float = 1.0;

var MeleeDamageM: float = 1.0;
var NecromancyDamageM: float = 1.0;
var ArcaneDamageM: float = 1.0;
var IceDamageM: float = 1.0;
var FireDamageM: float = 1.0;

var MoveSpeedM: float = 1.0;
var MoveSpeed: float = 300.0;
var MaxMoveSpeed: float = 100.0;

var MaxHealth: float = 100.0
var Health: float = MaxHealth

var MaxShield: float = 100.0
var Shield: float = MaxShield

var MaxPower: float = 100.0
var Power: float = MaxPower

func _ready() -> void:
	pass
	
	
