//POLYFLLS
//SMOOTH PAGE SCROLL
$(document).ready(function(){
    // Add smooth scrolling to all links
    $("a").on('click', function(event) {
    
        // Make sure this.hash has a value before overriding default behavior
        if (this.hash !== "") {
        // Prevent default anchor click behavior
        event.preventDefault();
    
        // Store hash
        var hash = this.hash;
    
        // Using jQuery's animate() method to add smooth page scroll
        // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
        // -100 to offset the navbar height
        $('html, body').animate({
            scrollTop: $(hash).offset().top - 100
        }, 800, function(){
        });
        } // End if
    });
});

function loadSettingsPage() {
    window.location.pathname = 'settings';
}

function loadSearchPage() {
    window.location.pathname = 'spotify';
}

function getPin() {
    let url_string = window.location;
    let url = new URL(url_string);

    return url.searchParams.get("p");
}
