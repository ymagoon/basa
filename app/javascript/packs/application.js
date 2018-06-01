import 'bootstrap';


import 'daterangepicker';

import { initializeDateRangePicker } from './picker';
import { dragAndDrop } from './dragdrop';
import { initialize } from './attendance';
import { proficiencyModal } from './proficiencyModal';
import { filter } from './filters';
import { tabs } from './tabs';


filter();
tabs();

proficiencyModal();
initializeDateRangePicker();

if (document.querySelector('.assigned-students') !== null) {
  dragAndDrop();
}

initialize();

console.log('Hello World from Webpacker')

