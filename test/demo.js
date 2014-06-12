// $(function(){
//     observers.push(new WebKitMutationObserver(function (mutations) {
//       mutations.forEach(function(mutation) {
//         updateReferences({
//             subtree: true
//         });
//       });
//     }).observe($('#top')[0], {
//         attributes: true, 
//         subtree: false,
//         childList: false,
//         bubbles: false }));
// });


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
    var $el = $('#top');
    $el.css('color', $('#main').css('background-color'));
});
rules.push(function (cause) {
    var $el = $('#left');
    $el.css('top', $('#top').css('height'));
    $el.css('color', $('#top').css('background-color'));
});
rules.push(function (cause) {
    var $el = $('#right');
    $el.css('top', $('#top').css('height'));
    $el.css('color', $('#top').css('background-color'));
});
rules.push(function (cause) {
    var $el = $('#middle');
    $el.css('top', $('#top').css('height'));
    $el.css('left', $('#left').css('width'));
    $el.css('right', $('#right').css('width'));
    $el.css('background-color', (shadeColorLight)($('body').css('background-color')));
});