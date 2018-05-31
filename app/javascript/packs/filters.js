function filter() {
  let form = document.getElementById('filter');
  let inputs = document.querySelectorAll('.checkbox')
  let submit = document.getElementById('submit');

  inputs.forEach(function(input) {
    input.addEventListener("click", function() {

      submit.click();
    });
  });
}

export { filter }
