function dragAndDrop() {
  // preventing page from redirecting
  $("html").on("dragover", function(e) {
      e.preventDefault();
      e.stopPropagation();
      $("h1").text("Drag here");
  });

  $("html").on("drop", function(e) { e.preventDefault(); e.stopPropagation(); });

  // Drag enter
  $('.upload-area').on('dragenter', function (e) {
      e.stopPropagation();
      e.preventDefault();
      $("h1").text("Drop");
  });

  // Drag over
  $('.upload-area').on('dragover', function (e) {
      e.stopPropagation();
      e.preventDefault();
      $("h1").text("Drop");
  });

  // Drop
  $('.upload-area').on('drop', function (e) {
      e.stopPropagation();
      e.preventDefault();

      $("h1").text("Upload");

      var file = e.originalEvent.dataTransfer.files;
      var fd = new FormData();

      fd.append('file', file[0]);

      uploadData(fd);
  });

  // Open file selector on div click
  $("#uploadfile").click(function(){
      $("#file").click();
  });

  // file selected
  $("#file").change(function(){
      var fd = new FormData();

      var files = $('#file')[0].files[0];

      fd.append('file',files);

      uploadData(fd);
  });
}

    // Sending AJAX request and upload file
function uploadData(formdata){
  $.ajax({
      url: 'upload.php',
      type: 'post',
      data: formdata,
      contentType: false,
      processData: false,
      dataType: 'json',
      success: function(response){
          addThumbnail(response);
      }
  });
}

export { dragAndDrop };
