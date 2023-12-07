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
	option_button_v1.add_item("Celsius")
	option_button_v1.add_item("Fahrenheit")
	option_button_v1.add_item("Kelvin")


func add_items_to_v2():
	option_button_v2.add_item("Celsius")
	option_button_v2.add_item("Fahrenheit")
	option_button_v2.add_item("Kelvin")


func item_v1_changed(index: int):
	option_index_v1 = index
	num_changed()


func item_v2_changed(index: int):
	option_index_v2 = index
	num_changed()


func num_changed():
	if state == 0:
		var value2_number = float(value1.text)
		
		match [option_index_v1, option_index_v2]:
			[0, 0]:
				pass
			[0, 1]:
				value2_number = from_c_to_f(value2_number)
			[0, 2]:
				value2_number = from_c_to_k(value2_number)
			[1, 0]:
				value2_number = from_f_to_c(value2_number)
			[1, 1]:
				pass
			[1, 2]:
				value2_number = from_f_to_c(value2_number)
				value2_number = from_c_to_k(value2_number)
			[2, 0]:
				value2_number = from_k_to_c(value2_number)
			[2, 1]:
				value2_number = from_k_to_c(value2_number)
				value2_number = from_c_to_f(value2_number)
			[2, 2]:
				pass
		
		set_text_to_label(value2, str(value2_number))
		
	if state == 1:
		var value1_number = float(value2.text)
		
		match [option_index_v2, option_index_v1]:
			[0, 0]:
				pass
			[0, 1]:
				value1_number = from_c_to_f(value1_number)
			[0, 2]:
				value1_number = from_c_to_k(value1_number)
			[1, 0]:
				value1_number = from_f_to_c(value1_number)
			[1, 1]:
				pass
			[1, 2]:
				value1_number = from_f_to_c(value1_number)
				value1_number = from_c_to_k(value1_number)
			[2, 0]:
				value1_number = from_k_to_c(value1_number)
			[2, 1]:
				value1_number = from_k_to_c(value1_number)
				value1_number = from_c_to_f(value1_number)
			[2, 2]:
				pass
		
		set_text_to_label(value1, str(value1_number))


func execute_expression(cur_expression: String) -> float:
	var expression = Expression.new()
	print(cur_expression)
	var error = expression.parse(cur_expression)
	
	if error != OK:
		return 0.0
	
	var result = expression.execute()
	return float(result)


func from_c_to_f(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "(%s*(9.0/5.0))+32" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)


func from_f_to_c(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "(%s-32.0)*(5.0/9.0)" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)


func from_k_to_c(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s-273.15" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)

func from_c_to_k(number: float) -> float:
	var str_number = str(number)
	if str_number.split(".").size() <= 1:
		str_number += ".0"
	var cur_expression = "%s+273.15" % [str_number]
	var result = execute_expression(cur_expression)
	return float(result)
