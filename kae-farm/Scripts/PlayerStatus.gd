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
