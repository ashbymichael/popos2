$(document).on("turbolinks:load", function () {
    Handlebars.registerHelper('imageReformat', function(options) {
        var re = /\s/g;
        return new Handlebars.SafeString(options.fn(this).replace(re, '%20'));
    });
})
