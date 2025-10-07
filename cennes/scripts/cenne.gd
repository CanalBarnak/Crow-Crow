extends Area3D
@onready var coin_collect: AudioStreamPlayer = $"../CoinCollect"
var inside : bool = false


func _on_body_entered(_body: Node3D) -> void:
	inside = true


func _process(_delta: float) -> void:
	if inside == true:
		coin_collect.play()
		Global.score += Global.score_power
		Global.energie += 5
		queue_free()
		
func _on_body_exited(_body: Node3D) -> void:
	inside = false
