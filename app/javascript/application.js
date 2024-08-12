// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import 'bootstrap'
import 'datatables.net-bs5'

import Ujs from '@rails/ujs'
import { Turbo } from "@hotwired/turbo-rails"

import { initialize_reports } from './src/reports'

Ujs.start();
Turbo.start();

import $ from 'jquery';
window.$ = $;

const initialize_application = function() {
  try {
    function defaultBackgroundColor() {
        return "#c9d0f1";
    }

// Set up main menu links so that when one is clicked, it is displayed as the active tab, and the content is changed.
    function setUpMainMenuLinks() {
        for (const elem of document.querySelectorAll(".main-menu-item")) {
            elem.addEventListener("click", function (event) {
                // Remove 'active' class from all menu items
                document.querySelectorAll(".main-menu-item").forEach((item) => {
                    item.classList.remove("active");
                });
                // Add 'active' class to clicked item
                event.target.classList.add("active");
                window.location.href = event.target.getAttribute("href");
            });
        }
    }

    function setInitialMenuChoice() {
        const menuItemIds = function () {
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


// Set up main menu links so that when one is clicked, it is displayed as the active tab, and the content is changed.
    function setUpSongScopeLinks() {
        for (const elem of document.querySelectorAll(".song-scope-item")) {
            elem.addEventListener("click", function (event) {
                window.location.href = event.target.getAttribute("href");
            });
        }
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
        // On initialization there will be no menu items already active, so no needed to remove active class anywhere.
    }


    // Uncomment to copy all static images under ../images to the output folder and reference
    // them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
    // or the `imagePath` JavaScript helper below.
    //
    // const images = require.context('../images', true)
    // const imagePath = (name) => images(name, true)

    function setUpYouTubeClicks() {
        console.log("Setting up YouTube clicks");
        for (const elem of document.getElementsByClassName("youtube-view")) {
            console.log()
            elem.addEventListener("click", function () {
                const url = this.getAttribute("data-url");
                document.getElementById("youtube-player-iframe").setAttribute("src", url);
            })
        }
    }

      document.addEventListener('DOMContentLoaded', function() {
          document.querySelectorAll('.youtube-view').forEach(function(element) {
              element.addEventListener('click', function(event) {
                  event.preventDefault();
                  var url = this.getAttribute('data-url');
                  console.log("Opening YouTube video: " + url);
                  var modal = document.querySelector('#youTubeViewerModal');
                  console.log("Modal: " + modal);
                  var iframe = modal.querySelector('iframe');
                  console.log("iframe: " + iframe);
                  iframe.src = url;
                  $(modal).modal('show');
              });
          });
      });



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
        for (const elem of document.getElementsByClassName("back-action")) {
            elem.addEventListener("click", function () {
                history.back();
            });
        }
    }


    // document.addEventListener('DOMContentLoaded', (event) => {
    //     console.log("DOM content loaded, initializing application.");
    // });


    // Set up Bootstrap.
    document.addEventListener("turbo:load", () => {
        try {
            // setUpColorPicker();
            setUpTableRowBackgroundColorChangeHandling();

        } catch (error) {
            console.error('An error occurred:', error);
            throw error;
        }
    });

    document.addEventListener("turbo:before-cache", function () {
        // console.log("turbo:before-cache")
        const dataTable = $('.data-table').DataTable();
        // console.log(".data-table", dataTable);
        if (dataTable !== null) {
            dataTable.destroy();
        }
    });

    document.addEventListener("turbo:load", function () {
        console.log('in dom content loaded listener')
        try {
            // setUpColorPicker();
            setUpMainMenuLinks();
            setInitialMenuChoice();
            setUpSongScopeLinks();
            setInitialSongsScopeChoice();
            setUpYouTubeClicks();
            setUpDataTableStateHandling();
            setUpBackButtons();
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
