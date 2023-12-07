extends Button

signal icon_button_pressed(mode)

export var is_calculator_mode: bool = true

func _ready():
	self.connect("toggled", self, "button_toggled")


func button_toggled(button_pressed: bool):
	if button_pressed:
		self.modulate = Color(0.55, 0.55, 0.55)
		emit_signal("icon_button_pressed", is_calculator_mode)
	else:
		self.modulate = Color(1, 1, 1)
