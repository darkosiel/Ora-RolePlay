let isLogin = false;
let codeInput = "";
let param = "";
let filter = ["dollar1", "dollar5", "dollar10", "dollar50", "dollar100", "dollar500"];
let am = [1, 5, 10, 50, 100, 500];

$(function(){
    window.onload = (e) => {
        codeInput = document.getElementById("code-input");
		window.addEventListener('message', (event) => {
			var item = event.data;
            if (item !== undefined) {
                switch(item.type) {
                    case "ui":
                        if (item.display) {
                            isLogin = true;
                            param = item.param;
                            updateMenu();
                            updateContent("home");
                            setData();
                        } else{
                            $("#page").hide();
                            isLogin = false;
                            updateMenu();
                        }
                        break;
                    case "checkCode":
                        isLogin = false;
                        param = item.param;
                        $("#page").show();
                        updateMenu();
                        break;
                    case "setMoney":
                        updateAmountSelector(item.param);
                        break;
                    case "eventReturn":
                        if(!item.status) {
                            setTimeout(function() {
                                $.post('https://OraBankMenu/GetData', JSON.stringify({}));
                                updateContent("home");
                            }, 1000);
                        }
                        break;
                    case "setData":
                        param = item.param;
                        setData();
                        break;
                }
            }
		});
        document.onkeyup = function (data) {
            if (data.which == 27) {
                $.post('https://OraBankMenu/exit', JSON.stringify({}));
                codeInput.value = "";
                return;
            }
        }
        for(let touch of document.getElementsByClassName("code-button")) {
            touch.addEventListener("click",(e) => {
                if(codeInput.value.length < 4) {
                    codeInput.value += touch.innerHTML;
                }
            });
        }
        for(let menu of document.getElementById("navbar-menu").children) {
            menu.addEventListener("click",(e) => {
                updateContent(menu.id.split("-")[1]);
            });
        }
        for(let billPlus of document.getElementsByClassName("bill-amount-plus")) {
            billPlus.addEventListener("click",(e) => {
                let billAmount = billPlus.parentNode.querySelector(".bill-amount-value");
                if(billAmount.innerHTML == billPlus.parentNode.dataset.max) {
                    billAmount.innerHTML = 0;
                } else {
                    billAmount.innerHTML = parseInt(billAmount.innerHTML) + 1;
                }
            })
        }
        for(let billMinus of document.getElementsByClassName("bill-amount-minus")) {
            billMinus.addEventListener("click",(e) => {
                let billAmount = billMinus.parentNode.querySelector(".bill-amount-value");
                if(billAmount.innerHTML == 0) {
                    billAmount.innerHTML = billMinus.parentNode.dataset.max;
                } else {
                    billAmount.innerHTML = parseInt(billAmount.innerHTML) - 1;
                }
            })
        }
        for(let billButton of document.getElementsByClassName("bill-amount-button")) {
            billButton.addEventListener("click",(e) => {
                let totalBill = 0;
                for(let bill of document.getElementsByClassName("bill-amount-value")) {
                    totalBill += parseInt(bill.id.split("-")[3]) * parseInt(bill.innerHTML);
                }
                $("#bill-amount-deposit-total").html(totalBill);
            });
        }
        $("#login-input-clear").click(() => {
            codeInput.value = "";
        });
        $("#login-submit").click(() => {
            if(codeInput.value.length == 4) {
                if(codeInput.value == param.code) {
                    $.post('https://OraBankMenu/CodeSubmit', JSON.stringify({code: true}));
                } else {
                    $.post('https://OraBankMenu/CodeSubmit', JSON.stringify({code: false}));
                    $.post('https://OraBankMenu/exit', JSON.stringify({}));
                }
                $("#code-input").val('');
            }
        });
        $("#button-link-account").click(() => {
            updateContent("account");
        });
        $("#menu-exit").click(() => {
            $.post('https://OraBankMenu/exit', JSON.stringify({}));
        });
        $("#menu-deposit").click(() => {
            $.post('https://OraBankMenu/Refresh', JSON.stringify({}));
        });
        $("#button-submit-deposit").click(() => {
            let amount = 0;
            let billList = {};
            for(let bill of am) {
                billList[bill] = parseInt(document.getElementById("bill-amount-value-" + bill).innerHTML)
                amount += billList[bill] * bill;
                document.getElementById("bill-amount-value-" + bill).innerHTML = "0";
            }
            if(amount > 0) {
                $.post('https://OraBankMenu/Deposit', JSON.stringify({amount: amount, billList: billList}));
                $("#bill-amount-deposit-total").html("0");
            }
        });
        $("#button-submit-withdraw").click(() => {
            let amount = 0;
            amount = parseInt(document.getElementById("input-withdraw-amount").value);
            if(amount > 0 && amount != "" && amount != null && amount != 0 && amount != NaN) { 
                $.post('https://OraBankMenu/Withdraw', JSON.stringify({amount: amount}));
                document.getElementById("input-withdraw-amount").value = "";
            }
        });
        $("#button-submit-send").click(() => {
            let amount = 0;
            let rib1 = "";
            let rib2 = "";
            amount = parseInt(document.getElementById("input-send-amount").value);
            rib1 = document.getElementById("input-send-rib1").value;
            rib2 = document.getElementById("input-send-rib2").value;
            if(amount > 0 && amount != "" && amount != null && amount != 0 && amount != NaN && rib1 != "" && rib1 != null && rib1 != 0 && rib1 != NaN && rib2 != "" && rib2 != null && rib2 != 0 && rib2 != NaN) { 
                $.post('https://OraBankMenu/Send', JSON.stringify({amount: amount, rib1: rib1, rib2: rib2}));
                document.getElementById("input-send-amount").value = "";
                document.getElementById("input-send-rib1").value = "";
                document.getElementById("input-send-rib2").value = "";
            }
        });
        $("#button-submit-newcode").click(() => {
            $.post('https://OraBankMenu/NewCode', JSON.stringify({}));
        });
	};
});

