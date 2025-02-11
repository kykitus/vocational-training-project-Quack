extends Node2D

@export var config : AppMenuConfig = null
var Apps : Array[Container] = []
var AppQuantity : int = 0
var AppBase = load("res://Elements/AppIcon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Bg/ColorfulMotif.play("Colorful")
	var app_instance
	for app : AppIconResource in config.apps:
		app_instance = AppBase.instantiate()
		app_instance.setup(app)
		
		Apps.push_back(app_instance)
		$Button/AppHolder.add_child(app_instance)
		$Button/AppHolder.size.x += 205
		AppQuantity += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
