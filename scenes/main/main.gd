extends Control


const numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
const actions_with_bracket = ["+", "-", "*", "/", "(", ")"]
const actions = ["+", "-", "*", "/"]

var cur_expressions: String = ""

onready var past_calculation := $CalculatorUI/OutputWindow/Back/VBoxContainer/PastCalculation
onready var cur_calculation := $CalculatorUI/OutputWindow/Back/VBoxContainer/CurrentCalculation

onready var option_conteiner = $OptionConteiner

func _ready():
	cur_calculation.text = cur_expressions


func set_cur_expression(local_expression: String):
	if local_expression.length() > 170:
		return
	cur_expressions = local_expression
	cur_calculation.set_text("= " + local_expression)


func split_via_array(string: String, array: Array) -> Array:
	var result_local_array: Array = [string]
	for element_key in array: 
		var local: Array = []
		for element in result_local_array: 
			local.append_array(element.split(element_key))
		local.erase(null)
		local.erase("")
		result_local_array.clear()
		result_local_array.append_array(local)
	
	for i in result_local_array.size():
		result_local_array.erase(null)
		result_local_array.erase("")
		result_local_array.erase(" ")
	
	return result_local_array


func set_float_to_number():
	var number_of_added_chars: int = 0
	
	var is_action_first = false
	if cur_expressions[0] in actions_with_bracket:
		is_action_first = true
	
	var array_number = split_via_array(cur_expressions, actions_with_bracket)
	var array_action = split_via_array(cur_expressions, numbers)
	
	if array_number.size() <= 1:
		return
	
	var fix_expression = ""
	
	var even_num_fix = 1
	if array_number.size() == array_action.size():
		even_num_fix = 0
	
	
	for i in range(0, array_number.size() - even_num_fix): 
		if array_number[i].split(".").size() <= 1:
			if is_action_first:
				fix_expression += array_action[i] + array_number[i] + ".0"
			else:
				fix_expression += array_number[i] + ".0" + array_action[i]
		else:
			if is_action_first:
				fix_expression += array_action[i] + array_number[i]
			else:
				fix_expression += array_number[i] + array_action[i]
	
	if bool(even_num_fix):
		var last_index = array_number.size()-1
		
		if array_number[last_index].split(".").size() <= 1:
				fix_expression += array_number[last_index] + ".0"
		else:
				fix_expression += array_number[last_index]
		
		if array_number.size() < array_action.size():
			fix_expression += array_action[array_action.size()-1]
	
	prints(array_number, array_action)
	
	set_cur_expression(fix_expression)


func clear_equals_in_cur_calculation():
	cur_calculation.set_text(cur_calculation.text.replace("Null", ""))
	cur_calculation.set_text(cur_calculation.text.replace("Error", ""))
	cur_calculation.set_text(cur_calculation.text.replace("= ", ""))


func check_multiplier_next_to_bracket():
	var fix_expression = cur_expressions
	
	for i in range(0, 10):
		fix_expression = fix_expression.replace(")(", ")*(")
		fix_expression = fix_expression.replace(str(i)+"(", str(i)+"*(")
		fix_expression = fix_expression.replace(")" + str(i), ")*" + str(i))
	
	set_cur_expression(fix_expression)


func check_action_char():
	if cur_expressions.length() > 0:
		if cur_expressions[cur_expressions.length() - 1] in actions:
			cur_expressions.erase(cur_expressions.length() - 1, 1)


func execute_expression():
	clear_equals_in_cur_calculation()
	if cur_expressions != "":
		set_float_to_number()
		check_multiplier_next_to_bracket()
		var expression = Expression.new()
		print(cur_expressions)
		var error = expression.parse(cur_expressions)
		
		if error != OK:
			print("Error")
			set_cur_expression("Error")
			cur_expressions = ""
			return
		
		var result = expression.execute()
		
		past_calculation.text = cur_expressions 
		set_cur_expression(str(result))
		
		if result == null:
			cur_expressions = ""
		
#		print(cur_expressions)


func _on_Calculate_pressed():
	execute_expression()


func _on_FullErase_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression("")
	clear_equals_in_cur_calculation()


func _on_Dot_pressed():
	if !Global.is_calculator_mode:
		return
	
	set_cur_expression(cur_expressions + ".")
	clear_equals_in_cur_calculation()


func _on_0_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "0")
	clear_equals_in_cur_calculation()


func _on_1_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "1")
	clear_equals_in_cur_calculation()


func _on_2_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "2")
	clear_equals_in_cur_calculation()


func _on_3_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "3")
	clear_equals_in_cur_calculation()


func _on_4_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "4")
	clear_equals_in_cur_calculation()


func _on_5_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "5")
	clear_equals_in_cur_calculation()


func _on_6_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "6")
	clear_equals_in_cur_calculation()


func _on_7_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "7")
	clear_equals_in_cur_calculation()


func _on_8_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "8")
	clear_equals_in_cur_calculation()


func _on_9_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "9")
	clear_equals_in_cur_calculation()


func _on_Erase_pressed():
	if !Global.is_calculator_mode:
		return
	cur_expressions.erase(cur_expressions.length() - 1, 1)
	set_cur_expression(cur_expressions)
	clear_equals_in_cur_calculation()


func _on_OpenBracket_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + "(")
	clear_equals_in_cur_calculation()


func _on_CloseBracket_pressed():
	if !Global.is_calculator_mode:
		return
	set_cur_expression(cur_expressions + ")")
	clear_equals_in_cur_calculation()


func _on_Divide_pressed():
	if !Global.is_calculator_mode:
		return
	check_action_char()
	set_cur_expression(cur_expressions + "/")
	clear_equals_in_cur_calculation()


func _on_Subtract_pressed():
	if !Global.is_calculator_mode:
		return
	check_action_char()
	set_cur_expression(cur_expressions + "-")
	clear_equals_in_cur_calculation()


func _on_Multiply_pressed():
	if !Global.is_calculator_mode:
		return
	check_action_char()
	set_cur_expression(cur_expressions + "*")
	clear_equals_in_cur_calculation()


func _on_Add_pressed():
	if !Global.is_calculator_mode:
		return
	check_action_char()
	set_cur_expression(cur_expressions + "+")
	clear_equals_in_cur_calculation()
