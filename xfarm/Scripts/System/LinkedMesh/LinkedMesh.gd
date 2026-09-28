class_name LinkedMesh extends Node2D

var current: MeshNode
var topLeft: MeshNode
var topRight: MeshNode
var bottomLeft: MeshNode
var bottomRight: MeshNode

func _init() -> void:
	current = null
	topLeft = null
	topRight = null
	bottomLeft = null
	bottomRight = null
	print("init")
	return

func addMeshNode() -> void:
	print("this is a dumb idea lmao")
