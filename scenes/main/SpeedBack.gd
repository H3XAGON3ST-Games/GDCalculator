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
	
	option_button_v1.select(0)
	option_button_v2.select(1)
	item_v1_changed(0)
	item_v2_changed(1)


func add_items_to_v1():
	option_button_v1.add_item("km/h")
	option_button_v1.add_item("m/s")
	option_button_v1.add_item("km/s")
	option_button_v1.add_item("mile/h")
	option_button_v1.add_item("kn")


func add_items_to_v2():
	option_button_v2.add_item("km/h")
	option_button_v2.add_item("m/s")
	option_button_v2.add_item("km/s")
	option_button_v2.add_item("mile/h")
	option_button_v2.add_item("kn")


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
			cur_value = from_kmh_to_ms(cur_value)
		[0, 2]:
			cur_value = from_kmh_to_kms(cur_value)
		[0, 3]:
			cur_value = from_kmh_to_mileh(cur_value)
		[0, 4]:
			cur_value = from_kmh_to_kn(cur_value)
			# --------------------------------
		[1, 0]:
			cur_value = from_ms_to_kmh(cur_value)
		[1, 1]:
			pass
		[1, 2]:
			cur_value = from_ms_to_kmh(cur_value)
			cur_value = from_kmh_to_kms(cur_value)
		[1, 3]:
			cur_value = from_ms_to_kmh(cur_value)
			cur_value = from_kmh_to_mileh(cur_value)
		[1, 4]:
			cur_value = from_ms_to_kmh(cur_value)
			cur_value = from_kmh_to_kn(cur_value)
			# --------------------------------
		[2, 0]:
			cur_value = from_kms_to_kmh(cur_value)
		[2, 1]:
			cur_value = from_kms_to_kmh(cur_value)
			cur_value = from_kmh_to_ms(cur_value)
		[2, 2]:
			pass
		[2, 3]:
			cur_value = from_kms_to_kmh(cur_value)
			cur_value = from_kmh_to_mileh(cur_value)
		[2, 4]:
			cur_value = from_kms_to_kmh(cur_value)
			cur_value = from_kmh_to_kn(cur_value)
			# --------------------------------
		[3, 0]:
			cur_value = from_mileh_to_kmh(cur_value)
		[3, 1]:
			cur_value = from_mileh_to_kmh(cur_value)
			cur_value = from_kmh_to_ms(cur_value)
		[3, 2]:
			cur_value = from_mileh_to_kmh(cur_value)
			cur_value = from_kmh_to_kms(cur_value)
		[3, 3]:
			pass
		[3, 4]:
			cur_value = from_mileh_to_kmh(cur_value)
			cur_value = from_kmh_to_kn(cur_value)
			# --------------------------------
		[4, 0]:
			cur_value = from_kn_to_kmh(cur_value)
		[4, 1]:
			cur_value = from_kn_to_kmh(cur_value)
			cur_value = from_kmh_to_ms(cur_value)
		[4, 2]:
			cur_value = from_kn_to_kmh(cur_value)
			cur_value = from_kmh_to_kms(cur_value)
		[4, 3]:
			cur_value = from_kn_to_kmh(cur_value)
			cur_value = from_kmh_to_mileh(cur_value)
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


func from_ms_to_kmh(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*3600.0/1000.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_kms_to_kmh(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*3600.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_mileh_to_kmh(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*1.609344" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_kn_to_kmh(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s*1.852" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)


func from_kmh_to_ms(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/3600.0*1000.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_kmh_to_kms(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/3600.0" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_kmh_to_mileh(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/1.609344" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_kmh_to_kn(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s/1.852" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)
