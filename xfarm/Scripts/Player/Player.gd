# PlayerStatus.gd

class_name Player extends Entity
var log = SystemController.GetLogController()
var GC = SystemController.GetGameController()
func _ready() -> void:
	log.message(self, "Player alive!")
	log.message(self, "Game state: ", GC.CurrentGameState)
	pass
	
func _process(delta: float) -> void:
	pass
