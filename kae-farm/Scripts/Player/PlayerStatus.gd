# PlayerStatus.gd

extends Node

enum State {
	Idle,
	Moving,
	Busy,
	Dead,
}

enum Direction {
	None,
	Up,
	Down,
	Left,
	Right,
}

var Health: int = 100
var MaxHealth: int = 100
