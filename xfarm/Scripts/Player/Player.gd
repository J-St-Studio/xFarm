# PlayerStatus.gd

class_name Player extends Entity
var system: System = System.Get()
var log = system.GetLogController()
var game = system.GetGameController()

func _ready() -> void:
	log.message(self, "I am alive!")
	log.message(self, "Game state: ", game.GetCurrentGameState())
	log.message(self, "location: ", position)
	pass
	
func _process(delta: float) -> void:
	pass
