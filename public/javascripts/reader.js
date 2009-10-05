$(document).ready(function() {
    setTimeout("fadeNotices()", 3000);
    
    // Highlight validation errors
    $('p.haserror').css('background-color', '#ffff77');
    setTimeout("removeHighlight('p.haserror')", 2000);
});


// Get rid of radiant notifications (after a pause)
fadeNotices = function () {
    $('div.notice').fadeOut();
    $('div.error').fadeOut();
}


// Hide the yellow highlight (since we can't fade it without a plugin in jQuery)
removeHighlight = function(element) {
    $(element).css('background', 'none');
}