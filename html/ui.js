function addGaps(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
    }
    return x1 + x2;
}

function addCommas(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + '.<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
    }
    return x1 + x2;
}

$(document).ready(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        $('.identidade').html(item.identidade);
        $('#salario').html(item.salario)



        if (item.openBank == true) {
            $(".container").fadeIn();
            $('.currentBalance').html(' ' + addCommas(item.bank));
            $('.carteira').html(' ' + addCommas(item.cart));
            $('.multas').html('$ ' + addCommas(item.multas));
            $('#salario').html(item.salario);


            let banco_data = item.banco
            for (let item in banco_data) {
                $("#extrato").append(`
                <div class="item">
                    <div class="icon"><i class="far fa-chart-line"></i></div>
                    <div class="item-text">
                        <label>Evento</label><br>
                        <span>saque</span>
                    </div>
                    <div class="item-text-price">
                        <label style="color: #92DBAC;">` + banco_data[item].extrato + `</label><br>
                        <span>` + banco_data[item].data + `</span>
                    </div>
                </div>
            `);
            }
        }

        if (item.updateBalance == true) {
            $('.currentBalance').html(' ' + addCommas(event.data.bank));
            $('.carteira').html(' ' + addCommas(event.data.cart));
        }

        if (item.openBank == false) {
            $(".container").fadeOut();
            $('#extrato').html('')
        }
    });

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://qb_banco/close', JSON.stringify({}));
        }
    };

    $("#SaqueRapido").click(function() {
        $.post('http://qb_banco/quickCash', JSON.stringify({}));
    });

    $("#fastCash").click(function() {
        $.post('http://qb_banco/fastCash', JSON.stringify({}));
    });

    $("#saque").submit(function(e) {
        e.preventDefault();

        //console.log("SACOU")

        $("#saque #amount").prop('disabled', false)
        $.post('http://qb_banco/withdrawSubmit', JSON.stringify({
            amount: $("#saque #amount").val()
        }));

        setTimeout(function() {
            $("#sacar #amount").prop('disabled', false);
            $("#sacar #submit").css('display', 'block');
        }, 2000)

    });

    $("#depositar").submit(function(e) {
        e.preventDefault();

        //console.log("DEPOSITOU")

        $("#depositar #amount").prop('disabled', false)
        $.post('http://qb_banco/depositSubmit', JSON.stringify({
            amount: $("#depositar #amount").val()
        }));

        setTimeout(function() {
            $("#depositar #amount").prop('disabled', false);
            $("#depositar #submit").css('display', 'block');
        }, 2000)

    });

    $("#multas").submit(function(e) {
        e.preventDefault();

        //console.log("DEPOSITOU")

        $("#multas #amount").prop('disabled', false)
        $.post('http://qb_banco/multasSubmit', JSON.stringify({
            amount: $("#multas #amount").val()
        }));

        setTimeout(function() {
            $("#multas #amount").prop('disabled', false);
            $("#multas #submit").css('display', 'block');
        }, 2000)

    });

});