class_name MeshNode extends Node2D

var above: MeshNode
var below: MeshNode
var left: MeshNode
var right: MeshNode

var connections: Array

var data: Variant

func _init() -> void:
	above = null
	below = null
	left = null
	right = null
	
	data = null
	return

func GetData() -> Variant:
	return data
	
