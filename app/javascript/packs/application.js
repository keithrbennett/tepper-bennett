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
    const menuItemIds = function() {
        return [...document.querySelectorAll(".main-menu-item")].map(elem => elem.id)
        // e.g. ["main-menu-home", "main-menu-songs", "main-menu-genres", "main-menu-elvis", "main-menu-resources", "main-menu-reports", "main-menu-inquiries"]
    }

    const targetMenuItem = function(path_component) {
        const targetId = "main-menu-" + path_component;
        return menuItemIds().includes(targetId) ? targetId : "main-menu-home";
    }

    const pathTop = new URL(window.location.href).pathname.split('/')[1];
    const activeMenuItemId = targetMenuItem(pathTop);
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

    const handler = function() {
        const activePane = document.querySelector(".rpt-tab-pane.active");
        const textToCopy = activePane.innerHTML.split("<div><pre>")[1].split("</pre></div>")[0]
        activePane.focus(); // without this, the clipboard copy fails
        navigator.clipboard.writeText(textToCopy)
        .then(
            () => {
                console.log("Copied to clipboard: " + activePane.id);
                    alert("Content copied to clipboard.");
            },
            (error) => { console.log("Error copying text from", activePane.id + ':', error); }
        )
    }

    document.querySelector("#rpt-copy-button").addEventListener("click", handler);
}

function setupCopyButtonVisibility() {
    // Nothing to do on the button itself, but the tabs need to be set up to control its visibility.

    const copyButton = document.querySelector("#rpt-copy-button")
    copyButton.style.visibility = "hidden"; // hidden because initial tab selected is HTML

    const buttonVisibilityHandler = function (visible) {
        return function() {
            console.log("in click event, visible = ", visible);
            copyButton.style.visibility = visible ? "visible" : "hidden";
        }
    }

    for (const rptTab of document.querySelectorAll(".rpt-nav-tab")) {
        const copyButtonVisible = ! rptTab.id.includes("html");
        console.log("Setting click handler on ", rptTab);
        rptTab.addEventListener("click", buttonVisibilityHandler(copyButtonVisible));
    }
}


function setupReportBackButton() {
    const loadReportsPage = function() { window.location.href = "/reports"; };
    document.querySelector("#rpt-back-button").addEventListener("click", loadReportsPage);
}


// DOMContentLoaded event handling:
document.addEventListener('DOMContentLoaded', (event) => {
    console.log("DOM content loaded.");
    setUpYouTubeClicks();
});


document.addEventListener("turbolinks:load", () => {
    console.log("Turbolinks loaded.");
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()
    setUpMainMenuLinks();
    setInitialMenuChoice();
    setUpColorPicker();
    setUpReportCopyButtons();
    setupCopyButtonVisibility();
    setupReportBackButton();
});


