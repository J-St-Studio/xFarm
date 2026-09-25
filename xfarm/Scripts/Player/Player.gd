# PlayerStatus.gd

class_name Player extends Entity
var log = System.GetLogController()
var GC = System.GetGameController()
func _ready() -> void:
	log.message(self, "I am alive!")
	log.message(self, "Game state: ", GC.CurrentGameState)
	pass
	
func _process(delta: float) -> void:
	pass
