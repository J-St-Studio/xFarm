#
# InventoryController
# Controls the inventory and all management of the inventory
# Will eventually be responsible for reporting to the UI controller for rendering

class_name InventoryController extends Node

var MaxInventorySize: int
var Inventory: Array[Item]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MaxInventorySize = 10;
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func SortInventory() -> void:
	pass

func SortInventoryByCategory() -> void:
	pass

func SortInventoryAlphabetical() -> void:
	SortInventory()
	pass

# reference or value?
func GetInventory() -> Array:
	return Inventory

func GetItemCount() -> int:
	return Inventory.size()

func IsEmpty() -> bool:
	return Inventory.size() == 0
	
func IsFull() -> bool:
	return Inventory.size() >= MaxInventorySize
	
# make an "item" class <- actual use-case for a class/OOP
func AddItem(NewItem: Item) -> bool:
	if (!IsEmpty()): return false
	else:
		Inventory.append(NewItem)
		return true

func RemoveItem(ItemToRemove: String) -> bool:
	var index: int = 0
	for item in Inventory:
		if (item.Name == ItemToRemove):
			var delete_item = Inventory[index]
			Inventory.remove_at(index)
			delete_item.free()
			return true
		index += 1
	return false

# doesn't drop the inventory items, deletes them.
func ClearInventory() -> void:
	var index: int = 0
	for CurrentItem in Inventory:
		var TempItem = CurrentItem
		Inventory.remove_at(index)
		TempItem.free()
		index += 1
