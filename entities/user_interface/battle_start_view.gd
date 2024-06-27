extends View


@export var label: Label

@onready var margin_container: MarginContainer = $MarginContainer


func _ready():
	BattleManager.on_battle_setup.connect(_on_battle_setup)


func _open():
	visible = true
	
	var tween := create_tween()
	tween.tween_interval(4.0)
	tween.tween_property(margin_container, "theme_override_constants/margin_bottom", 16, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color.WHITE, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(false)
	tween.tween_interval(5.0)
	tween.tween_property(margin_container, "theme_override_constants/margin_bottom", 128, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(false)
	tween.tween_callback(func(): view_group.pop_view())


func _close():
	visible = false

	modulate = Color.TRANSPARENT
	margin_container.set("theme_override_constants/margin_bottom", -128)


func _on_battle_setup(_teams: Array[Team], battle: Battle):
	view_group.pop_view()
	view_group.push_view(self)
	label.text = battle.battle_name
