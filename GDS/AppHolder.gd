extends Button

var Offset: float = 0.0
var is_Dragging: bool = false

var velocity : float = 0.0
var last_pos : float = 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and is_Dragging:
		$AppHolder.position.x = get_global_mouse_position().x - Offset - self.global_position.x - 25
		velocity = $AppHolder.position.x - last_pos
		last_pos = $AppHolder.position.x

func _physics_process(delta: float) -> void:
	if velocity != 0:
		var velocity_value : float = abs(velocity)
		velocity = clampf(velocity_value - 100 * delta, 0.0, velocity_value) * (velocity_value / velocity)
	
	if not is_Dragging:
		$AppHolder.position.x += velocity
		if $AppHolder.position.x > 200:
			$AppHolder.position.x = lerp($AppHolder.position.x, 200.0, sqrt(0.03))
		elif $AppHolder.position.x < -1 * $AppHolder.size.x + 1075:
			$AppHolder.position.x = lerp($AppHolder.position.x, -1 * $AppHolder.size.x + 1075, sqrt(0.03))

func _on_button_down() -> void:
	Offset = $AppHolder.get_local_mouse_position().x
	is_Dragging = true


func _on_button_up() -> void:
	is_Dragging = false
