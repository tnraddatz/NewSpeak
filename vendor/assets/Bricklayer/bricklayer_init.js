//turbolinks cache is turned off for bricklayer pages
$(document).on('turbolinks:load', function() {
  if($(".bricklayer").length){
    window.bricklayer = new Bricklayer(document.querySelector('.bricklayer'));
  }
});
