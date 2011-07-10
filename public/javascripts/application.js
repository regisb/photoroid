// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $('.thumb-link').click(function()
  {
    $('#main-image').html("<img src='" + this.getAttribute('data-medium') + "'>");
  })
})
