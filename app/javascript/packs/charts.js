import Chartkick from "chartkick";
import Chart from "chart.js";

Chartkick.addAdapter(Chart);

Chartkick.options = {
  height: "400px",
  colors: ["#77C9D4", "#57BC90"]
}

window.Chartkick = Chartkick;

