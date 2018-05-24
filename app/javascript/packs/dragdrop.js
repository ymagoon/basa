function getMetaContent(property, name){
    return document.head.querySelector("["+property+"="+name+"]").content;
}

function saveStudentRoster(student_id, course_id) {
  const uploadArea = document.querySelector('.upload-area');
  uploadArea.dataset.remote = 'true';
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     uploadArea.innerHTML = this.responseText;
    }
  };

   // course_student_rosters POST   /courses/:course_id/student_rosters(.:format
  xhttp.open("POST", `/courses/${course_id}/student_rosters/${student_id}`, true);
  xhttp.send();

  // const csrfToken = getMetaContent('name', 'csrf-token');

  // const url = `/courses/${course_id}/student_rosters/${student_id}`
  // fetch(url, {
  //   method: "POST",
  //   headers: {
  //     "Content-Type": "application/json"
  //     "X-CSRF-Token": csrfToken
  //     // "credentials": "same-origin"
  //   },
  //   body: JSON.stringify({ query: event.currentTarget.value })
  // })
    // .then(response => response.json())
    // .then((data) => {
    //   console.log(data);
    // });

}

// return fetch(url, {
//     body: JSON.stringify(data), // must match 'Content-Type' header
//     cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
//     credentials: 'same-origin', // include, same-origin, *omit
//     headers: {
//       'user-agent': 'Mozilla/4.0 MDN Example',
//       'content-type': 'application/json'
//     },
//     method: 'POST', // *GET, POST, PUT, DELETE, etc.
//     mode: 'cors', // no-cors, cors, *same-origin
//     redirect: 'follow', // manual, *follow, error
//     referrer: 'no-referrer', // *client, no-referrer
//   })
//   .then(response => response.json()) // parses response to JSON
// }

function dragAndDrop() {
  // preventing page from redirecting
  const html = document.documentElement
  const assignedStudents = document.querySelector('.assigned-students');
  const students = document.querySelectorAll('.student_card ');

  html.addEventListener('dragover',function(e) {
    e.preventDefault();
    e.stopPropagation();
    // console.log(e);
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

  for(var i=0; i< students.length; i++) {
    students[i].addEventListener('dragstart', function(e) {

      const studentCard = e.target;
      const studentId = studentCard.dataset.student;
      const courseId = studentCard.dataset.course;

      const ids = [studentId, courseId];

      e.dataTransfer.setData("ids", ids);
      // e.dataTransfer.setData("courseId"), courseId);
      // console.log(e);
    });
  };

  assignedStudents.addEventListener('drop', function(e) {
    e.preventDefault();
    e.stopPropagation();

    const target = e.target;

    // data[0] is student_id and data[1] is the course_id
    const data = e.dataTransfer.getData("ids").split(',');
    const studentCard = document.getElementById(data);

    // e.target.appendChild(studentCard);

    console.log(data);
    saveStudentRoster(data[0], data[1]);
  });
}

export { dragAndDrop }
