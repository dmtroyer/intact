// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
    $("form#new_hashed_string").closest('form').on('submit', function(e) {
        $("#process-btn").prop('disabled', true);
    });
});
