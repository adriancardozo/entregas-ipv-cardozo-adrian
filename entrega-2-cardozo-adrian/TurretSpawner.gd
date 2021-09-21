extends Node

export (PackedScene) var turret_scene: PackedScene
export (int) var turrets: int = 0
var border_distance = 50
func spawn_turrets(player: Node, turret_container:Node):
	randomize()
	
	for n in turrets:
		var turret_instance = turret_scene.instance()
		turret_container.add_child(turret_instance)
		turret_instance.set_values(player, turret_container)
		
		var border_distance_vector = Vector2(border_distance, -border_distance)
		
		var x_range = Vector2(0, get_viewport().size.x) + border_distance_vector
		var y_range = Vector2(0, get_viewport().size.y - (get_viewport().size.y - player.global_position.y)) + border_distance_vector

		var random_x = randi() % int(x_range[1] - x_range[0]) + 1 + x_range[0] 
		var random_y =  randi() % int(y_range[1]-y_range[0]) + 1 + y_range[0]
		var random_pos = Vector2(random_x, random_y)

		turret_instance.position = random_pos
	
