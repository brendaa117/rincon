from flask import Flask, render_template
import os
import sqlite3

app = Flask(__name__)

# Ruta a la base de datos
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATABASE = os.path.join(BASE_DIR, 'database', 'rincon.db')

# Página de inicio de usuario
@app.route("/usuario")
def usuario():
    return render_template("usuario.html")

# Página principal
@app.route("/inicio")
def inicio():
    return render_template("pag_prin.html")

# Página de login
@app.route("/login")
def login():
    return render_template("pag_inicio.html")

# Ejemplo de conexión a la base de datos
def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

if __name__ == "__main__":
    app.run(debug=True)
