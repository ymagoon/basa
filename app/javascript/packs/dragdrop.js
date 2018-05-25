function getMetaContent(property, name){
  return document.head.querySelector("["+property+"="+name+"]").content;
}

function saveStudentRoster(student_id, course_id) {
  const assignedStudents = document.querySelector('.assigned-students');
  const xhttp = new XMLHttpRequest();

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      // document.getElementById('flashes').insertAdjacentHTML('afterbegin', `<p>${this.responseText}</p>`);
    }
  };

  xhttp.open("POST", `/courses/${course_id}/student_rosters/${student_id}`, true);
  xhttp.send();
}

// preventing page from redirecting
function dragAndDrop() {
  const html = document.documentElement
  const assignedStudents = document.querySelector('.assigned-students');
  const students = document.querySelectorAll('.student_card ');

  html.addEventListener('dragover',function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  html.addEventListener('drop', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  assignedStudents.addEventListener('dragenter', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  assignedStudents.addEventListener('dragover', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  // Set event listener for all student cards so when they are dragged they pass student and course ID to ajax request
  for(var i=0; i< students.length; i++) {
    students[i].addEventListener('dragstart', function(e) {
      const studentCard = e.target;
      const studentId = studentCard.dataset.student;
      const courseId = studentCard.dataset.course;
      const ids = [studentId, courseId];

      e.dataTransfer.setData("ids", ids);
    });
  };

  assignedStudents.addEventListener('drop', function(e) {
    const target = e.target;
    const data = e.dataTransfer.getData("ids").split(',');
    const studentCard = document.getElementById(data[0]);

    e.preventDefault();
    e.stopPropagation();

    assignedStudents.appendChild(studentCard);

    saveStudentRoster(data[0], data[1]);
  });
}

export { dragAndDrop }
