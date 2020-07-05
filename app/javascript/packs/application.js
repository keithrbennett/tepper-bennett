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

function defaultBackgroundColor() {
    return "#c9d0f1";
}

// Set up main menu links so that when one is clicked, it is displayed as the active tab, and the content is changed.
function setUpMainMenuLinks() {
    for (const elem of document.querySelectorAll(".main-menu-item")) {
        elem.addEventListener("click", function(event) {
            window.location.href = event.target.getAttribute("href");
        });
    }
}


function setInitialMenuChoice() {
    const href = window.location.href;
    const tokens = href.split("/");
    const tabName = tokens[tokens.length - 1].split("?")[0];
    const activeMenuItemId = (tabName.length > 0) ? ("main-menu-" + tabName) : "main-menu-home";
    document.getElementById(activeMenuItemId).classList.add("active");
    // On initialization there will be no menu items already active, so no needed to remove active class anywhere.
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
        const textToCopy = activeTab.innerHTML.split("<div><pre>")[1].split("</pre></div>")[0]
        activeTab.focus(); // without this, the clipboard copy fails
        navigator.clipboard.writeText(textToCopy)
        .then(
            () => {
                console.log("Copied to clipboard: " + activeTab.id);
                    alert("Content copied to clipboard.");
            },
            (error) => { console.log("Error copying text from", activeTab.id + ':', error); }
        )
    }

    for(const elem of document.getElementsByClassName("rpt-copy-button")) {
        elem.addEventListener("click", handler);
    }
}

function setupCopyButtonVisibility() {
    // Nothing to do on the button itself, but the tabs need to be set up to control its visibility.

    const buttonVisibilityHandler = function (copyButton, visible) {
        return function() {
            copyButton.style.visibility = visible ? "visible" : "hidden";
        }
    }

    for (const rptCard of document.getElementsByClassName("rpt-card")) {
        const copyButton = rptCard.getElementsByClassName("rpt-copy-button")[0];
        for (const rptTab of rptCard.getElementsByClassName("rpt-nav-tab")) {
            const copyButtonVisible = !rptTab.id.includes("html");
            rptTab.addEventListener("click", buttonVisibilityHandler(copyButton, copyButtonVisible));
        }
        copyButton.style.visibility = "hidden"; // hidden because initial tab selected is HTML
    }
}

// DOMContentLoaded event handling:
document.addEventListener('DOMContentLoaded', (event) => {
    console.log("DOM content loaded.");
    setUpYouTubeClicks();
    // setUpReportCopyButtons();
    // setupCopyButtonVisibility();
    setInitialMenuChoice();
});


document.addEventListener("turbolinks:load", () => {
    console.log("Turbolinks loaded.");
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
    setUpMainMenuLinks();
    setUpColorPicker();
});


