import Chartkick from "chartkick";
import Chart from "chart.js";

Chartkick.addAdapter(Chart);

Chartkick.options = {
  height: "200px",
  width: "200px",
  colors: ["#77C9D4", "#57BC90", "#B9929F", "#E2C2C6", "#B47EB3", "#E85D75", "#077187", "#D9F0FF" ],
  legend: "bottom"
}

window.Chartkick = Chartkick;

