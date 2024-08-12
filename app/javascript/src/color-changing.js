function setUpColorPicker() {

    const colorPicker = document.getElementById("bgcolor-picker");
    const bgColorResetter = document.getElementById("bgcolor-resetter");

    function setBackgroundColor(color) {
        // console.log("Setting background color to " + color);
        colorPicker.setAttribute("value", color);
        document.body.style.background = color;
        localStorage.setItem("background-color", color);
        document.getElementById("bg-color-value-text").innerHTML = color;

        updateTableColors();
    }

    function setInitialColor() {
        // console.log('in set initial color');
        const color = localStorage.getItem("background-color") || defaultBackgroundColor();
        setBackgroundColor(color);
        updateTableColors();
    }

    function colorChangeHandler(event) {
        setBackgroundColor(event.target.value);
        updateTableColors();
    }

    function resetBackgroundColor() {
        // console.log('in reset bg color')
        setBackgroundColor(defaultBackgroundColor());
        updateTableColors();
    }

    setInitialColor();
    colorPicker.addEventListener("input", colorChangeHandler, false);
    colorPicker.addEventListener("change", colorChangeHandler, false);
    bgColorResetter.addEventListener("click", resetBackgroundColor);
}

function updateTableColors() {
    function darken(color, percentage) {
        // Remove the hash from the color if it's there
        color = color.charAt(0) === '#' ? color.substring(1, 7) : color;

        // Convert the color to RGB
        let r = parseInt(color.substring(0, 2), 16);
        let g = parseInt(color.substring(2, 4), 16);
        let b = parseInt(color.substring(4, 6), 16);

        // Darken the color by the given percentage
        r = Math.floor(r * (100 - percentage) / 100);
        g = Math.floor(g * (100 - percentage) / 100);
        b = Math.floor(b * (100 - percentage) / 100);

        // Convert the color back to hexadecimal
        r = r.toString(16).padStart(2, '0');
        g = g.toString(16).padStart(2, '0');
        b = b.toString(16).padStart(2, '0');

        // Return the darkened color
        return '#' + r + g + b;
    }
    // const bgColor = getComputedStyle(document.body).getPropertyValue('--bs-table-accent-bg');
    const bgColor = document.body.style.background;

    // Format color as hex:
    const rgbColorMatch = document.body.style.background.match(/\d+,\s*\d+,\s*\d+/);
    const rgbColor = rgbColorMatch[0].split(',').map(Number);
    // Convert the RGB color to hexadecimal
    const hexColor = rgbToHex(...rgbColor);


    // console.log("current background color: " + hexColor);

    // console.log('getComputedStyle(document.body).getPropertyValue(\'--bs-table-accent-bg\')')
    // console.log(getComputedStyle(document.body).getPropertyValue('--bs-table-accent-bg'))
    //
    // console.log('getComputedStyle(document.body).getPropertyValue(\'--bs-table-striped-bg\')')
    // console.log(getComputedStyle(document.body).getPropertyValue('--bs-table-striped-bg'))
    //
    const stripedColor = bgColor; // Set this to your desired text color for striped rows
    const stripedBg = darken(bgColor, 10);
    document.body.style.setProperty('--bs-table-striped-color', stripedColor);
    document.body.style.setProperty('--bs-table-striped-bg', stripedBg);
    document.body.style.setProperty('--bs-table-bg', stripedBg);

    // console.log('after set, getComputedStyle(document.body).getPropertyValue(\'--bs-table-striped-bg \')')
    // console.log(getComputedStyle(document.body).getPropertyValue('--bs-table-accent-bg'))

}
