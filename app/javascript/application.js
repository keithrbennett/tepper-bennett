import * as bootstrap from 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

import 'datatables.net-bs5'
import DataTable from 'datatables.net-bs5';

import Ujs from '@rails/ujs'
import { Turbo } from "@hotwired/turbo-rails"

import { initialize_reports } from './src/reports'

Ujs.start();
Turbo.start();

const initialize_application = function() {
    const bootstrap_ok = (typeof bootstrap !== 'undefined' && typeof bootstrap.Modal !== 'undefined')
    console.log("Bootstrap 5 JS is " + (bootstrap_ok ? '' : 'not') + "loaded.");

    try {
        function defaultBackgroundColor() {
            return "lightskyblue";
    }

    // Set up main menu links so that when one is clicked, it is displayed as the active tab, and the content is changed.
    function setUpMainMenuLinks() {
        document.querySelectorAll(".main-menu-item").forEach((elem) => {
            elem.addEventListener("click", function (event) {
                document.querySelectorAll(".main-menu-item").forEach((item) => {
                    item.classList.remove("active");
                });
                event.target.classList.add("active");
                window.location.href = event.target.getAttribute("href");
            });
        });
    }

    function setInitialMenuChoice() {
        const menuItemIds = () => [...document.querySelectorAll(".main-menu-item")].map(elem => elem.id);

        const targetMenuItem = function(path_component) {
            const targetId = "main-menu-" + path_component;
            return menuItemIds().includes(targetId) ? targetId : "main-menu-home";
        }

        const pathTop = new URL(window.location.href).pathname.split('/')[1];
        const activeMenuItemId = targetMenuItem(pathTop);
        document.getElementById(activeMenuItemId).classList.add("active");
        // On initialization there will be no menu items already active, so no needed to remove active class anywhere.
    }


    function setUpSongScopeLinks() {
        document.querySelectorAll(".song-scope-item").forEach((elem) => {
            elem.addEventListener("click", function (event) {
                window.location.href = event.target.getAttribute("href");
            });
        });
    }


    function setInitialSongsScopeChoice() {

        const paths = new URL(window.location.href).pathname.split('/');

        const isListPage = (paths[1] == 'songs' && (paths[2] == 'list' || paths[2] == null))
        if (!isListPage)
            return;

        const targetScope = paths[3] || 'best';
        const targetId = 'songs-scope-' + targetScope;
        const targetElement = document.getElementById(targetId);
        targetElement.classList.add("active");
        // On initialization there will be no menu items already active, so no need to remove active class anywhere.
    }


    // Uncomment to copy all static images under ../images to the output folder and reference
    // them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
    // or the `imagePath` JavaScript helper below.
    //
    // const images = require.context('../images', true)
    // const imagePath = (name) => images(name, true)

    function setUpYouTubeClicks() {
        console.log("Setting up YouTube clicks");
        document.querySelectorAll('.youtube-view').forEach(function (element) {
            element.addEventListener('click', function (event) {
                event.preventDefault();
                const url = this.getAttribute("data-url");
                console.log("Got YouTube video URL: " + url);
                var modal = document.querySelector('#youTubeViewerModal');
                console.log("Modal: " + modal);
                console.log(modal);
                var iframe = modal.querySelector('iframe');
                console.log("iframe: " + iframe);
                iframe.src = url;
                const bootstrapModal = new bootstrap.Modal(modal);
                bootstrapModal.show();
            });
        });
    }


    function setUpDataTableStateHandling() {
        document.querySelectorAll(".data-table").forEach((table) => {
            new DataTable(table, {
                stateSave: true,
                stateSaveCallback: function (settings, data) {
                    localStorage.setItem('DataTables_' + settings.sInstance, JSON.stringify(data))
                },
                stateLoadCallback: function (settings) {
                    return JSON.parse(localStorage.getItem('DataTables_' + settings.sInstance))
                }
            });
        });
    }

    function setUpTableRowBackgroundColorChangeHandling() {
        // Create a new MutationObserver instance
        const observer = new MutationObserver((mutationsList, observer) => {
            // Look through all mutations that just occured
            for(let mutation of mutationsList) {
                // If the style attribute was modified
                if(mutation.attributeName === 'style') {
                    // Call your function to update the table row colors
                    updateTableColors();
                }
            }
        });
        // Start observing the body element for attribute changes
        observer.observe(document.body, { attributes: true });
    }

    function setUpBackButtons() {
        document.querySelectorAll(".back-action").forEach((elem) => {
            elem.addEventListener("click", function () {
                history.back();
            });
        });
    }

    document.addEventListener("turbo:before-cache", function () {
        document.querySelectorAll('.data-table').forEach((table) => {
            const dataTable = new DataTable(table);
            if (dataTable !== null) {
                dataTable.destroy();
            }
        });
    });

    document.addEventListener("turbo:load", function () {
        console.log('in turbo:load listener')

        try {
            // setUpColorPicker();
            setUpMainMenuLinks();
            setInitialMenuChoice();
            setUpSongScopeLinks();
            setInitialSongsScopeChoice();
            setUpYouTubeClicks();
            setUpDataTableStateHandling();
            setUpBackButtons();
            setUpTableRowBackgroundColorChangeHandling();
            // document.getElementById("bgcolor-picker").addEventListener("change", updateTableColors);

        } catch (error) {
            console.error('An error occurred:', error);
            throw error;
        }
    });

    } catch (error) {
    console.error('An error occurred during application initialization:', error);
}

}

initialize_application();
initialize_reports();  // defined in reports.js
