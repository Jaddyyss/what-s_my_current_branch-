@tool
extends HBoxContainer

@onready var button = %Button


func _ready():
	_refresh_branch()


func _on_button_pressed():
	_refresh_branch()


func _refresh_branch():
	var branch = _get_current_branch()
	print_debug("Current branch: ", branch)
	if button:
		button.text = "  " + branch  # shows on the toolbar button


func _get_current_branch():
	var project_path = ProjectSettings.globalize_path("res://")
	
	# Find the git repo root by running: git -C <project_path> rev-parse --show-toplevel
	var output = []
	var exit_code = OS.execute("git", ["-C", project_path, "rev-parse", "--show-toplevel"], output, true)
	
	if exit_code != 0:
		return "no git"
	
	var repo_root = output[0].strip_edges()
	var head_path = repo_root.path_join(".git/HEAD")
	
	if not FileAccess.file_exists(head_path):
		return "no HEAD"
	
	var file = FileAccess.open(head_path, FileAccess.READ)
	if file == null:
		return "error"
	
	var content = file.get_as_text().strip_edges()
	file.close()
	
	const PREFIX = "ref: refs/heads/"
	if content.begins_with(PREFIX):
		return content.substr(PREFIX.length())
	else:
		return "(" + content.substr(0, 7) + ")"
