extends "res://entities/enemies/states/AbstractEnemyState.gd"

onready var fire_timer:Timer = $FireTimer


func notify_body_exited(body):
	.notify_body_exited(body)
	if parent.target == null:
		emit_signal("finished", "idle")


func enter():
	parent.velocity.x = 0
	call_deferred("_fire")
	fire_timer.start()


func exit():
	fire_timer.stop()


func update(delta):
	var can_see_target:bool = parent._can_see_target()
	if can_see_target:
		parent.body.flip_h = parent.target.global_position.x < parent.global_position.x
	if fire_timer.is_stopped() && can_see_target:
		_fire()
		fire_timer.start()
	elif !fire_timer.is_stopped() && !can_see_target:
		parent._play_animation("idle")
		fire_timer.stop()

func _fire():
	parent._play_animation("fire")
	parent.fire()

func _on_FireTimer_timeout():
	if parent._can_see_target():
		_fire()
		fire_timer.start()
