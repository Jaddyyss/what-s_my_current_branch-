@tool
extends EditorPlugin

var toolbar

func _enable_plugin():
	# Add autoloads here.
	pass


func _disable_plugin():
	# Remove autoloads here.
	pass


func _enter_tree():
	# Initialization of the plugin goes here.
	toolbar = preload("uid://dcm2bgi2x244b").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, toolbar)
	


func _exit_tree():
	# Clean-up of the plugin goes here.
	if toolbar:
		remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, toolbar)
		toolbar.queue_free()
		toolbar = null
