extends EditorScript

static func of(val: float, decimal: int) -> String:
	return str(val).pad_decimals(decimal)

#func of(val: float) -> Variant:
	#var data = PrecisionObjectData.new()
	#data.value = val;
	#return data
	#
