extends Node

var can_quit: bool = true
var is_calculator_mode: bool = true

func _ready():
	Global.can_quit = true

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if can_quit:
			get_tree().quit()
