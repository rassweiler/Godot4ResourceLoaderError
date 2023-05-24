extends Node
class_name SceneManager

var loading : bool = false
var waiting : bool = false
var path : String

func _process(delta: float) -> void:
	if loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(path, progress)
		if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print(progress[0] * 100)
		elif status == ResourceLoader.THREAD_LOAD_LOADED:
			print("Loaded")
			var scene = ResourceLoader.load_threaded_get(path)
			change_scene(scene)
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			var scene = ResourceLoader.load_threaded_get(path)
			print("failed")
			

func load_scene(path : String = "", old_root : Node = null) -> void:
	if path != "":
		self.path = path
		if old_root:
			old_root.hide()
		if ResourceLoader.has_cached(self.path):
			print("Loaded")
			change_scene(ResourceLoader.load_threaded_get(self.path))
		else:
			ResourceLoader.load_threaded_request(self.path,"", true)
			loading = true

func change_scene(scene : PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)
