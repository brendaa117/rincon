// Validación básica de formulario
document.getElementById("login-form").addEventListener("submit", function (e) {
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value.trim();

    if (email === "" || password === "") {
        alert("Por favor completa todos los campos.");
        e.preventDefault();
    }
});
