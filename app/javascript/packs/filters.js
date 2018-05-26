function filter() {
  let form = document.getElementById('location-filter'); // the form
  let inputs = document.querySelectorAll('.location-filter') // the check boxes
  let submit = document.getElementById('submit');

  inputs.forEach(function(input) {
    console.log('inside baby');
    input.addEventListener("click", function() {

      submit.click();
      // $("#location-filter").submit();
    });
  });
}

// $("#location-filter").submit();

export { filter }
