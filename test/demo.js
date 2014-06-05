var SUBTREE = 0;
var RESIZE = 1;
var rules = [];
var updateReferences = function (cause) {
    rules.forEach(function (f) {
        f(cause);
    });
};
$(document).on('DOMSubtreeModified', function () {
    updateReferences({
        subtree: true
    });
});
$(window).resize(function () {
    updateReferences({
        resize: true
    });
});
rules.push(function (cause) {
    var $el = $('#left');
});
rules.push(function (cause) {
    var $el = $('#right');
});
rules.push(function (cause) {
    var $el = $('#middle');
    $el.css('left', $('#left').css('width'));
    $el.css('right', $('#right').css('width'));
});