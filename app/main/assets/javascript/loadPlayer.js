jQuery(function() {
  // Setup the player to autoplay the next track
  var a = audiojs.createAll({
    trackEnded: function() {
      var next = $('ol.playlist li.playing').next();
      if (!next.length) next = $('ol.playlist li').first();
      next.addClass('playing').siblings().removeClass('playing');
      audiojs.load($('a', next).attr('data-src'));
      audiojs.play();
    }
  });

  // Load in the first track
  var audio = a[0];

  first = $('ol.playlist a').attr('data-src');
  $('ol.playlist li').first().addClass('playing');
  audiojs.load(first);

  // Load in a track on click
  $('ol.playlist li').click(function(e) {
    e.preventDefault();
    $(this).addClass('playing').siblings().removeClass('playing');
    audio.load($('a', this).attr('data-src'));
    audio.play();
  });

  // Keyboard shortcuts
  jQuery(document).keydown(function(e) {
    var unicode = e.charCode ? e.charCode : e.keyCode;
       // right arrow
    if (unicode == 39) {
      var next = $('li.playing').next();
      if (!next.length) next = $('ol.playlist li').first();
      next.click();
      // back arrow
    } else if (unicode == 37) {
      var prev = $('li.playing').prev();
      if (!prev.length) prev = $('ol.playlist li').last();
      prev.click();
      // spacebar
    } else if (unicode == 32) {
      audio.playPause();
    }
  })
});