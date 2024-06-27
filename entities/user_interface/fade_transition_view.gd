extends View


func _ready():
	BattleManager.on_battle_requested.connect(_on_battle_requested)



func _open():
	visible = true


func _close():
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 2.0)
	tween.tween_callback(func(): visible = false)


func _on_battle_requested():
	view_group.push_view(self)
