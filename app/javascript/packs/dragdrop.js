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

  uploadArea.addEventListener('drop', function(e) {
    e.preventDefault();
    e.stopPropagation();

    saveStudentRoster();

    // let data = e.dataTransfer.getData("text");
    // e.target.appendChild(document.getElementById(file));

    console.log(e);
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

