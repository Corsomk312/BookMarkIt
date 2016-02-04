var args = require('system').args;
var url = args[1];
var filename = args[2];

var Screenshot = function(url, filename) {
  this.url = url;
  this.filename = filename;
}

Screenshot.prototype.grab = function() {
  var page = require('webpage').create();
  page.viewportSize = { width: 1024, height: 768 };
  // page.zoomFactor = 0.25;
  page.clipRect = { top: 0, left: 0, width: 384, height: 288 };   // Previously 576 x 432
  page.open(this.url, function() {
    page.render(filename, {format: 'jpg', quality: '20'});
    phantom.exit();
  });
}

getit = new Screenshot(url);
getit.grab();