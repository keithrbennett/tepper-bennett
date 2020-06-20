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


function defaultBackgroundColor() {
    return "#c9d0f1";
}


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


function setUpColorPicker() {

    const colorPicker     = document.getElementById("bgcolor-picker");
    const bgColorResetter = document.getElementById("bgcolor-resetter");

    function setBackgroundColor(color) {
        console.log("Setting background color to " + color);
        colorPicker.setAttribute("value", color);
        document.body.style.background = color;
        localStorage.setItem("background-color", color);
        document.getElementById("bg-color-value-text").innerHTML = color;
    }

    function setInitialColor() {
        let color = localStorage.getItem("background-color") || defaultBackgroundColor();
        setBackgroundColor(color);
    }

    function colorChangeHandler(event) {
        setBackgroundColor(event.target.value);
    }

    function resetBackgroundColor() {
        setBackgroundColor(defaultBackgroundColor());
    }

    setInitialColor();
    colorPicker.addEventListener("input", colorChangeHandler, false);
    colorPicker.addEventListener("change", colorChangeHandler, false);
    bgColorResetter.addEventListener("click", resetBackgroundColor);
}


function setUpReportCopyButtons() {

    const getActiveTab = function(e) {
        const elementKey = e.target.id.split("btn-copy-")[1];
        const contentTabId = "content-tab-" + elementKey;
        const contentElement = document.getElementById(contentTabId);
        return contentElement.getElementsByClassName("active")[0];
    }

    const handler = function(e) {
        const activeTab = getActiveTab(e);
        if(activeTab.id.includes("html")) {
            alert("Sorry, the Copy command only works in Text, JSON, and YAML report formats.")
        } else {
            const textToCopy = activeTab.innerHTML.split("<div><pre>")[1].split("</pre></div>")[0]
            activeTab.focus();
            navigator.clipboard.writeText(textToCopy)
            .then(
                () => {
                    console.log("Copied to clipboard: " + activeTab.id);
                    alert("Content copied to clipboard");
                },
                (error) => { console.log("Error copying text from", activeTab.id + ':', error); }
            )
        }
    }

    for(const elem of document.getElementsByClassName("rpt-copy-button")) {
        elem.addEventListener("click", handler);
    }
}

// DOMContentLoaded event handling:
document.addEventListener('DOMContentLoaded', (event) => {
    setUpYouTubeClicks();
    setUpColorPicker();
    setUpReportCopyButtons();
})


