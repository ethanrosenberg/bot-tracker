function move(percentage) {

    var elem = document.getElementById("myBar");
    var width = elem.style.width;

      if (width <= 99) {
        elem.style.setProperty('--width', percentage + "%");
        elem.innerHTML = percentage  + "%";
      }

}
