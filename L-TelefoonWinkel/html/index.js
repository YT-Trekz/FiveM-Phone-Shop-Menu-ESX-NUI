$(function () {

    function display(bool) {
        if (bool) {
            $("#inventory-container").show();
        } else {
            $("#inventory-container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://L-TelefoonWinkel/exit', JSON.stringify({}));
            return
        }
    };

    $(".close").click(function () {
        $.post('http://L-TelefoonWinkel/exit', JSON.stringify({}));
        return
    })

    $(".iphone").click(function () {
        $.post('http://L-TelefoonWinkel/phone', JSON.stringify({}));
        return
    })

    $(".iphoneee").click(function () {
        $.post('http://L-TelefoonWinkel/radio', JSON.stringify({}));
        return
    })
})