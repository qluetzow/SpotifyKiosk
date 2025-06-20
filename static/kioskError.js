function restartKiosk() {
    fetch("http://localhost:8080/restart", {
        method: "POST",
        headers: {
            "Content-Length": 0
        }
    })
}

document.getElementById("button").addEventListener('click', restartKiosk);
