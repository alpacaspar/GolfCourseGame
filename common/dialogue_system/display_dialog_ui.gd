extends Node


@export var main_text: RichTextLabel
@export var name_text: RichTextLabel

@export var button_panel: Control
@export var button_holder: Control
@export var button_prefab: PackedScene

var index: int
var is_writing: bool

var has_pressed: bool


func _process(_delta):
	if has_pressed:
		return

	if Input.is_key_pressed(KEY_L):
		display_text("Placeholder Name, set via code", "This is some [i]placeholder[/i] text, so I can test wether [b]EVERYTHING[/b] works!", 0.05)
		has_pressed = true


func display_text(dialog_name: String, text: String, time_between_characters: float):
	index = 0
	is_writing = true
	main_text.text = ""
	name_text.text = dialog_name
	
	var current_line: String = ""
	while index < text.length():
		if text[index] == '[':
			var style_part_one = _read_until_character(text, ']', true)
			var text_between = _read_until_character(text, '[', false)
			var style_part_two = _read_until_character(text, ']', true)

			var result = ""
			for i in text_between:
				result += i

				var final = str(current_line)
				final += style_part_one
				final += result

				main_text.text = final

				await get_tree().create_timer(time_between_characters).timeout
				if not is_writing:
					return

			current_line += style_part_one
			current_line += text_between
			current_line += style_part_two
		else:
			await get_tree().create_timer(time_between_characters).timeout

		if not is_writing:
			return
			
		current_line = current_line + text[index]
		main_text.text = str(current_line)
		index += 1

	is_writing = false


func _read_until_character(text: String, target: String, include_target: bool) -> String:
	var result = ""

	while index < text.length() && text[index] != target:
		result += text[index]
		index += 1

	if include_target:
		result += text[index]
		index += 1

	return result


func display_options(button_texts: Array[String], callback):
	button_panel.visible = true
	
	for button in button_texts:
		var spawned_button = button_prefab.instantiate()
		spawned_button.text = button
		button_holder.add_child(spawned_button)

		spawned_button.pressed.connect(callback)
		spawned_button.pressed.connect(_reset_after_choice)


func full_line(text: String):
	main_text.text = text
	is_writing = false


func _reset_after_choice():
	for button in button_holder.get_children():
		button.queue_free()

	is_writing = false
	button_panel.visible = false
