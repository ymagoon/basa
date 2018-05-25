function changeColor(e, presence) {
  const target = e.target

  // change class of div to change color
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

  // Call a function when the state changes
  request.onreadystatechange = function() {
    if(request.readyState == XMLHttpRequest.DONE && request.status == 200) {
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
