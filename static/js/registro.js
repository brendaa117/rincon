// Detecta el clic en los botones de género y los marca como activos
document.addEventListener("DOMContentLoaded", function () {
    const genderButtons = document.querySelectorAll(".gender-buttons button");

    genderButtons.forEach(button => {
        button.addEventListener("click", () => {
            genderButtons.forEach(btn => btn.classList.remove("active"));
            button.classList.add("active");
        });
    });
});
