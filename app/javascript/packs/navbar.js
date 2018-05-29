/* Set the width of the side navigation to 120px */
function openNav() {
    document.getElementById("mySidenav").style.width = "90px";
    document.body.style.backgroundColor = "rgba(0,0,0,0.4)";
}

/* Set the width of the side navigation to 0 */
 function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.body.style.backgroundColor = "white";
}

function initNav(){
  document.getElementById("nav-btn").onclick = openNav;
  document.getElementById("close-btn").onclick = closeNav;
}



export { initNav };
