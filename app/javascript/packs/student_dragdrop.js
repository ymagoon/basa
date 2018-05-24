function drop(event) {
    event.preventDefault();
    let data = ev.dataTransfer.getData("text");
    event.target.appendChild(document.getElementById(draganddrop));
}


// export { drop };
