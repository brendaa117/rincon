function like() {
    alert("Has dado like al comentario.");
}

function dislike() {
    alert("Has dado dislike al comentario.");
}

function reply() {
    const comment = prompt("Escribe tu respuesta:");
    if (comment) {
        alert("Respuesta enviada: " + comment);
    }
}

function submitComment() {
    const input = document.getElementById("commentInput");
    if (input.value.trim() !== "") {
        alert("Comentario enviado: " + input.value);
        input.value = "";
    } else {
        alert("Por favor, escribe algo antes de enviar.");
    }
}
