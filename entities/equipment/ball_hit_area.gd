extends Area3D


func hit(originator: Node3D):
    get_parent().hit(originator)
