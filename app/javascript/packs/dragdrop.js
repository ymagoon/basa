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








    console.log(e);
  });
}

export { dragAndDrop }

//     // Drop
//     $('.upload-area').on('drop', function (e) {
//         e.stopPropagation();
//         e.preventDefault();

//         $("h1").text("Upload");

//         var file = e.originalEvent.dataTransfer.files;
//         var fd = new FormData();

//         fd.append('file', file[0]);

//         uploadData(fd);
//     });

//     // Open file selector on div click
//     $("#uploadfile").click(function(){
//         $("#file").click();
//     });

//     // file selected
//     $("#file").change(function(){
//         var fd = new FormData();

//         var files = $('#file')[0].files[0];

//         fd.append('file',files);

//         uploadData(fd);
//     });
// });


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
