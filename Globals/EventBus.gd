extends Node

signal on_platform_create(platformPos : Vector3)

func emit_on_platform_create(platformPos : Vector3):
	on_platform_create.emit(platformPos)
