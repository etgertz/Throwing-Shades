extends TextureRect



func _ready():
	var mat = material
	mat.set_shader_parameter("material", preload("res://Assets/windowLigh2.0.png"))
	mat.set_shader_parameter("light_source", Vector2(0.5, 0.0))
	mat.set_shader_parameter("density", 0.5)
	mat.set_shader_parameter("weight", 0.1)
	mat.set_shader_parameter("decay", 0.96)
	mat.set_shader_parameter("exposure", 0.3)


func _process(delta):
	material.set_shader_parameter("exposure", 0.3 + sin(Time.get_ticks_msec() * 0.001) * 0.05)
