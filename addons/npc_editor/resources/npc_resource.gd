@tool
class_name NPCResource
extends Resource

@export var name: String

@export var icon := Texture2D.new()
@export var refresh_icon := false:
	set(value):
		if refresh_icon != value:
			refresh_icon = value
			_update_icon()

@export_group("Face options")
@export var eye_index: int = 0
@export var eyebrow_index: int = 0
@export var nose_index: int = 0
@export var ear_index: int = 0
@export var mouth_index: int = 0
@export var hair_index: int = 0

@export var eyeshadow_index: int = -1
@export var eyeliner_index: int = -1
@export var blush_index: int = -1

@export var glasses_index: int = 10

@export var mustache_index: int = -1
@export var beard_index: int = -1

@export var nose_piercing_index: int = -1
@export var eyebrow_piercing_index: int = -1
@export var earring_index: int = -1

@export_subgroup("Colors")
@export var skin_color_index: int = 0
@export var eyebrow_color_index: int = 0
@export var hair_color_index: int = 0
@export var mustache_color_index: int = 0
@export var beard_color_index: int = 0

@export var lip_color_index: int = 0
@export var eyeshadow_color_index: int = 0
@export var eyeliner_color_index: int = 0
@export var blush_color_index: int = 0

@export_subgroup("Offset Values")
@export var eye_values: FinetuneValues = FinetuneValues.new()
@export var eyebrow_values: FinetuneValues = FinetuneValues.new()
@export var mouth_values: FinetuneValues = FinetuneValues.new()
@export var mustache_values: FinetuneValues = FinetuneValues.new()
@export var glasses_values: FinetuneValues = FinetuneValues.new()

@export_group("Body options")
@export var shirt_index: int = 0
@export var pants_index: int = 0
@export var sock_index: int = 0
@export var shoe_index: int = 0
@export var belt_index: int = 0
@export var wrist_index: int = 0

@export var shirt_color_index: int = 0
@export var pants_color_index: int = 0
@export var sock_color_index: int = 0
@export var shoes_color_index: int = 0


func _update_icon():
	pass
	# for child: Node in CharacterFactory.get_children():
	# 	if child is PreviewSpawner:
	# 		child.queue_free()

	# var preview_scene := load("res://addons/npc_editor/preview_scene.tscn").instantiate() as PreviewSpawner
	# CharacterFactory.add_child(preview_scene)

	# var character: Character = CharacterFactory.create_character(self)
	# CharacterFactory.refresh_character(character)
	# CharacterFactory.start_character_creation(character)

	# preview_scene.show_character(character)
	# icon = await preview_scene.create_icon(self)

	# await CharacterFactory.end_character_creation(character)

	# if not refresh_icon:
	# 	preview_scene.queue_free()
