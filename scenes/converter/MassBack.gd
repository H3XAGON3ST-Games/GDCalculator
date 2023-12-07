extends BaseConverter


onready var option_button_v1 = $VBoxContainer/Value1/OptionButton
onready var option_button_v2 = $VBoxContainer/Value2/OptionButton


var option_index_v1: int
var option_index_v2: int

func _ready():
	add_items_to_v1()
	add_items_to_v2()
	option_button_v1.connect("item_selected", self, "item_v1_changed")
	option_button_v2.connect("item_selected", self, "item_v2_changed")
	self.connect("number_changed", self, "num_changed")
	
	option_button_v1.select(3)
	option_button_v2.select(4)
	item_v1_changed(3)
	item_v2_changed(4)


func add_items_to_v1():
	option_button_v1.add_item("mm")
	option_button_v1.add_item("cm")
	option_button_v1.add_item("dm")
	option_button_v1.add_item("m")
	option_button_v1.add_item("km")


func add_items_to_v2():
	option_button_v2.add_item("mm")
	option_button_v2.add_item("cm")
	option_button_v2.add_item("dm")
	option_button_v2.add_item("m")
	option_button_v2.add_item("km")


func item_v1_changed(index: int):
	option_index_v1 = index
	num_changed()


func item_v2_changed(index: int):
	option_index_v2 = index
	num_changed()


func num_changed():
	var cur_value = 0
	var node_value
	
	var cur_index1
	var cur_index2
	
	
	if state == 0:
		cur_value = float(value1.text)
		node_value = value2
		cur_index1 = option_index_v1
		cur_index2 = option_index_v2
	if state == 1:
		cur_value = float(value2.text)
		node_value = value1
		cur_index1 = option_index_v2
		cur_index2 = option_index_v1
	
	
	match [cur_index1, cur_index2]:
		[0, 0]:
			pass
		[0, 1]:
			cur_value = from_mm_to_m(cur_value)
			cur_value = from_m_to_cm(cur_value)
		[0, 2]:
			cur_value = from_mm_to_m(cur_value)
			cur_value = from_m_to_dm(cur_value)
		[0, 3]:
			cur_value = from_mm_to_m(cur_value)
		[0, 4]:
			cur_value = from_mm_to_m(cur_value)
			cur_value = from_m_to_km(cur_value)
			# --------------------------------
		[1, 0]:
			cur_value = from_cm_to_m(cur_value)
			cur_value = from_m_to_mm(cur_value)
		[1, 1]:
			pass
		[1, 2]:
			cur_value = from_cm_to_m(cur_value)
			cur_value = from_m_to_dm(cur_value)
		[1, 3]:
			cur_value = from_cm_to_m(cur_value)
		[1, 4]:
			cur_value = from_cm_to_m(cur_value)
			cur_value = from_m_to_km(cur_value)
			# --------------------------------
		[2, 0]:
			cur_value = from_dm_to_m(cur_value)
			cur_value = from_m_to_mm(cur_value)
		[2, 1]:
			cur_value = from_dm_to_m(cur_value)
			cur_value = from_m_to_cm(cur_value)
		[2, 2]:
			pass
		[2, 3]:
			cur_value = from_dm_to_m(cur_value)
		[2, 4]:
			cur_value = from_dm_to_m(cur_value)
			cur_value = from_m_to_km(cur_value)
			# --------------------------------
		[3, 0]:
			cur_value = from_m_to_mm(cur_value)
		[3, 1]:
			cur_value = from_m_to_cm(cur_value)
		[3, 2]:
			cur_value = from_m_to_dm(cur_value)
		[3, 3]:
			pass
		[3, 4]:
			cur_value = from_m_to_km(cur_value)
			# --------------------------------
		[4, 0]:
			cur_value = from_km_to_m(cur_value)
			cur_value = from_m_to_mm(cur_value)
		[4, 1]:
			cur_value = from_km_to_m(cur_value)
			cur_value = from_m_to_cm(cur_value)
		[4, 2]:
			cur_value = from_km_to_m(cur_value)
			cur_value = from_m_to_dm(cur_value)
		[4, 3]:
			cur_value = from_km_to_m(cur_value)
		[4, 4]:
			pass
			# --------------------------------
	
	set_text_to_label(node_value, str(cur_value))


func execute_expression(cur_expression: String) -> float:
	var expression = Expression.new()
	print(cur_expression)
	var error = expression.parse(cur_expression)
	
	if error != OK:
		return 0.0
	
	var result = expression.execute()
	return float(result)


func from_mm_to_m(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/1000.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_cm_to_m(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/100.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_dm_to_m(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/10.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_km_to_m(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*1000.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)


func from_m_to_mm(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*1000.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_m_to_cm(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*100.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_m_to_dm(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*10.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_m_to_km(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/1000.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

