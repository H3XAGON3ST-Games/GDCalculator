extends HBoxContainer

onready var calculator_mode = $ControlCaculator/CalculatorMode
onready var converter_mode = $ControlConverter/ConverterMode

onready var calculator_ui = get_node("../CalculatorUI")
onready var converter_ui = get_node("../ConverterUI")

func _ready():
	calculator_mode.connect("icon_button_pressed", self, "icon_button_pressed")
	converter_mode.connect("icon_button_pressed", self, "icon_button_pressed")
	$ControlCaculator/CalculatorMode.pressed = true


func icon_button_pressed(mode: bool):
	if mode:
		calculator_ui.visible = true
		converter_ui.visible = false
		Global.is_calculator_mode = true
	else:
		calculator_ui.visible = false
		converter_ui.visible = true
		converter_ui.set_state(converter_ui.ConverterState.Default)
		Global.is_calculator_mode = false
