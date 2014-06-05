var shadeRGBColor = function(color, percent) {
    var f=color.split(","),t=percent<0?0:255,p=percent<0?percent*-1:percent,R=parseInt(f[0].slice(4)),G=parseInt(f[1]),B=parseInt(f[2]);
    return "rgb("+(Math.round((t-R)*p)+R)+","+(Math.round((t-G)*p)+G)+","+(Math.round((t-B)*p)+B)+")";
}

var shadeColorLight = function(color) {
    return shadeRGBColor(color, 0.5);
}


var SUBTREE = 0;
var RESIZE = 1;
var rules = [];
var updateReferences = function (cause) {
    rules.forEach(function (f) {
        f(cause);
    });
};
$(document).on('DOMSubtreeModified *', function () {
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