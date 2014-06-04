var SUBTREE = 0;
var RESIZE = 1;
var rules = [];

// updates all references
var updateReferences = function(cause) {
  rules.forEach(function(f) {
    f(cause);
  })
}

// listeners to trigger style changes
$(document).on(‘DOMSubtreeModified’, function() {
  updateReferences({subtree: true});
});

$(window).resize(function() {
  updateReferences({resize: true});
});

// defines behavior for a single reference
rules.push(function(cause) {
  // TODO check cause
  if (!cause.subtree && !cause.resize) {
    return;
  }

  // get necessary dependencies
  var $el = $('.container #header');

  // enact rule, with function defined elsewhere or inlined in Haskell
  $el.css('width', (divideByTwo)($('body').css('width')));
});
