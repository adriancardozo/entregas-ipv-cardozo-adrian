extends Node

export (PackedScene) var turret_scene: PackedScene
export (int) var turrets: int = 0
export (int) var border_distance: int = 0

func spawn_turrets(player: Node, turret_container:Node):
	randomize()
	var turret_zone = _turret_zone(player)
	for t in turrets:
		_spawn_turret(player, turret_container, turret_zone)

func _spawn_turret(player: Node, turret_container: Node, turret_zone: Vector2):
	var turret = turret_scene.instance()
	turret_container.add_child(turret)
	turret.set_values(player, turret_container)
	turret.position = _get_random_position_in(turret_zone)

func _turret_zone(player: Node):
	return get_viewport().get_size_override() - Vector2(0, get_viewport().get_size_override().y - player.global_position.y)

func _get_random_position_in(zone: Vector2):
	var x_range = Vector2(0, zone.x) + _border_distance_vector()
	var y_range = Vector2(0, zone.y) + _border_distance_vector()
	return Vector2(_random_in_range(x_range), _random_in_range(y_range))

func _border_distance_vector():
	return Vector2(border_distance, -border_distance)

func _random_in_range(range_vector: Vector2):
	return randi() % int(range_vector[1] - range_vector[0]) + 1 + range_vector[0]
	
