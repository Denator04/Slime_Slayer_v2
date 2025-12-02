extends Node2D

var db : SQLite

func _ready() -> void:
	db = SQLite.new()
	db.path = "user://user_database.db"

	var opened := db.open_db()
	if not opened:
		push_error("Nie udało się otworzyć bazy danych: %s" % db.error_message)
		return

	db.query("""
        CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT
        );
	""")

	$Button_Manager/Login_Menu/Create_New_User_Menu.visible = false

	$Button_Manager/Login_Menu/Login_Button.pressed.connect(Callable(self, "_on_login_pressed"))
	$Button_Manager/Login_Menu/Register_Button.pressed.connect(Callable(self, "_on_show_create_pressed"))
	$Button_Manager/Login_Menu/Create_New_User_Menu/Craete_User_Button.pressed.connect(Callable(self, "_on_create_pressed"))
	$Button_Manager/Login_Menu/Create_New_User_Menu/Close_Window_Button.pressed.connect(Callable(self, "_on_close_create_pressed"))

func _sql_escape(value: String) -> String:
	return value.replace("'", "''")

func _on_show_create_pressed():
	$Button_Manager/Login_Menu/Create_New_User_Menu.visible = true

func _on_close_create_pressed():
	$Button_Manager/Login_Menu/Create_New_User_Menu.visible = false

func _on_login_pressed():
	var username = $Button_Manager/Login_Menu/Username.text.strip_edges()
	var password = $Button_Manager/Login_Menu/Password.text.strip_edges()
	if username == "" or password == "":
		print("Wpisz login i hasło!")
		return

	var where = "username = '%s' AND password = '%s'" % [_sql_escape(username), _sql_escape(password)]
	var results = db.select_rows("users", where, ["id", "username"])
	if results.size() > 0:
		print("Zalogowano jako: %s" % results[0]["username"])
		get_tree().change_scene_to_file("res://Sceny/main_menu.tscn")
	else:
		print("Niepoprawne dane logowania.")

func _on_create_pressed():
	var username = $Button_Manager/Login_Menu/Create_New_User_Menu/Username.text.strip_edges()
	var password = $Button_Manager/Login_Menu/Create_New_User_Menu/Password.text.strip_edges()
	if username == "" or password == "":
		print("Wpisz login i hasło!")
		return

	var row = {
		"username": username,
		"password": password
	}

	var ok = db.insert_row("users", row)
	if ok:
		print("Użytkownik utworzony.")
		$Button_Manager/Login_Menu/Create_New_User_Menu.visible = false
	else:
		print("Nie udało się utworzyć użytkownika: %s" % db.error_message)


func _on_cancel_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Sceny/main_menu.tscn")
