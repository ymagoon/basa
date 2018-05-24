import 'bootstrap';
import 'daterangepicker';

import { initializeDateRangePicker } from './picker';
import { dragAndDrop } from './dragdrop';
import { initialize } from './attendance';

initializeDateRangePicker();

if (document.querySelector('.assigned-students') !== null) {
  dragAndDrop();
}

initialize();

console.log('Hello World from Webpacker')

