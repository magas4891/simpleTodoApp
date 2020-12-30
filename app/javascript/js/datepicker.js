$(function(){
    $("[id^='datepicker']").datepicker({
        beforeShow: function() {
            setTimeout(function(){
                $('.ui-datepicker').css('z-index', 99999999999999);
            }, 0);
        },
        showOn: "button",
        buttonImage: "https://snipp.ru/demo/437/calendar.gif",
        buttonImageOnly: true,
        dateFormat: 'dd.mm.yy',
        buttonText: "Choose deadline"
    });
});