function updateMenu() {
    if(isLogin) {
        $("#menu-login").hide();
        $("#menu-bank").show();
        $("#page").css("width", "1520px");
        setTimeout(function() {
            $("#menu-bank").css("opacity", "1");
        }, 300);
    } else {
        $("#menu-bank").hide();
        $("#menu-login").show();
        $("#page").css("width", "600px");
        $("#menu-bank").css("opacity", "0");
    }
}

function updateContent(menu) {
    for(let container of document.getElementsByClassName("container")) {
        container.style.display = "none";
    }
    document.getElementById(menu).style.display = "flex";
    for(let menuInactive of document.getElementById("navbar-menu").children) {
        if(menuInactive.classList.contains("active")) {
            menuInactive.classList.remove("active");  
        } 
        if (menuInactive.id == "menu-" + menu) {
            menuInactive.classList.add("active");
        }
    }
}

function updateAmountSelector(m) {
    for(let bill of filter) {
        let divBillAmount = document.getElementById("bill-amount-" + bill);
        divBillAmount.dataset.max = m[bill].total;
        divBillAmount.querySelector(".bill-amount-total").innerHTML = " (" + m[bill].total + ")";
    }
}

function setData() {
    $("#player-name").html(param.Cards.name);
    let number = param.Cards.number.toString().match(/.{1,4}/g);
    $("#player-card-number").html(number.join(" "));
    $("#player-card-name").html(param.Cards.name);
    $("#player-card-image").attr('src', './assets/' + param.Cards.type + '.png');
    let balance = (param.Accounts.amount).toLocaleString(undefined, 'en-US');
    balance = balance.replace(/,/g, " ");
    $("#player-account-balance").html(balance);
    $("#player-account-label").html(param.Accounts.label);
    $("#player-account-iban").html(param.Accounts.iban);
    $("#player-account-phone-number").html(param.Accounts.phone_number);
    $('#history-container').empty();
    for(let item of param.History) {
        let newItem = `<div class="history-item">
                            <div>
                                <p>` + item.src + ` (<span class="remove">-` + item.montant + `$</span>)</p>
                                <p>` + item.dest + ` (<span class="add">+` + item.montant + `$</span>)</p>
                            </div>
                            <div class="history-item-titre">
                                <p>Titre : <span>` + item.title + `</span></p>
                            </div>
                            <div class="history-item-detail">
                                <p>Détails : <span>` + item.details + `</span></p>
                            </div>
                        </div>`;
        $("#history-container").append(newItem);
    }
}