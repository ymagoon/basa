/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'bootstrap';
import 'daterangepicker';
import { initializeDateRangePicker } from './picker';
// import { dragAndDrop } from './dragdrop';



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


  console.log('working');


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
}

initializeDateRangePicker();
dragAndDrop();

console.log('Hello World from Webpacker')
