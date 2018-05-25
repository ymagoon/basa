function saveStudentRoster(student_id, course_id) {
  const uploadArea = document.querySelector('.upload-area');
  // uploadArea.dataset.remote = 'true';
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
     uploadArea.innerHTML = this.responseText;
    }
  };

   // course_student_rosters POST   /courses/:course_id/student_rosters(.:format
  xhttp.open("POST", "/courses", true); // /course_id/student_rosters/student_id
  xhttp.send();
}

function dragAndDrop() {
  // preventing page from redirecting
  const html = document.documentElement
  const uploadArea = document.querySelector('.upload-area');
  const students = document.querySelectorAll('.student_card ');
  // console.log(students);

  html.addEventListener('dragover',function(e) {
    e.preventDefault();
    e.stopPropagation();
    // console.log(e);
  });

  html.addEventListener('drop', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  for(var i=0; i< students.length; i++) {
    students[i].addEventListener('dragstart', function(e) {

      const studentCard = e.target;
      const dataId = studentCard.dataset.student
      console.log(studentCard);
      e.dataTransfer.setData("student-id", dataId);
    });
  };

  uploadArea.addEventListener('dragenter', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  uploadArea.addEventListener('dragover', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });

  uploadArea.addEventListener('drop', function(e) {
    e.preventDefault();
    e.stopPropagation();

    saveStudentRoster();

    var target = e.target;

    let data = e.dataTransfer.getData("student-id");
    const studentCard = document.getElementById(data);

    e.target.appendChild(studentCard);

    // let data = e.dataTransfer.getData("text");
    // e.target.appendChild(document.getElementById(file));

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

