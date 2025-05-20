from flask import Flask, render_template, request, redirect, url_for, session, flash
import os
import psycopg2
from psycopg2 import sql

app = Flask(__name__)
app.secret_key = "clave_secreta_segura"

# Datos de conexión
DB_HOST = "localhost"
DB_NAME = "libreria"
DB_USER = "postgres"
DB_PASSWORD = "postgresql"

def get_db_connection():
    conn = psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    return conn

# Vista de registro
@app.route("/", methods=["GET"])
def registro():
    return render_template("registro.html")

# Procesar registro
@app.route("/registro", methods=["POST"])
def registrar_usuario():
    nombre = request.form["nombre"]
    username = request.form["username"]
    email = request.form["email"]
    contrasena = request.form["contrasena"]

    conn = get_db_connection()
    cur = conn.cursor()

    try:
        cur.execute("""
            INSERT INTO Usuarios (nombre, username, email, contraseña)
            VALUES (%s, %s, %s, %s)
        """, (nombre, username, email, contrasena))
        conn.commit()
        flash("Registro exitoso. Inicia sesión.", "success")
    except Exception as e:
        conn.rollback()
        flash("Error al registrar: " + str(e), "danger")
    finally:
        cur.close()
        conn.close()

    return redirect(url_for("login"))

# Vista login
@app.route("/iniciosesion", methods=["GET"])
def login():
    return render_template("iniciosesion.html")

# Procesar login
@app.route("/login", methods=["POST"])
def login_post():
    email = request.form["email"]
    contrasena = request.form["contrasena"]

    conn = get_db_connection()
    cur = conn.cursor()

    cur.execute("""
        SELECT * FROM Usuarios WHERE email = %s AND contraseña = %s
    """, (email, contrasena))
    usuario = cur.fetchone()

    cur.close()
    conn.close()

    if usuario:
        session["usuario"] = usuario[1]  # nombre
        return redirect(url_for("inicio"))
    else:
        flash("Correo o contraseña incorrectos", "danger")
        return redirect(url_for("login"))

# Vista página principal
@app.route("/inicio")
def inicio():
    if "usuario" not in session:
        return redirect(url_for("login"))
    return render_template("pag_prin.html", usuario=session["usuario"])

# Ruta para cerrar sesión
@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))

if __name__ == "__main__":
    app.run(debug=True)
