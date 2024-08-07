// This function is called in application.js:

export function initialize_reports() {
    function setUpReportCopyButtons() {

        const button = document.querySelector("#rpt-copy-button");
        if (! button)
            return;

        const handler = function() {
            const textToCopy = new RegExp("<div><pre>(.*)</pre></div>").
            exec(activePane.innerHTML)[1]

            const activePane = document.querySelector(".rpt-tab-pane.active");
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

        button.addEventListener("click", handler);
    }

    function setupCopyButtonVisibility() {
        // Nothing to do on the button itself, but the tabs need to be set up to control its visibility.

        const copyButton = document.querySelector("#rpt-copy-button");
        if (! copyButton)
            return;

        copyButton.style.visibility = "hidden"; // hidden because initial tab selected is HTML

        const buttonVisibilityHandler = function (visible) {
            return function() {
                copyButton.style.visibility = visible ? "visible" : "hidden";
            }
        }

        for (const rptTab of document.querySelectorAll(".rpt-nav-tab")) {
            const copyButtonVisible = ! rptTab.id.includes("html");
            rptTab.addEventListener("click", buttonVisibilityHandler(copyButtonVisible));
        }
    }


    function setupReportBackButton() {
        const button = document.querySelector("#rpt-back-button");
        if (! button) // this will be called on all pages, some without the button
            return;

        const loadReportsPage = function() { window.location.href = "/reports"; };
        button.addEventListener("click", loadReportsPage);
    }

    document.addEventListener("turbo:load", () => {
        setUpReportCopyButtons();
        setupCopyButtonVisibility();
        setupReportBackButton();
    });
}
