extends Control


var cur_expressions: String = ""

onready var past_calculation := $VBoxContainer/OutputWindow/Back/VBoxContainer/PastCalculation
onready var cur_calculation := $VBoxContainer/OutputWindow/Back/VBoxContainer/CurrentCalculation

func _ready():
	cur_calculation.text = cur_expressions
	
	for child in get_children():
		pass


func set_cur_expression(local_expression: String):
	if local_expression.length() > 170:
		return
	cur_expressions = local_expression
	cur_calculation.set_text("= " + local_expression)


func clear_equals_in_cur_calculation():
	cur_calculation.set_text(cur_calculation.text.replace("Null", ""))
	cur_calculation.set_text(cur_calculation.text.replace("Error", ""))
	cur_calculation.set_text(cur_calculation.text.replace("= ", ""))


func check_multiplier_next_to_bracket():
	var fix_expression = cur_expressions
	
#	if fix_expression.count("*")
	
	for i in range(0, 10):
		fix_expression = fix_expression.replace(str(i)+"(", str(i)+"*(")
		fix_expression = fix_expression.replace(")" + str(i), ")*" + str(i))
	
	set_cur_expression(fix_expression)


func execute_expression():
	clear_equals_in_cur_calculation()
	if cur_expressions != "":
		check_multiplier_next_to_bracket()
		var expression = Expression.new()
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
		
		print(cur_expressions)


func _on_Calculate_pressed():
	execute_expression()


func _on_FullErase_pressed():
	set_cur_expression("")
	clear_equals_in_cur_calculation()


func _on_Dot_pressed():
	set_cur_expression(cur_expressions + ".")
	clear_equals_in_cur_calculation()


func _on_0_pressed():
	set_cur_expression(cur_expressions + "0")
	clear_equals_in_cur_calculation()


func _on_1_pressed():
	set_cur_expression(cur_expressions + "1")
	clear_equals_in_cur_calculation()


func _on_2_pressed():
	set_cur_expression(cur_expressions + "2")
	clear_equals_in_cur_calculation()


func _on_3_pressed():
	set_cur_expression(cur_expressions + "3")
	clear_equals_in_cur_calculation()


func _on_4_pressed():
	set_cur_expression(cur_expressions + "4")
	clear_equals_in_cur_calculation()


func _on_5_pressed():
	set_cur_expression(cur_expressions + "5")
	clear_equals_in_cur_calculation()


func _on_6_pressed():
	set_cur_expression(cur_expressions + "6")
	clear_equals_in_cur_calculation()


func _on_7_pressed():
	set_cur_expression(cur_expressions + "7")
	clear_equals_in_cur_calculation()


func _on_8_pressed():
	set_cur_expression(cur_expressions + "8")
	clear_equals_in_cur_calculation()


func _on_9_pressed():
	set_cur_expression(cur_expressions + "9")
	clear_equals_in_cur_calculation()


func _on_Erase_pressed():
	cur_expressions.erase(cur_expressions.length() - 1, 1)
	set_cur_expression(cur_expressions)
	clear_equals_in_cur_calculation()


func _on_OpenBracket_pressed():
	set_cur_expression(cur_expressions + "(")
	clear_equals_in_cur_calculation()


func _on_CloseBracket_pressed():
	set_cur_expression(cur_expressions + ")")
	clear_equals_in_cur_calculation()


func _on_Divide_pressed():
	set_cur_expression(cur_expressions + "/")
	clear_equals_in_cur_calculation()


func _on_Subtract_pressed():
	set_cur_expression(cur_expressions + "-")
	clear_equals_in_cur_calculation()


func _on_Multiply_pressed():
	set_cur_expression(cur_expressions + "*")
	clear_equals_in_cur_calculation()


func _on_Add_pressed():
	set_cur_expression(cur_expressions + "+")
	clear_equals_in_cur_calculation()
