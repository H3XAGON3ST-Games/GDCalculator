extends Control


onready var converter_state_ui := {
	back = $Back, 
	temp_back = $TempBack, 
	area_back = $AreaBack,
	length_back = $LengthBack,
	mass_back = $MassBack,
	speed_back = $SpeedBack
}

onready var input_window = $InputWindow
onready var back_button = $BackButton


enum ConverterState {
	Default, 
	TempConv, 
	AreaConv, 
	LengthConv, 
	MassConv, 
	SpeedConv
}

export(ConverterState) var converter_state := ConverterState.Default setget set_state
func set_state(value):
	converter_state = value
	
	if value != ConverterState.Default:
		Global.can_quit = false
		input_window.visible = true
		back_button.visible = true
		match value:
			ConverterState.TempConv:
				set_visible_to_nodes(converter_state_ui["temp_back"], true)
			ConverterState.AreaConv:
				set_visible_to_nodes(converter_state_ui["area_back"], true)
			ConverterState.LengthConv:
				set_visible_to_nodes(converter_state_ui["length_back"], true)
			ConverterState.MassConv:
				set_visible_to_nodes(converter_state_ui["mass_back"], true)
			ConverterState.SpeedConv:
				set_visible_to_nodes(converter_state_ui["speed_back"], true)
	else:
		Global.can_quit = true
		input_window.visible = false
		back_button.visible = false
		set_visible_to_nodes(converter_state_ui["back"], true)


func set_visible_to_nodes(node: Panel, node_visible: bool):
	node.visible = node_visible
	node.set_mouse_filter(MOUSE_FILTER_STOP)
	
	if node is BaseConverter:
		node.set_state(BaseConverter.State.Value1)
		node._on_InputWindow_btn_pressed("/fullerase")
	
	for key in converter_state_ui.keys():
		var element = converter_state_ui[key]
		if element != node:
			element.visible = !node_visible
			element.set_mouse_filter(MOUSE_FILTER_IGNORE)


func _ready():
	set_state(ConverterState.Default)


func _on_temperature_pressed():
	set_state(ConverterState.TempConv)


func _on_Area_pressed():
	set_state(ConverterState.AreaConv)


func _on_Length_pressed():
	set_state(ConverterState.LengthConv)


func _on_Mass_pressed():
	set_state(ConverterState.MassConv)


func _on_Speed_pressed():
	set_state(ConverterState.SpeedConv)


func _on_BackButton_pressed():
	set_state(ConverterState.Default)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if !Global.can_quit:
			set_state(ConverterState.Default)



