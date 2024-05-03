class_name NPCClothingResource
extends Resource


@export var name: String
@export var collar_mesh: Mesh
@export var albedo: Texture
@export var roughness: Texture
@export var normal: Texture


func _init(_name := "", _collar_mesh := Mesh.new(), 
    _albedo := Texture.new(), _roughness := Texture.new(), _normal := Texture.new()):
    name = _name

    collar_mesh = _collar_mesh

    albedo = _albedo
    roughness = _roughness
    normal = _normal