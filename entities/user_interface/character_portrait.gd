extends BoxContainer


@onready var character_portrait: TextureRect = $TextureRect


func set_icon(icon: Texture) -> void:
	character_portrait.texture = icon