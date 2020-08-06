// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("packs/reports")
require('datatables.net-bs4')

import $ from 'jquery';
global.$ = jQuery;

import "bootstrap"
import "../stylesheets/application"

const initialize_application = function() {

    function defaultBackgroundColor() {
        return "#c9d0f1";
    }

// Set up main menu links so that when one is clicked, it is displayed as the active tab, and the content is changed.
    function setUpMainMenuLinks() {
        for (const elem of document.querySelectorAll(".main-menu-item")) {
            elem.addEventListener("click", function (event) {
                window.location.href = event.target.getAttribute("href");
            });
        }
    }


    function setInitialMenuChoice() {
        const menuItemIds = function () {
            return [...document.querySelectorAll(".main-menu-item")].map(elem => elem.id)
            // e.g. ["main-menu-home", "main-menu-songs", "main-menu-genres", "main-menu-elvis", "main-menu-resources", "main-menu-reports", "main-menu-inquiries"]
        }

        const targetMenuItem = function (path_component) {
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
        for (const elem of document.getElementsByClassName("youtube-view")) {
            elem.addEventListener("click", function () {
                const url = this.getAttribute("data-url");
                document.getElementById("youtube-player-iframe").setAttribute("src", url);
            })
        }
    }


    function setUpColorPicker() {

        const colorPicker = document.getElementById("bgcolor-picker");
        const bgColorResetter = document.getElementById("bgcolor-resetter");

        function setBackgroundColor(color) {
            console.log("Setting background color to " + color);
            colorPicker.setAttribute("value", color);
            document.body.style.background = color;
            localStorage.setItem("background-color", color);
            document.getElementById("bg-color-value-text").innerHTML = color;
        }

        function setInitialColor() {
            const color = localStorage.getItem("background-color") || defaultBackgroundColor();
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


    function setUpDataTableStateHandling() {
        $(".data-table").DataTable({
            stateSave: true,
            stateSaveCallback: function (settings, data) {
                localStorage.setItem('DataTables_' + settings.sInstance, JSON.stringify(data))
            },
            stateLoadCallback: function (settings) {
                return JSON.parse(localStorage.getItem('DataTables_' + settings.sInstance))
            }
        });
    }

    // document.addEventListener('DOMContentLoaded', (event) => {
    //     console.log("DOM content loaded, initializing application.");
    // });


    document.addEventListener("turbolinks:load", () => {
        console.log("Turbolinks loaded, initializing application.");
        $('[data-toggle="tooltip"]').tooltip()
        $('[data-toggle="popover"]').popover()
        setUpMainMenuLinks();
        setInitialMenuChoice();
        setUpYouTubeClicks();
        setUpColorPicker();
        setUpDataTableStateHandling();
    });

}

initialize_application();
initialize_reports();  // defined in reports.js


document.addEventListener("turbolinks:before-cache", function() {
    const dataTable = $('.data-table').DataTable();
    console.log(".data-table", dataTable);
    if (dataTable !== null) {
        dataTable.destroy();
    }
});
