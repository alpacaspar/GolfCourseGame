extends View


@export var winning_team_label: Label

@export var winning_team_container: Container
@export var character_portrait_scene: PackedScene

@onready var margin_container: MarginContainer = $MarginContainer

var last_winning_team: TeamResource


func _ready():
	BattleManager.on_battle_ended.connect(_on_battle_ended)
	modulate = Color.TRANSPARENT
	winning_team_container.modulate = Color.TRANSPARENT


func _on_battle_ended(winning_team: TeamResource):
	last_winning_team = winning_team
	view_group.push_view(self)


func _open():
	visible = true
	winning_team_label.text = "Team %s wins!" % last_winning_team.leader.npc_resource.name

	for golfer: GolferResource in last_winning_team.get_composition():
		var portrait_instance := character_portrait_scene.instantiate()
		winning_team_container.add_child(portrait_instance)
		portrait_instance.set_icon(golfer.npc_resource.icon)
	
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(margin_container, "theme_override_constants/margin_bottom", 16, 1.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "modulate", Color.WHITE, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(false)
	tween.tween_property(winning_team_container, "modulate", Color.WHITE, 1.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _close():
	visible = false

	for portrait: Node in winning_team_container.get_children():
		portrait.queue_free()
