function saveStudentRoster(student_id, course_id) {
  const uploadArea = document.querySelector('.upload-area');
  // uploadArea.dataset.remote = 'true';
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     uploadArea.innerHTML = this.responseText;
    }
  };

  console.log(student_id);
  console.log(course_id);
   // course_student_rosters POST   /courses/:course_id/student_rosters(.:format
  xhttp.open("POST", `/courses/${course_id}/student_rosters/${student_id}`, true);
  xhttp.send();
}

function dragAndDrop() {
  // preventing page from redirecting
  const html = document.documentElement
  const uploadArea = document.querySelector('.upload-area');
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

  uploadArea.addEventListener('dragenter', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  uploadArea.addEventListener('dragover', function(e) {
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

  uploadArea.addEventListener('drop', function(e) {
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

    // Sending AJAX request and upload file



// function uploadData(formdata){
//   $.ajax({
//       url: 'upload.php',
//       type: 'post',
//       data: formdata,
//       contentType: false,
//       processData: false,
//       dataType: 'json',
//       success: function(response){
//           addThumbnail(response);
//       }
//   });
// }

