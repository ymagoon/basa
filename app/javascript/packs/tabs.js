
function tabs() {
  let tabs = document.getElementsByClassName("tab");
  var i;

  for (i = 0; i < tabs.length; i++) {
      tabs[i].addEventListener("click", function() {
          this.classList.toggle("active");
      });
  }
}
export { tabs };
