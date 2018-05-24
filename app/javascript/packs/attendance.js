function changeColor(e, presence) {
  // temporary change status until AJAX is implemented which will handle this
  const target = e.target
  console.log(presence.attendance);
  console.log(e.target);

  if (presence.attendance === 'absent') {
    target.classList.remove('present');
    target.classList.add('absent');
  } else {
    target.classList.remove('absent');
    target.classList.add('present');
  }
}

function updateAttendance(e) {
  const request = new XMLHttpRequest();
  const target = e.target
  const courseId = target.dataset.course
  const attendance = target.dataset.attendance

  // Call a function when the state changes.
  request.onreadystatechange = function() {
    if(request.readyState == XMLHttpRequest.DONE && request.status == 200) {
      // request.onload = callback;
      changeColor(e, JSON.parse(this.responseText));
    }
  }

  request.open("PATCH", `/courses/${courseId}/attendance`, true);
  // Send the proper header information along with the request
  request.setRequestHeader("Content-Type", "application/json");
  request.send(`{"attendance": "${attendance}"}`);
}

function initialize() {
  document.querySelectorAll('.attendance').forEach(function(e) {
    e.addEventListener('click', updateAttendance);
  });
}

export { initialize }
