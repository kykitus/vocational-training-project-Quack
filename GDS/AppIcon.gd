extends Container
var AppPath : NodePath = ""


#func _init(app_name : String, icon_path : String, app_scene_path : String) -> void:
	#$Name.text = "[center]" + app_name + "[/center]"
	#$Icon.texture = load(icon_path)
	#app_path = app_scene_path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func setup(ref : AppIconResource) -> void:
	if ref.Name.length() > 11:
		$Node/Name.text = "[center]" + ref.Name.substr(0, 11) + "[/center]"
		print("Reminder, that app names can take up to 11 letters")
	else:
		$Node/Name.text = "[center]" + ref.Name + "[/center]"
	$Node/Icon.texture = ref.Icon
	AppPath = ref.App_path


func _on_button_button_up() -> void:
	print("Fuck You")
