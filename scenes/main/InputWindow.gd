extends Control

signal btn_pressed(chr)


func _on_9_pressed():
	emit_signal("btn_pressed", "9")


func _on_8_pressed():
	emit_signal("btn_pressed", "8")


func _on_7_pressed():
	emit_signal("btn_pressed", "7")


func _on_6_pressed():
	emit_signal("btn_pressed", "6")


func _on_5_pressed():
	emit_signal("btn_pressed", "5")


func _on_4_pressed():
	emit_signal("btn_pressed", "4")


func _on_3_pressed():
	emit_signal("btn_pressed", "3")


func _on_2_pressed():
	emit_signal("btn_pressed", "2")


func _on_1_pressed():
	emit_signal("btn_pressed", "1")


func _on_0_pressed():
	emit_signal("btn_pressed", "0")


func _on_Dot_pressed():
	emit_signal("btn_pressed", ".")


func _on_FullErase_pressed():
	emit_signal("btn_pressed", "/fullerase")


func _on_Erase_pressed():
	emit_signal("btn_pressed", "/erase")
