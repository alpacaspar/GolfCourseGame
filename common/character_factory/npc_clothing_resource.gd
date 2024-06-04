class_name NPCClothingResource
extends Resource


@export var name: String
@export var icon: Texture

@export var collar_mesh: Mesh
@export var pants_mesh: Mesh

@export var albedo: Texture
@export var roughness: Texture
@export var normal: Texture


func _init(_name := "", _icon := Texture.new(), _collar_mesh := Mesh.new(), _pants_mesh := Mesh.new(), 
    _albedo := Texture.new(), _roughness := Texture.new(), _normal := Texture.new()):
    name = _name
    icon = _icon 

    collar_mesh = _collar_mesh
    pants_mesh = _pants_mesh

    albedo = _albedo
    roughness = _roughness
    normal = _normal
