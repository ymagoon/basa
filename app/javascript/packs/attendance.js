function callback () {
  console.log(this.responseText);
};

function updateAttendance(studentId, sessionId, courseId) {
  const xhttp = new XMLHttpRequest();

//Send the proper header information along with the request
// xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

// xhr.onreadystatechange = function() {//Call a function when the state changes.
//     if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
//         // Request finished. Do processing here.
//     }
// }

  //this should change the color
  // xhttp.onreadystatechange = function() {
  //   if (this.readyState == 4 && this.status == 200) {
  //    assignedStudents.innerHTML = this.responseText;
  //   }
  // };
  console.log('work');
  xhttp.onload = callback;
  xhttp.open("PATCH", `/courses/${courseId}/attendance`, true);
  xhttp.setRequestHeader("Content-Type", "application/json");
  xhttp.send(`{"student": "${studentId}", "session": "${sessionId}"}`);
}

function changeStatus(e) {
  // temporary change status until AJAX is implemented which will handle this
  const target = e.target

  if (target.classList.contains('absent')) {
    target.classList.remove('absent');
    target.classList.add('present');
  } else {
    target.classList.remove('present');
    target.classList.add('absent');
  }
  updateAttendance(target.dataset.student, target.dataset.session, target.dataset.course);
}

function initialize() {
  document.querySelectorAll('.attendance').forEach(function(e) {
    e.addEventListener('click', changeStatus);
  });
}

export { initialize }
