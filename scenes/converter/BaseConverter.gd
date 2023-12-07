extends Panel
class_name BaseConverter

signal number_changed

onready var value1 = get_node("VBoxContainer/Value1/Num")
onready var value2 = get_node("VBoxContainer/Value2/Num")

onready var input_window = get_node("../InputWindow")

var current_value: Label

enum State {
	Value1, 
	Value2
}

export(State) var state := State.Value1 setget set_state
func set_state(value):
	if self.visible == false:
		return
	
	state = value
	
	if value == State.Value1:
		current_value = value1
		value1.modulate = Color(1, 1, 1)
		value2.modulate = Color(0.55, 0.55, 0.55)
	elif value == State.Value2:
		current_value = value2
		value1.modulate = Color(0.55, 0.55, 0.55)
		value2.modulate = Color(1, 1, 1)


func _ready():
	input_window.connect("btn_pressed", self, "_on_InputWindow_btn_pressed")
	set_text_to_label(value1, "")
	set_state(State.Value1)
	get_node("VBoxContainer/Value1/Num/ButtonV1").connect("pressed", self, "_on_ButtonV1_pressed")
	get_node("VBoxContainer/Value2/Num/ButtonV2").connect("pressed", self, "_on_ButtonV2_pressed")


func set_text_to_label(node: Label, text: String):
	node.text = text 
	
	if text.length() <= 0:
		node.text = "0"


func _on_ButtonV1_pressed():
	set_state(State.Value1)


func _on_ButtonV2_pressed():
	set_state(State.Value2)


func _on_InputWindow_btn_pressed(chr):
	if self.visible == false:
		return
	
	if chr == "/fullerase":
		set_text_to_label(current_value, "")
		num_changed()
		return
	
	if chr == "/erase":
		var local_text = current_value.text
		local_text.erase(local_text.length() - 1, 1)
		
		set_text_to_label(current_value, local_text)
		num_changed()
		return
	
	if chr == ".":
		if current_value.text.split(".").size() <= 1:
			set_text_to_label(current_value, current_value.text + chr)
			num_changed()
		return
	
	if current_value.text.length() <= 1 and current_value.text == "0":
		var local_text = current_value.text
		local_text.erase(local_text.length() - 1, 1)
		set_text_to_label(current_value, local_text + chr)
		num_changed()
		return 
	
	set_text_to_label(current_value, current_value.text + chr)
	num_changed()


func num_changed():
	emit_signal("number_changed")
