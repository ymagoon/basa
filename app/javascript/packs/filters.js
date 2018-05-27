function filter() {
  let form = document.getElementById('filter'); // the form
  let inputs = document.querySelectorAll('.filter') // the check boxes
  let submit = document.getElementById('submit');

  inputs.forEach(function(input) {
    input.addEventListener("click", function() {

      submit.click();
      // $("#location-filter").submit();
    });
  });
}

// $("#location-filter").submit();

export { filter }
