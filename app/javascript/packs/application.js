// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "../stylesheets/application"

document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
})


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


function setUpYouTubeClicks() {
    const handler = function() {
        const url = this.getAttribute("data-url");
        document.getElementById("youtube-player-iframe").setAttribute("src", url);
    }

    for(const elem of document.getElementsByClassName("youtube-view")) {
        elem.addEventListener("click", handler);
    }
}


function setUpColorPopup() {
    const handler = function() {
        alert("Color chooser");
    }
    for(const elem of document.getElementsByClassName("color-popup")) {
        elem.addEventListener("click", handler)
    }
}


function setUpColorPicker() {

    const colorPicker = document.getElementById("bgcolor-picker");

    // Sets the color of the color picker to the body's background color after the UI is loaded:
    // function setInitialColor() {
    //     const color = document.body.style.background;
    //     console.log("Background color is " + color);
    //     colorPicker.value = "#333333";
    // }
    // window.addEventListener("load", setInitialColor, false);

    const colorChangeHandler = function(event) {
        const newColor = event.target.value;
        document.body.style.background = newColor;
        document.getElementById("bg-color-value-text").innerHTML = newColor;
    }

    colorPicker.addEventListener("input", colorChangeHandler, false);
    colorPicker.addEventListener("change", colorChangeHandler, false);
}

// DOMContentLoaded event handling:
document.addEventListener('DOMContentLoaded', (event) => {
    setUpYouTubeClicks();
    setUpColorPopup();
    setUpColorPicker();
})


