extends Label


func _ready():
	check_text_count()

func set_text(value: String) -> void:
	self.text = value
	check_text_count()

func check_text_count() -> void: 
	var curr_text_length: int = self.text.length()
#	print(curr_text_length)
	if curr_text_length in range(0, 13):
		self.get_font("font").size = 80
	elif curr_text_length in range(13, 18):
		self.get_font("font").size = 60
	elif curr_text_length in range(18, 25):
		self.get_font("font").size = 50
	elif curr_text_length in range(25, 30):
		self.get_font("font").size = 45
	elif curr_text_length in range(30, 200):
		self.get_font("font").size = 38
