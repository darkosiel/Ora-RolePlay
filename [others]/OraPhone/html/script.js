var menuSelected = "contacts";
var menuSelectedLast = "home";
var menuAppSelected = "first";
var menuAppSelectedLast = "first";
var displayToggle = false;
var displayTopbarToggle = false;
var phoneBottomShow = "30px";
var phoneBottomShowNot = "-900px";
var phoneLockToggle = false;
var activeUpdateHomeToggle = false;
var items;
var dragSrcEl = null;
var dragToggle = false;
var pageSelectedStart = 1;  
var hasChangePageOnDrag = false;
var mousePosition;
var mousePosition = {
    x: null,
    y: null
};
var offset = [0,0];
var pageSelected;
var isDown = false;
var activateAppClockToggle = false;
var activateAppSettingsToggle = false;
var alarmList = [];
var stopWatch = {
    stopStart: false,
    loopShow: false,
    loopNumber: 0,
    timer: "",
    hh: 0,
    mm: 0,
    ss: 0
};
var timer = {
    stopStart: false,
    loopShow: false,
    isFinish: false,
    timer: "",
    hh: 0,
    mm: 0,
    ss: 0
};
var FooterColor = "#ffffff";
var FooterColorBackground = "transparent";
var Bodycolor = "#ffffff";
var BodyColorBackground = "transparent";
var isDownloadApp = false;
var darkMode = false;
var lockIconSnoozeEffect = false;
var wallpaperActive = "wallpaper-midnight";
var wallpaperLockActive = "wallpaper-midnight";
var soundNotificationActive = "notification-magic";
var soundNotification = "";
var soundNotificationVolume = 1;
var soundRingingActive = "ringing-iosoriginal";
var soundRinging = "";
var soundRingingVolume = 0.1;
var soundAlarmActive = "alarm-iosradaroriginal";
var soundAlarm = "";
var soundAlarmVolume = 1;
var generalZoomActive = "zoom100%";
var generalZoom = "75%";
var serialNumber = "";
var firstName = "";
var lastName = "";
var phoneNumber = "";
const folderAssets = "./assets/";
const folderImages = folderAssets + "images/";
const folderWallpaper = folderImages + "wallpaper/";
const folderAppIcon = folderImages + "app-icon/";
const folderSounds = folderAssets + "sounds/";
const folderAlarms = folderSounds + "alarms/";
const folderNotifications = folderSounds + "notifications/";
const folderRingings = folderSounds + "ringings/";
var luminosityActive = 10;
var userData;

$(function(){
    window.onload = (e) => {

        // --- Inisialisation du téléphone --- //

            // Request user data
            $.post('https://OraPhone/request_user_data', JSON.stringify({}));

            // Intérception fonction Lua
            window.addEventListener('message', (event) => {
                var item = event.data;
                if (item !== undefined && item.type === "ui") {
                    displayPhone();
                }
                if (item !== undefined && item.type === "updateUserData") {
                    updateUserData(item.data);
                }
            });

            // Ajout des touches
            document.onkeydown = function (data) {
                // if (data.which == 80) {
                //     displayPhone();
                // }
                // if (data.which == 112) {
                //     if(displayToggle) {
                //         displayPhone();
                //         $.post('https://OraPhone/exit', JSON.stringify({}));
                //         return;
                //     }
                // }
                if (data.which == 13) {
                    unlockPhone();
                }
            }
            


            // Clique droit
            $(document).bind("contextmenu",function() {
                // updateContent(menuSelectedLast);
                // displayPhone();
                // return false;
            });
            // Gestion entrer sortie des inputs
            $(':input').on('focus', function() {
                $.post('https://OraPhone/DisableInput', JSON.stringify({}));
            });
            $(':input').on('blur', function() {
                $.post('https://OraPhone/EnableInput', JSON.stringify({}));
            });

            
            // Création de la liste des applications
            for(let app of config.apps) {
                if(!app.isPrimary) {
                    if(app.name == "clock") {
                        let divAppElement = "<div draggable='true' id='app-home-list-item-" + app.name + "' class='app-home-list-item'><div id='centered'><div id='app'><div id='circle'><ul><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li><li>11</li><li>12</li></ul><div class='hand' id='hours'></div><div class='hand' id='minutes'></div><div class='hand' id='seconds'></div><div id='black-circle'></div><div id='red-circle'></div></div></div></div><span>" + app.label + "</span></div>";
                        $("#app-home-page-1 .app-home-list").append(divAppElement);
                    } else {
                        let divAppElement = "<div draggable='true' id='app-home-list-item-" + app.name + "' class='app-home-list-item'><img src='" + folderAppIcon + "app-" + app.name + "-icon.png'/><span>" + app.label + "</span></div>";
                        $("#app-home-page-1 .app-home-list").append(divAppElement);
                    }
                } else {
                    let divAppElement = "<div draggable='false' id='app-home-list-item-" + app.name + "' class='app-home-list-item app-home-list-item-primary'><img src='" + folderAppIcon + "app-" + app.name + "-icon.png'/></div>";
                    $("#app-home-list-primary").append(divAppElement);
                }
            }
            let page1AppEmptyPlaceTotal = 20 - document.getElementById("app-home-page-1").firstElementChild.children.length;
            for(let i = 1; i <= page1AppEmptyPlaceTotal; i++) {
                let divAppElement = "<div draggable='false' class='app-home-list-item empty-place'><div></div></div>";
                $("#app-home-page-1 .app-home-list").append(divAppElement);
            }
            let page2AppEmptyPlaceTotal = 20 - document.getElementById("app-home-page-2").firstElementChild.children.length;
            for(let i = 1; i <= page2AppEmptyPlaceTotal; i++) {
                let divAppElement = "<div draggable='false' class='app-home-list-item empty-place'><div></div></div>";
                $("#app-home-page-2 .app-home-list").append(divAppElement);
            }
            // Drag and drop des apps
            items = document.querySelectorAll('.app-home-list-item:not(.app-home-list-item-primary)');
            items.forEach(function(item) {
                item.addEventListener('dragstart', handleDragStart, false);
                item.addEventListener('dragenter', handleDragEnter, false);
                item.addEventListener('dragover', handleDragOver, false);
                item.addEventListener('dragleave', handleDragLeave, false);
                item.addEventListener('drop', handleDrop, false);
                item.addEventListener('dragend', handleDragEnd, false);
            });
            // Bouton changement de page
            document.getElementById("update-home-change-page").addEventListener('dragenter', function() {
                if(!hasChangePageOnDrag) {
                    updatePageSelected();
                }
                hasChangePageOnDrag = true;
            }, false);
            // Souris changement de page
            pageSelected = document.getElementById("app-home-page-container");
            pageSelected.addEventListener('mousedown', function(e) {
                isDown = true;
                if(!activeUpdateHomeToggle) {
                    offset = [
                        pageSelected.offsetLeft - e.clientX,
                        pageSelected.offsetTop - e.clientY
                    ];
                }
            }, true);
            pageSelected.addEventListener('mouseup', function() {
                isDown = false;
                if(!activeUpdateHomeToggle) {
                    let left = $("#app-home-page-container").css("left");
                    left = parseInt(left.slice(0, -2));
                    if(mousePosition.x != null || mousePosition.y != null) {
                        if(pageSelectedStart == 1) {
                            if(mousePosition.x + offset[0] <= -75) {
                                pageSelected.style.transition = "all 0.3s ease-in-out, left 0.5s ease-in-out";
                                updatePageSelected();
                                setTimeout(function() {
                                    pageSelected.style.transition = "all 0.3s ease-in-out, left 0s ease-in-out";
                                });
                            } else {
                                pageSelected.style.transition = "all 0.3s ease-in-out, left 0.5s ease-in-out";
                                pageSelected.style.left = '0%';
                                setTimeout(function() {
                                    pageSelected.style.transition = "all 0.3s ease-in-out, left 0s ease-in-out";
                                });
                            }
                        } else {
                            if(mousePosition.x + offset[0] >= -260) {
                                pageSelected.style.transition = "all 0.3s ease-in-out, left 0.5s ease-in-out";
                                updatePageSelected();
                                setTimeout(function() {
                                    pageSelected.style.transition = "all 0.3s ease-in-out, left 0s ease-in-out";
                                });
                            } else {
                                pageSelected.style.transition = "all 0.3s ease-in-out, left 0.5s ease-in-out";
                                pageSelected.style.left = '-100%';
                                setTimeout(function() {
                                    pageSelected.style.transition = "all 0.3s ease-in-out, left 0s ease-in-out";
                                });
                            }
                        }
                    }
                }
            }, true);
            pageSelected.addEventListener('mousemove', function(event) {
                if (isDown && !activeUpdateHomeToggle) {
                    event.preventDefault();
                    mousePosition = {
                        x : event.clientX,
                        y : event.clientY
                    };
                    pageSelected.style.left = (mousePosition.x + offset[0]) + 'px';
                }
            }, true);
            // Heure Téléphone
            setInterval(function () {
                let now = new Date();
                let timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
                let time = now.toLocaleString("fr-FR", {
                    timeStyle: "short",
                    timeZone: timezone
                });
                let date = now.toLocaleString("fr-FR", {
                    dateStyle: "full",
                    timeZone: timezone
                });
                $("#phone-time").html(time);
                $("#app-lock-time-text").html(time);
                $("#app-lock-day-text").html(date);
            }, 1000);
            // Icon Horloge
            window.requestAnimFrame = (function() {
                return  window.requestAnimationFrame       ||
                        window.webkitRequestAnimationFrame ||
                        window.mozRequestAnimationFrame    ||
                        function( callback ){
                            window.setTimeout(callback, 1000 / 60);
                        };
            })();
            (function clock(){ 
                var hour = document.getElementById("hours"),
                    min = document.getElementById("minutes"),
                    sec = document.getElementById("seconds");
                    (function loop(){
                        requestAnimFrame(loop);
                        draw();
                    })();
                    function draw(){
                        var now = new Date(),
                            then = new Date(now.getFullYear(),now.getMonth(),now.getDate(),0,0,0),
                            diffInMil = (now.getTime() - then.getTime()),
                            h = (diffInMil/(1000*60*60)),
                            m = (h*60),
                            s = (m*60);
                            sec.style.transform = "rotate(" + (s * 6) + "deg)";
                            hour.style.transform = "rotate(" + (h * 30 + (h / 2)) + "deg)";
                            min.style.transform = "rotate(" + (m * 6) + "deg)";
                    } 
            })();

        // --- --- //

        // --- Inisialisation de test --- //

            // Affichage de l'écran de test
            // displayPhone();
            updateContent(menuSelected);
            updateAppContent(menuAppSelected);
            // lockPhone();
            // Création de contacts pour app message
            for (var i = 65; i <= 90; i++) {
                let div = "<div class='newmessage-list-item'><div class='newmessage-list-item-left'><div class='newmessage-list-item-left-avatar'><i class='fa-solid fa-user-astronaut'></i><i class='fa-solid fa-check'></i></div></div><div class='newmessage-list-item-right'><div class='newmessage-list-item-right-header'><span class='newmessage-list-item-right-header-name'>" + String.fromCharCode(i) + "tephen Yustiono</span></div><div class='newmessage-list-item-right-body'><span class='newmessage-list-item-right-body-number'>555-3460</span></div></div></div>";
                $('#newmessage-list').append(div);
            }
            // Ajout notification
            $("#add-notification").click(function() {
                // addNotification("call", "message", "Sam 18:50", "Nathan D", "Yeah, that's sound with me. I'll see you in 10");
                $.post('https://OraPhone/call_number', JSON.stringify({ targetNumber: "5554444", fromNumber: phoneNumber }));
            });

        // --- --- //

        
        
        

        
        
        

        for (let e of document.querySelectorAll('input[type="range"].topbar-box-button-slider')) {
            e.style.setProperty('--value', e.value);
            e.style.setProperty('--min', e.min == '' ? '0' : e.min);
            e.style.setProperty('--max', e.max == '' ? '100' : e.max);
            e.addEventListener('input', () => {
                e.style.setProperty('--value', e.value);
                if(e.id == "topbar-box-button-slider-luminosity") {
                    $("#phone-screen").css("filter", "brightness(" + (e.value * 10) + "%)");
                    luminosityActive = e.value;
                    console.log(luminosityActive);
                }
            });
        }
        for(let element of $(".app-footer-element")) {
            element.addEventListener("click", function() {
                updateAppContent(element.id.split("-")[3]);
            });
        }
        for(let element of $(".app-tab-button")) {
            element.addEventListener("click", function() {
                updateAppContent(element.id.split("-")[3]);
            });
        }
        for(let item of $("#app-store .app-body-content-body-list-item")) {
            item.addEventListener("click", function() {
                updateAppContent("app");
            });
        }

        

        for(let elt of document.getElementsByClassName("app-clock-list-item-switch")) {
            elt.firstElementChild.addEventListener("change", function() {
                if(elt.firstElementChild.checked) {
                    alarmList.push( {
                        "id": elt.dataset.id,
                        "timer": setInterval(function() {
                            let dateNow = new Date();
                            if(elt.dataset.hour == dateNow.getHours() && elt.dataset.minute == dateNow.getMinutes()) {
                                elt.firstElementChild.checked = false;
                                if(menuSelected != "clock" || menuAppSelected != "alarm") {
                                    addNotification("clock", "alarm", "Maintenant", "Alarme", elt.parentNode.previousElementSibling.querySelector(".app-clock-list-item-alarm-name").innerHTML);
                                }
                                for(let eltm of alarmList) {
                                    if(eltm.id == elt.dataset.id) {
                                        clearInterval(eltm.timer);
                                    }
                                }
                            }
                        }, 1000)
                    });
                } else {
                    for(let eltm of alarmList) {
                        if(eltm.id == elt.dataset.id) {
                            clearInterval(eltm.timer);
                        }
                    }
                }
            });
        }
        $("#app-message .app-body-content-body-list-item").click(function() {
            updateAppContent("message");
        });
        $("#app-unlock").click(function () {
            unlockPhone();
        });
        $("#phone-screen-content-header").click(function () {
            displayTopbar();
        });
        $("#phone-screen-content-footer").click(function () {
            updateContent("home");
            if(displayTopbarToggle) {
                displayTopbar();
            }
        });
        $("#update-home-change-page").click(function() {
            updatePageSelected();
        });
        $("#topbar-box-button-update-home").click(function () {
            if(menuSelected == "home") {
                if(activeUpdateHomeToggle) {
                    desactiveUpdateHome();
                } else {
                    activeUpdateHome();
                }
                if(displayTopbarToggle) {
                    displayTopbar();
                }
            }
        });
        $("#topbar-box-music-button-play").click(function () {
            $("#topbar-box-music-button-play").hide();
            $("#topbar-box-music-button-pause").show(); 
        });
        $("#topbar-box-music-button-pause").click(function () {
            $("#topbar-box-music-button-pause").hide();
            $("#topbar-box-music-button-play").show();
        });
        $("#topbar-box-button-bluetooth").click(function () {
            $("#topbar-box-button-bluetooth").toggleClass("active")
        });
        $("#topbar-box-button-torch").click(function () {
            $("#topbar-box-button-torch").toggleClass("active")
        });
        $(".app-header-first").click(function () {
            updateAppContent("first");
        });
        $(".app-header-back").click(function () {
            if(menuAppSelected == menuAppSelectedLast) {
                updateAppContent("first");
            } else {
                updateAppContent(menuAppSelectedLast);
            }
        });
        $(".app-header-sound").click(function () {
            stopSounds();
        });
        $(".time-select-number-button").click(function () {
            let numberType = $(this).attr("id").split("-")[2];
            let operationType = $(this).attr("id").split("-")[4];
            let spanAmount = $("#time-select-" + numberType + "-number-amount");
            if(operationType == "up") {
                if(spanAmount.html() == "59") {
                    spanAmount.html("00");
                } else {
                    let amount = parseInt(spanAmount.html()) + 1;
                    spanAmount.html(amount < 10 ? "0" + amount : amount);
                }
            } else {
                if(spanAmount.html() == "00") {
                    spanAmount.html("59");
                } else {
                    let amount = parseInt(spanAmount.html()) - 1;
                    spanAmount.html(amount < 10 ? "0" + amount : amount);
                }
            }
        });
        $(".alarm-time-select-number-button").click(function () {
            let numberType = $(this).attr("id").split("-")[3];
            let operationType = $(this).attr("id").split("-")[5];
            let spanAmount = $("#alarm-time-select-" + numberType + "-number-amount");
            if(operationType == "up") {
                if(numberType == "hour") {
                    if(spanAmount.html() == "23") {
                        spanAmount.html("00");
                    } else {
                        let amount = parseInt(spanAmount.html()) + 1;
                        spanAmount.html(amount < 10 ? "0" + amount : amount);
                    }
                } else {
                    if(spanAmount.html() == "59") {
                        spanAmount.html("00");
                    } else {
                        let amount = parseInt(spanAmount.html()) + 1;
                        spanAmount.html(amount < 10 ? "0" + amount : amount);
                    }
                }
            } else {
                if(numberType == "hour") {
                    if(spanAmount.html() == "00") {
                        spanAmount.html("23");
                    } else {
                        let amount = parseInt(spanAmount.html()) - 1;
                        spanAmount.html(amount < 10 ? "0" + amount : amount);
                    }
                } else {
                    if(spanAmount.html() == "00") {
                        spanAmount.html("59");
                    } else {
                        let amount = parseInt(spanAmount.html()) - 1;
                        spanAmount.html(amount < 10 ? "0" + amount : amount);
                    }
                }
            }
        });
        $("#timer-button-start").click(function () {
            if(timer.isFinish) {
                return;
            }
            if(timer.stopStart) {
                clearInterval(timer.timer);
                $("#timer-button-start").removeClass("pause");
                $("#timer-button-start").html("Reprendre");
                timer.stopStart = false;
            } else {
                timer.timer = setInterval(timerStart, 1000);
                $("#timer-button-start").addClass("pause");
                $("#timer-button-start").html("Pause");
                timer.stopStart = true;
            }
            if(!timer.loopShow) {
                timer.hh = parseInt($("#time-select-hour-number-amount").html());
                timer.mm = parseInt($("#time-select-minute-number-amount").html());
                timer.ss = parseInt($("#time-select-second-number-amount").html());
                $("#app-clock-timer-time").html(
                    (timer.hh < 10 ? "0" + timer.hh : timer.hh) +
                    ":" +
                    (timer.mm < 10 ? "0" + timer.mm : timer.mm) +
                    ":" +
                    (timer.ss < 10 ? "0" + timer.ss : timer.ss));
                $("#timer-app-clock-time-select").hide();
                $("#app-clock-timer-time").css("display", "flex");
                $("#timer-button-reset").addClass("reset");
                timer.loopShow = true;
            }
        });
        $("#timer-button-reset").click(function () {
                clearInterval(timer.timer);
                $("#timer-app-clock-time-select").show();
                $("#app-clock-timer-time").hide();
                $("#timer-button-reset").removeClass("reset");
                $("#timer-button-start").removeClass("pause");
                $("#timer-button-start").html("Démarrer");
                $("#app-clock-timer-time").html("00:00:00");
                timer.hh = timer.mm = timer.ss = timer.loopNumber = 0;
                $("#app-clock-timer-time").removeClass("finish");
                timer.isFinish = false;
                timer.stopStart = false;
                timer.loopShow = false;
        });
        $("#stopwatch-button-start").click(function () {
            if(stopWatch.stopStart) {
                clearInterval(stopWatch.timer);
                $("#stopwatch-button-start").removeClass("stop");
                $("#stopwatch-button-start").html("Démarrer");
                $("#stopwatch-button-reset").html("Effacer");
                stopWatch.stopStart = false;
            } else {
                stopWatch.timer = setInterval(stopWatchStart, 10);
                $("#stopwatch-button-start").addClass("stop");
                $("#stopwatch-button-start").html("Arrêter");
                $("#stopwatch-button-reset").html("Tour");
                stopWatch.stopStart = true;
            }
            if(!stopWatch.loopShow) {
                $("#stopwatch-button-reset").addClass("reset");
                stopWatch.loopShow = true;
            }
        });
        $("#stopwatch-button-reset").click(function () {
            if(stopWatch.stopStart) {
                stopWatch.loopNumber++;
                let loopTimer = (stopWatch.hh < 10 ? "0" + stopWatch.hh : stopWatch.hh) +
                                ":" +
                                (stopWatch.mm < 10 ? "0" + stopWatch.mm : stopWatch.mm) +
                                "." +
                                (stopWatch.ss < 10 ? "0" + stopWatch.ss : stopWatch.ss);
                let divLoop = "<div class='loop'><div class='name'>Tour " + stopWatch.loopNumber + "</div><div class='time' ref='looptime'>" + loopTimer + "</div></div>";
                $("#stopwatch-list-loop").append(divLoop);
            } else {
                clearInterval(stopWatch.timer);
                $("#stopwatch-button-reset").removeClass("reset");
                $("#app-clock-list-item-stopwatch").html("00:00.00");
                stopWatch.hh = stopWatch.mm = stopWatch.ss = stopWatch.loopNumber = 0;
                $("#stopwatch-list-loop").empty();
                stopWatch.loopShow = false;
            }
        });
        $("#alarm-add-button").click(function () {
            updateAppContent("addalarm");
        });
        $("#addalarm-cancel-button").click(function () {
            updateAppContent("alarm");
        });
        $("#addalarm-save-button").click(function () {
            let alarmId = Math.floor(Math.random() * (999999 - 111111) + 111111);
            let alarmDescription = ($("#addalarm-input-description").val() == "") ? "Alarme" : $("#addalarm-input-description").val();
            let alarmHour = parseInt($("#alarm-time-select-hour-number-amount").html());
            let alarmMinute = parseInt($("#alarm-time-select-minute-number-amount").html());
            let alarm = "<div class='app-body-content-body-list-item item-alarm'><div class='app-body-content-body-list-item-alarm'><div class='app-body-content-body-list-item-time'>" + (alarmHour < 10 ? "0" + alarmHour : alarmHour) +":" +(alarmMinute < 10 ? "0" + alarmMinute : alarmMinute) + "</div><div class='app-body-content-body-list-item-alarm-name'>" + alarmDescription + "</div><div class='app-body-content-body-list-item-alarm-day'></div></div><label data-id='" + alarmId + "' data-hour='" + alarmHour + "' data-minute='" + alarmMinute + "' class='app-body-content-body-list-item-switch'><input type='checkbox'/><span></span></label></div>";
            $("#app-clock-body-content-alarm .app-body-content-body-list").append(alarm);
            let alarmElement = document.querySelector("#app-clock-body-content-alarm .app-body-content-body-list").lastElementChild.querySelector(".app-body-content-body-list-item-switch");
            alarmElement.addEventListener("change", function() {
                if(alarmElement.firstElementChild.checked) {
                    alarmList.push( {
                        "id": alarmElement.dataset.id,
                        "timer": setInterval(function() {
                            let dateNow = new Date();
                            if(alarmElement.dataset.hour == dateNow.getHours() && alarmElement.dataset.minute == dateNow.getMinutes()) {
                                alarmElement.firstElementChild.checked = false;
                                if(menuSelected != "clock" || menuAppSelected != "alarm") {
                                    addNotification("clock", "alarm", "Maintenant", "Alarme", alarmElement.previousElementSibling.querySelector(".app-body-content-body-list-item-alarm-name").innerHTML);
                                }
                                for(let eltm of alarmList) {
                                    if(eltm.id == alarmElement.dataset.id) {
                                        clearInterval(eltm.timer);
                                    }
                                }
                            }
                        }, 1000)
                    });
                } else {
                    for(let eltm of alarmList) {
                        if(eltm.id == alarmElement.dataset.id) {
                            clearInterval(eltm.timer);
                        }
                    }
                }
            });;
            updateAppContent("alarm");
        });
        $(".app-home-list-item").click(function() {
            if(!activeUpdateHomeToggle) {
                if(this.id) {
                    updateContent(this.id.split("-")[4]);
                }
            }
        });
        $("#app-body-content-body-app-header-detail-button-download").click(function () {
            if(isDownloadApp) {
                return;
            }
            isDownloadApp = true;
            let button = $("#app-body-content-body-app-header-detail-button-download");
            let color = button.css("background-color");
            button.css("background", "linear-gradient(110deg, " + color + " 0%, white 0%)")
            for(let i = 0; i <= 100; ++i) {
                setTimeout(function() {
                    button.css("background", "linear-gradient(110deg, " + color + " " + i + "%, white " + i + "%)");
                    button.first().html(i + "% Téléchargement...");
                }, i * 50);
            }
            setTimeout(function() {
                button.css("background", "");
                button.first().html("Lancer");
                isDownloadApp = false;
            }, 100 * 50);
        });
        $("#phone-lock-button i").mouseover(function() {
            if(phoneLockToggle) {
                $("#phone-lock-button i").removeClass("fa-lock");
                $("#phone-lock-button i").addClass("fa-lock-open");
            } else {
                $("#phone-lock-button i").removeClass("fa-lock-open");
                $("#phone-lock-button i").addClass("fa-lock");
            }
        });
        $("#phone-lock-button i").mouseout(function() {
            if(phoneLockToggle) {
                $("#phone-lock-button i").removeClass("fa-lock-open");
                $("#phone-lock-button i").addClass("fa-lock");
            } else {
                $("#phone-lock-button i").removeClass("fa-lock");
                $("#phone-lock-button i").addClass("fa-lock-open");
            }
        });
        $("#phone-lock-button i").click(function() {
            if(phoneLockToggle) {
                unlockPhone();
            } else {
                lockPhone();
            }
        });
        $("#message-list-new-message").click(function() {
            updateAppContent("newmessage");
        });
        $("#calculator-result").on('DOMSubtreeModified', function(){
            $("#calculator-result").textfill({
                minFontPixels: 10,
                maxFontPixels: 80,
                innerTag: "span",
                widthOnly: true,
                allowOverflow: true
            });
        });
        $(function(){
            var OperatorStatus = false;
            var OperatorEqualStage = false;
            var historyReset = false;
            var NumberValue_first = 0;
            var NumberValue_secend = 0;
            var ScreenTotal = 0;
            var Operators = "";
            var PointLength_first = 0;
            var PointLength_secend = 0;
            var PointLengthMax = Math.max(PointLength_first, PointLength_secend);
            $("#calculator-result span").text("0");

            $(".Number-btn").click(function() {
                if(historyReset) {
                    $("#calculator-history span").text("");
                    historyReset = false;
                }
                if(OperatorEqualStage) {
                    OperatorEqualStage = false;
                    $("#calculator-result span").text("");
                }
                if($(this).text() !== "0") {
                    $(".AC").text("C");
                }
                if($(this).text() === ".") {
                    if($("#calculator-result span").text() === "0") {
                        $("#calculator-result span").html( 0 + ".");
                    } else if(ScreenTotal.indexOf(".") != -1) {
                        console.log($("#calculator-result span").text().indexOf("."));
                        return;
                    }
                }
                if(OperatorStatus) {
                    NumberValue_secend = $(this).text();
                    if($("#calculator-result span").text().length === 0 || $("#calculator-result span").text() === "0") {
                        ScreenTotal = NumberValue_secend;
                        $("#calculator-result span").text(ScreenTotal);
                    } else {
                        ScreenTotal = ScreenTotal + NumberValue_secend;
                        $("#calculator-result span").text(ScreenTotal);
                        NumberValue_secend = ScreenTotal;
                    }
                    $(".Operator-btn").removeClass("click");
                } else {
                    NumberValue_first = $(this).text();
                    if($("#calculator-result span").text().length === 0 || $("#calculator-result span").text() === "0") {
                        ScreenTotal = NumberValue_first;
                        $("#calculator-result span").text(ScreenTotal);
                    } else{
                        ScreenTotal = ScreenTotal + NumberValue_first;
                        $("#calculator-result span").text(ScreenTotal);
                        NumberValue_first = ScreenTotal;
                    }
                }
            });

            $(".Percentage").click(function() {
                $(".Operator-btn").removeClass("click");
                if(Math.round(ScreenTotal) === Number(ScreenTotal)) {
                    ScreenTotal *= 0.01;
                } else {
                    PointLength_first = ScreenTotal.toString().split(".")[1].length;
                    ScreenTotal = (Number(ScreenTotal).toString().replace(".","") * 1) / Math.pow(10,(PointLength_first + 2));
                }
                NumberValue_first = ScreenTotal;
                $("#calculator-result span").text(ScreenTotal);
            });
            
            // AC
            $(".AC").click(function() {
                $("#calculator-result span").css("font-size",  "3.15rem");
                $(".Operator-btn").removeClass("click");
                $(this).text("AC");
                OperatorStatus = false;
                NumberValue_first = 0;
                NumberValue_secend = 0;
                ScreenTotal = 0;
                Operators = "";
                PointLength_first = 0;
                PointLength_secend = 0;
                PointLength = Math.max(PointLength_first, PointLength_secend);
                $("#calculator-history span").text("");
                $("#calculator-result span").text(ScreenTotal);
            });
            
            //+-
            $(".PlusMinus").click(function() {
                $(".Operator-btn").removeClass("click");
                ScreenTotal *= -1;
                NumberValue_first = ScreenTotal;
                $("#calculator-result span").text(ScreenTotal);
            })
            
            $(".Operator-btn").click(function() {
                Operators = $(this).text();
                $(".Operator-btn").removeClass("click");
                $(this).addClass("click");
                NumberValue_first = parseFloat(ScreenTotal);
                if(!historyReset && !isNaN(NumberValue_first)) {
                    $("#calculator-history span").text($("#calculator-history span").text() + " " + NumberValue_first + " " + Operators);
                }
                OperatorEqualStage = true;
                OperatorStatus = true;
                ScreenTotal = "";
            });
            
            $(".equal").click(function() {
                NumberValue_secend = parseFloat(NumberValue_secend);
                OperatorEqualStage = true;
                switch(Operators) {
                    case "+" :
                        PointLength_first = NumberValue_first.toFixed(10).toString().split(".")[1].length;
                        PointLength_secend = NumberValue_secend.toFixed(10).toString().split(".")[1].length;
                        PointLengthMax = Math.max(PointLength_first, PointLength_secend);
                        ScreenTotal = Math.round((NumberValue_first*Math.pow(10,PointLengthMax) + NumberValue_secend*Math.pow(10,PointLengthMax)))/Math.pow(10,PointLengthMax);
                        if(!historyReset) {
                            $("#calculator-history span").text($("#calculator-history span").text() + " " + NumberValue_secend + " = " + ScreenTotal);
                        }
                        $("#calculator-result span").text(ScreenTotal);
                        historyReset = true;
                        OperatorStatus = false;
                        NumberValue_first = ScreenTotal;
                        break;
                    case "-" :
                        PointLength_first = NumberValue_first.toFixed(10).toString().split(".")[1].length;
                        PointLength_secend = NumberValue_secend.toFixed(10).toString().split(".")[1].length;
                        PointLengthMax = Math.max(PointLength_first, PointLength_secend);
                        ScreenTotal = Math.round((NumberValue_first*Math.pow(10,PointLengthMax) - NumberValue_secend*Math.pow(10,PointLengthMax)))/Math.pow(10,PointLengthMax);
                        if(!historyReset) {
                            $("#calculator-history span").text($("#calculator-history span").text() + " " + NumberValue_secend + " = " + ScreenTotal);
                        }
                        $("#calculator-result span").text(ScreenTotal);
                        historyReset = true;
                        OperatorStatus = false;
                        NumberValue_first = ScreenTotal;
                    break;
                    case "×" :
                        if(Math.round(NumberValue_first) !== NumberValue_first &&  Math.round(NumberValue_secend) !== NumberValue_secend) {
                            PointLength_first = NumberValue_first.toString().split(".")[1].length;
                            PointLength_secend = NumberValue_secend.toString().split(".")[1].length;
                            ScreenTotal = (Number(NumberValue_first).toString().replace(".","")* Number(NumberValue_secend).toString().replace(".","")) / Math.pow(10,(PointLength_first + PointLength_secend));
                        } else if(Math.round(NumberValue_first) === NumberValue_first &&  Math.round(NumberValue_secend) !== NumberValue_secend) { // NumberValue_first 為整數
                            PointLength_secend = NumberValue_secend.toString().split(".")[1].length;
                            ScreenTotal = (NumberValue_first * Number(NumberValue_secend).toString().replace(".","")) / Math.pow(10,(PointLength_secend));
                        } else if(Math.round(NumberValue_first) !== NumberValue_first &&  Math.round(NumberValue_secend) === NumberValue_secend) { // NumberValue_secend 為整數
                            PointLength_first = NumberValue_first.toString().split(".")[1].length;
                            ScreenTotal = (Number(NumberValue_first).toString().replace(".","") * NumberValue_secend) / Math.pow(10,(PointLength_first));
                        } else {
                            ScreenTotal = Number(NumberValue_first * NumberValue_secend);
                        }
                        if(!historyReset) {
                            $("#calculator-history span").text($("#calculator-history span").text() + " " + NumberValue_secend + " = " + ScreenTotal);
                        }
                        $("#calculator-result span").text(ScreenTotal);
                        historyReset = true;
                        OperatorStatus = false;
                        NumberValue_first = ScreenTotal;
                        break;
                    case "÷" :
                        PointLength_first = (Math.round(Number(NumberValue_first).toString().replace(".","")/NumberValue_first) +"").length;
                        PointLength_secend = (Math.round(Number(NumberValue_secend).toString().replace(".","")/NumberValue_secend) +"").length;
                        ScreenTotal = Number((Number(NumberValue_first).toString().replace(".","")) / Number(Number(NumberValue_secend).toString().replace(".",""))) * Math.pow(10,PointLength_secend - PointLength_first);
                        if(!historyReset) {
                            $("#calculator-history span").text($("#calculator-history span").text() + " " + NumberValue_secend + " = " + ScreenTotal);
                        }
                        $("#calculator-result span").text(ScreenTotal);
                        historyReset = true;
                        OperatorStatus = false;
                        NumberValue_first = ScreenTotal;
                        break;
                }
            })
        });
        $("#newmessage-list-alphabet span").click(function() {
            for(let item of $(".newmessage-list-item")) {
                if(item.querySelector(".newmessage-list-item-right-header-name").innerText.charAt(0).toLowerCase() == this.title.toLowerCase()) {
                    document.getElementById("newmessage-list").scrollTo({top: item.offsetTop, behavior: 'smooth'});
                    return;
                }
            }
        });
        $("#newmessage-create-button").click(function () {
            updateAppContent("message")
        });
        $("#contacts-list-alphabet span").click(function() {
            for(let item of $(".contacts-list-row-letter")) {
                if(item.querySelector("span").innerText.charAt(0).toLowerCase() == this.title.toLowerCase()) {
                    document.getElementById("contacts-list").scrollTo({top: item.parentNode.offsetTop, behavior: 'smooth'});
                    return;
                }
            }
        });
        $(".settings-list-item.child").click(function () {
            updateAppContent($(this).attr("id").split("-")[3]);
        });

        function responsiveChatPush(sender, origin, date, message) {
            var originClass;
            if (origin == 'me') {
                originClass = 'myMessage';
            } else {
                originClass = 'fromThem';
            }
            $('.app-message-conversation .messages').append('<div class="' + originClass + '"><p>' + message + '</p><date><b>' + sender + '</b> ' + date + '</date></div>');
        }

        responsiveChatPush('Kate', 'me', '08.03.2017 14:30:7', 'It looks beautiful!');
        responsiveChatPush('John Doe', 'you', '08.03.2016 14:31:22', 'It looks like the iPhone message box.');
        responsiveChatPush('Kate', 'me', '08.03.2016 14:33:32', 'Yep, is this design responsive?');
        responsiveChatPush('John Doe', 'you', '08.03.2016 14:31:22', 'It looks like the iPhone message box.');
        responsiveChatPush('John Doe', 'you', '08.03.2016 14:31:22', 'It looks like the iPhone message box.');
        responsiveChatPush('Kate', 'me', '08.03.2016 14:33:32', 'Yep, is this design responsive?');
        responsiveChatPush('Kate', 'me', '08.03.2016 14:33:32', 'Yep, is this design responsive?');
        responsiveChatPush('John Doe', 'you', '08.03.2016 14:31:22', 'It looks like the iPhone message box.');
        responsiveChatPush('Kate', 'me', '08.03.2016 14:33:32', 'Yep, is this design responsive?');
        responsiveChatPush('Kate', 'me', '08.03.2016 14:36:4', 'By the way when I hover on my message it shows date.');
        responsiveChatPush('John Doe', 'you', '08.03.2016 14:37:12', 'Yes, this is completely responsive.');

        $('.app-message-conversation .messages').append('<div class="chat-bubble"><div class="loading"><div class="dot one"></div><div class="dot two"></div><div class="dot three"></div></div><div class="tail"></div></div>');

        $("#topbar-box-button-update-thememode").click(function() {
            updateDarkMode();
        });
        $("#settings-list-item-thememode label, #switch-theme-mode").change(function() {
            updateDarkMode();
        });


        $("#settings-wallpaper-list-input div").click(function() {
            let link = $("#settings-wallpaper-list-input input").val();
            if(link.length > 0) {
                $("#phone-screen").css("background-image", "url(" + link + ")");
                $("#settings-wallpaper-list .settings-wallpaper-list-item").removeClass("active");
                wallpaperActive = link;
            }
        });
        $("#settings-wallpaper-lock-list-input div").click(function() {
            let link = $("#settings-wallpaper-lock-list-input input").val();
            if(link.length > 0) {
                $("#phone-lock").css("background-image", "url(" + link + ")");
                $("#settings-wallpaper-lock-list .settings-wallpaper-list-item").removeClass("active");
                wallpaperLockActive = link;
            }
        });


        for (let e of document.querySelectorAll('input.settings-slider')) {
            e.style.setProperty('--value', e.value);
            e.style.setProperty('--min', e.min == '' ? '0' : e.min);
            e.style.setProperty('--max', e.max == '' ? '100' : e.max);
            e.parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = e.value;
            e.addEventListener('input', () => {
                e.style.setProperty('--value', e.value);
                e.parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = e.value;
                if(e.id == "settings-slider-sound-notification") {
                    soundNotificationVolume = e.value / 10;
                    soundNotification.volume = soundNotificationVolume;
                } else if(e.id == "settings-slider-sound-ringing") {
                    soundRingingVolume = e.value / 10;
                    soundRinging.volume = soundRingingVolume;
                } else if(e.id == "settings-slider-sound-alarm") {
                    soundAlarmVolume = e.value / 10;
                    soundAlarm.volume = soundAlarmVolume;
                }
            });
        }
        
        


	};
});

function updateUserData(data) {
    // Update main variables
    userData = data;
    darkMode = data.phone.darkMode;
    wallpaperActive = data.phone.wallpaper;
    wallpaperLockActive = data.phone.wallpaperLock;
    soundNotificationActive = data.phone.soundNotification;
    soundNotificationVolume = data.phone.soundNotificationVolume;
    soundRingingActive = data.phone.soundRinging;
    soundRingingVolume = data.phone.soundRingingVolume;
    soundAlarmActive = data.phone.soundAlarm;
    soundAlarmVolume = data.phone.soundAlarmVolume;
    generalZoomActive = data.phone.zoom;
    serialNumber = data.phone.serialNumber;
    firstName = data.phone.firstName;
    lastName = data.phone.lastName;
    phoneNumber = data.phone.number;
    luminosityActive = data.phone.luminosity;
    // Update sounds
    soundNotification = new Audio("assets/sounds/notifications/" + soundNotificationActive + ".mp3");
    soundNotification.volume = soundNotificationVolume;
    soundRinging = new Audio("assets/sounds/ringings/" + soundRingingActive + ".mp3");
    soundRinging.volume = soundRingingVolume;
    soundAlarm = new Audio("assets/sounds/alarms/" + soundAlarmActive + ".mp3");
    soundAlarm.volume = soundAlarmVolume;
    // Update wallpapers
    updateWallpaper();
    // Update theme mode
    updateDarkMode();
    updateZoom();
    updateProfile();
}











function updateDarkMode() {
    if(darkMode) {
        $("body").addClass("theme--default");
        $("body").removeClass("theme--dark");
        darkMode = false;
    } else {
        $("body").removeClass("theme--default");
        $("body").addClass("theme--dark");
        darkMode = true;
    }
    $("#topbar-box-button-update-thememode").toggleClass("active");
    $("#settings-list-item-thememode label input, #switch-theme-mode input").prop("checked", darkMode);
}

function addNotification(app, appSub, time, title, message) {
    let label = "Inconnu";
    let divNotification = "";
    let divNotificationLock = "";
    if(!displayToggle) {
        if(!phoneLockToggle) {
            $("#phone").css("bottom", "-670px");
        } else {
            $("#phone").css("bottom", "-480px");
        }
    }
    for(let appItem of config.apps) {
        if(appItem.name == app) {
            label = appItem.label;
        }
    }
    if(app == "call") {
        divNotification = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-main call'><div class='notification-item-main-avatar'><i class='fa-solid fa-user-astronaut'></i></div><div class='notification-item-main-info'><span class='notification-item-main-info-header'>Appel</span><span class='notification-item-main-info-message'>555-5689</span></div><div class='notification-item-main-hangup'><i class='fa-solid fa-phone-slash'></i></div><div class='notification-item-main-pickup'><i class='fa-solid fa-phone'></i></div></div></div></div>";
        divNotificationLock = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-main call'><div class='notification-item-main-avatar'><i class='fa-solid fa-user-astronaut'></i></div><div class='notification-item-main-info'><span class='notification-item-main-info-header'>Appel</span><span class='notification-item-main-info-message'>555-5689</span></div><div class='notification-item-main-hangup'><i class='fa-solid fa-phone-slash'></i></div><div class='notification-item-main-pickup'><i class='fa-solid fa-phone'></i></div></div></div></div>";
    } else {
        divNotification = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-header'><div class='notification-item-background-blur'></div><div class='notification-item-header-content'><div class='notification-item-header-content-left'><img src='./assets/app-" + app + "-icon.png'/>" + label + "</div><div class='notification-item-header-content-right'>" + time + "</div></div></div><div class='notification-item-main'><span class='notification-item-main-header'>" + title + "</span><span class='notification-item-main-message'>" + message + "</span></div></div></div>";
        divNotificationLock = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-icon'><img src='./assets/app-" + app + "-icon.png'/></div><div class='notification-item-content-body'><div class='notification-item-content-body-header'><div class='notification-item-content-body-header-left'>" + label + "</div><div class='notification-item-content-body-header-right'>" + time + "</div></div><div class='notification-item-content-body-content'><div class='notification-item-content-body-content-message'>" + message + "</div></div></div></div></div>";
    }
    $("#notification-container").prepend(divNotification);
    $("#notification-container-lock").prepend(divNotificationLock);
    let notification = document.getElementById("notification-container").firstElementChild;
    let notificationLock = document.getElementById("notification-container-lock").firstElementChild;
    notification.addEventListener("click", function() {
        if(!phoneLockToggle) {
            if(!displayToggle) {
                displayPhone();
            }
            updateContent(app);
            updateAppContent(appSub);
            notification.remove();
            stopSounds();
        }
    });
    notificationLock.addEventListener("click", function() {
        if(phoneLockToggle) {
            if(!displayToggle) {
                displayPhone();
            }
            if(!lockIconSnoozeEffect) {
                lockIconSnoozeEffect = true;
                $("#app-lock-icon-lock i").addClass("snooze");
                setTimeout(function() {
                    $("#app-lock-icon-lock i").removeClass("snooze");
                    lockIconSnoozeEffect = false;
                }, 500);
            }
        }
    });
    $(".notification-item-main-hangup").click(function() {
        stopSounds();
    });
    setTimeout(function() {
        notification.classList.remove("close");
        notificationLock.classList.remove("close");
        let notificationTime = "5000";
        if(app == "call") {
            soundRinging.currentTime = 0;
            soundRinging.play();
            notificationTime = "10000";

        } else if(app == "clock") {
            soundAlarm.currentTime = 0;
            soundAlarm.play();
            notificationTime = "30000";
        } else {
            soundNotification.currentTime = 0;
            soundNotification.play();
        }
        setTimeout(function() {
            notification.style.opacity = "0";
            notificationLock.style.opacity = "0";
            setTimeout(function() {
                notification.remove();
                notificationLock.remove();
                if(app == "clock" || app == "call") {
                    stopSounds();
                }
                if($("#notification-container").children().length == 0 && !displayToggle) {
                    $("#phone").css("bottom", phoneBottomShowNot);
                }
            }, 750);
        }, notificationTime);
    }, 25);
}

function stopWatchStart() {
    stopWatch.ss++;
    if (stopWatch.ss >= 100) {
        stopWatch.ss = 0;
        stopWatch.mm++;
    }
    if (stopWatch.mm >= 60) {
        stopWatch.mm = 0;
        stopWatch.hh++;
    }
    $("#app-clock-list-item-stopwatch").html(
        (stopWatch.hh < 10 ? "0" + stopWatch.hh : stopWatch.hh) +
        ":" +
        (stopWatch.mm < 10 ? "0" + stopWatch.mm : stopWatch.mm) +
        "." +
        (stopWatch.ss < 10 ? "0" + stopWatch.ss : stopWatch.ss));
}

function timerStart() {
    timer.ss--;
    if(timer.ss == 0 && timer.mm == 0 && timer.hh == 0) {
        clearInterval(timer.timer);
        $("#app-clock-timer-time").addClass("finish");
        timer.isFinish = true;
        if(menuSelected != "clock" || menuAppSelected != "timer") {
            addNotification("clock", "timer", "Maintenant", "Minuteur", "Minuteur terminé");
        }
    }
    if (timer.ss <= -1) {
        timer.ss = 59;
        timer.mm--;
    }
    if (timer.mm <= -1) {
        timer.mm = 59;
        timer.hh--;
    }
    $("#app-clock-timer-time").html(
        (timer.hh < 10 ? "0" + timer.hh : timer.hh) +
        ":" +
        (timer.mm < 10 ? "0" + timer.mm : timer.mm) +
        ":" +
        (timer.ss < 10 ? "0" + timer.ss : timer.ss));
}

function activeUpdateHome() {
    if(!activeUpdateHomeToggle) {
        $("#topbar-box-button-update-home").addClass("active");
        $("#update-home-change-page").show();
        activeUpdateHomeToggle = true;
        for(let app of $(".app-home-list-item:not(.app-home-list-item-primary)")) {
            app.classList.add("draggable-element");
        }
    }
}

function desactiveUpdateHome() {
    if(activeUpdateHomeToggle) {
        $("#topbar-box-button-update-home").removeClass("active");
        $("#update-home-change-page").hide();
        activeUpdateHomeToggle = false;
        for(let app of $(".app-home-list-item:not(.app-home-list-item-primary)")) {
            app.classList.remove("draggable-element");
        }
    }
}

function displayPhone() {
    if(displayToggle) {
        $("#phone").css("bottom", phoneBottomShowNot);
        displayToggle = false;
        desactiveUpdateHome();
    } else {
        $("#phone").css("bottom", phoneBottomShow);
        displayToggle = true;
    }
}

function displayTopbar() {
    if(displayTopbarToggle) {
        $("#topbar-blur").css("opacity", "0");
        setTimeout(function() {
            $("#topbar-blur").hide();
            $("#phone-screen-content-topbar").hide();
        }, 300);
        $("#topbar-content").css("top", "-700px");
        displayTopbarToggle = false;
    } else {
        $("#phone-screen-content-topbar").show();
        $("#topbar-blur").show();
        $("#topbar-blur").css("opacity", "1");
        $("#topbar-content").css("top", "0px");
        displayTopbarToggle = true;
    }
}

function updateContent(menu) {
    let appSelected = document.getElementById("app-" + menu);
    if(!appSelected) {
        return;
    }
    if(menu == "clock" && !activateAppClockToggle) {
        activateAppClock();
    } else if(menu == "settings" && !activateAppSettingsToggle) {
        activateAppSettings();
    }
    desactiveUpdateHome();
    FooterColor = "#ffffff";
    FooterColorBackground = "transparent";
    Bodycolor = "#ffffff";
    BodyColorBackground = "transparent";
    for(let content of document.getElementsByClassName("app")) {
        if(content.id.split("-")[1] != "home") {
            content.style.transform = "scale(0)";
            if(menu != content.id.split("-")[1]) {
                setTimeout(function() {
                    content.style.display = "none";
                }, 300);
            } else {
                content.style.display = "none";
            }
        }
    }
    $("#app-" + menu).show();
    if(appSelected.id.split("-")[1] != "home") {
        appSelected.style.transform = "scale(1)";
    }
    if(menu != "home") {
        for(let app of config.apps) {
            if(app.name == menu) {
                FooterColor = app.footerColor;
                FooterColorBackground = app.footerColorBackground;
                Bodycolor = app.bodyColor;
                BodyColorBackground = app.bodyColorBackground;            
            }
        }
    }
    if(menu != "home") {
        if(appSelected.classList.contains("app-tabbed")) {
            $("#phone-screen-content").addClass("app-tabbed");
        } else if(appSelected.classList.contains("app-modal")) {
            $("#phone-screen-content").addClass("app-modal");
        }
        $("#phone-screen-content").addClass("app-" + menu);
    } else if(menu == "home") {
        $("#phone-screen-content").removeClass();
        setTimeout(function() {
            updateAppContent("first");
        }, 300);
    }
    menuSelected = menu;
}

function updateAppContent(element) {
    menuAppSelectedLast = menuAppSelected;
    menuAppSelected = element;
    let elementSelected = "";
    for(let content of document.getElementsByClassName("app-body-content")) {
        content.style.display = "none";
    }
    // for(let footerElement of $(".app-tab-button")) {
    //     footerElement.classList.remove("active");
    // }
    if(element == "first") {
        for(let content of document.getElementsByClassName("app")) {
            for(let appContent of content.getElementsByClassName("app-body-content")) {
                appContent.style.display = "block";
                $("#app-tab-button-" + appContent.id.split("-")[4]).addClass("active");
                if(content.id.split("-")[1] == menuSelected) {
                    elementSelected = appContent.id.split("-")[4];
                }
                break;
            }
        }
    } else {
        document.getElementById("app-"+ menuSelected  + "-body-content-" + element).style.display = "block";
        elementSelected = element;
        $("#app-tab-button-" + element).addClass("active");
    }
    if(element == "newmessage") {
        $(".newmessage-list-item").click(function() {
            this.classList.toggle("active");
        });
        let searchInput = document.getElementById("app-message-body-content-newmessage-search");
        searchInput.value = "";
        for(let elt of $(".newmessage-list-item")) {
            if(elt.querySelector(".newmessage-list-item-right-header-name").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "flex";
            } else {
                elt.style.display = "none";
            }
        }
        searchInput.addEventListener('input', (e) => {
            for(let elt of $(".newmessage-list-item")) {
                if(elt.querySelector(".newmessage-list-item-right-header-name").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                    elt.style.display = "flex";
                } else {
                    elt.style.display = "none";
                }
            }
        });
    }
    if(menuSelected == "contacts" && elementSelected == "list") {
        let searchInput = document.getElementById("app-contacts-body-content-list-search");
        searchInput.value = "";
        for(let elt of $(".contacts-list-row-item")) {
            if(elt.querySelector(".contacts-list-row-item-name span").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "flex";
            } else {
                elt.style.display = "none";
            }
        }
        searchInput.addEventListener('input', (e) => {
            for(let elt of $(".contacts-list-row-item")) {
                if(elt.querySelector(".contacts-list-row-item-name span").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                    elt.style.display = "flex";
                } else {
                    elt.style.display = "none";
                }
            }
        });
    }
}

function unlockPhone() {
    let menuSelectedUnlock = document.getElementById("app-" + menuSelected);
    if(menuSelectedUnlock != null && menuSelectedUnlock.id != "app-home") {
        if(menuSelectedUnlock.classList.contains("app-tabbed")) {
            $("#phone-screen-content").addClass("app-tabbed");
        } else if(menuSelectedUnlock.classList.contains("app-modal")) {
            $("#phone-screen-content").addClass("app-modal");
        }
        $("#phone-screen-content").addClass("app-" + menuSelected);
    }
    $("#phone-lock").hide();
    $("#phone-lock").css("transform", "translate(0, -100%)");
    $("#app-content").css("transform", "scale(1)");
    $("#app-content").css("opacity", "1");
    phoneLockToggle = false;
    $("#phone-lock-button i").removeClass("fa-lock-open");
    $("#phone-lock-button i").addClass("fa-lock");
    if(!displayToggle) {
        displayPhone();
    }
}

function lockPhone() {
    let menuSelectedLock = document.getElementById("app-" + menuSelected);
    if(menuSelectedLock != null && menuSelectedLock.id != "app-home") {
        $("#phone-screen-content").removeClass();
    }
    desactiveUpdateHome();
    $("#phone-lock").show();
    $("#phone-lock").css("transform", "translate(0, 0)");
    setTimeout(function() {
        $("#app-content").css("transform", "scale(3)");
        $("#app-content").css("opacity", "0");
    }, 0);
    phoneLockToggle = true;
    $("#phone-lock-button i").removeClass("fa-lock");
    $("#phone-lock-button i").addClass("fa-lock-open");
}

function updateHomeDots() {
    let active = $(".app-home-dot.active");
    let inactive = $(".app-home-dot:not(.active)");
    active.removeClass("active");
    inactive.addClass("active");
}

function handleDragStart(e) {
    if(activeUpdateHomeToggle) {
        dragToggle = true;
        this.style.opacity = '0.4';
        dragSrcEl = this;
        e.dataTransfer.effectAllowed = 'move';
        e.dataTransfer.setData('text/html', this.innerHTML);
        e.dataTransfer.setData('class', this.classList);
    }
}

function handleDragOver(e) {
    if(activeUpdateHomeToggle) {
        if (e.preventDefault) {
            e.preventDefault();
        }
        e.dataTransfer.dropEffect = 'move';
        return false;
    }
}

function handleDragEnter(e) {
    if(activeUpdateHomeToggle) {
        this.classList.add('over');
    }
}

function handleDragLeave(e) {
    hasChangePageOnDrag = false;
    if(activeUpdateHomeToggle) {
        this.classList.remove('over');
    }
}

function handleDrop(e) {
    if(activeUpdateHomeToggle) {
        if (e.stopPropagation) {
            e.stopPropagation(); // stops the browser from redirecting.
        }
        if (dragSrcEl != this) {
            dragToggle = false;
            hasChangePageOnDrag = false;
            dragSrcEl.innerHTML = this.innerHTML;
            dragSrcEl.classList = this.classList;
            if(dragSrcEl.classList.contains("empty-place")) {
                dragSrcEl.setAttribute("draggable", "false");
            }
            dragSrcEl.style.opacity = '1';
            this.innerHTML = e.dataTransfer.getData('text/html');
            this.classList = e.dataTransfer.getData('class');
            this.setAttribute("draggable", "true");
        }
        return false;
    }
}

function handleDragEnd(e) {
    if(activeUpdateHomeToggle) {
        dragToggle = false;
        hasChangePageOnDrag = false;
        this.style.opacity = '1';
        dragSrcEl.style.opacity = '1';
        items.forEach(function (item) {
            item.classList.remove('over');
        });
    }
}

function updatePageSelected() {
    if(pageSelectedStart == 1) {
        $("#app-home-page-container").css("left", "-100%");
        pageSelectedStart = 2;
        updateHomeDots();
    } else if(pageSelectedStart == 2) {
        $("#app-home-page-container").css("left", "0%");
        pageSelectedStart = 1;
        updateHomeDots();
    }
}

function activateAppClock() {
    activateAppClockToggle = true;
    for(let timeClock of config.timelist) {
        let divElement = "<div class='app-body-content-body-list-item'><div class='app-body-content-body-list-item-area'><div class='app-body-content-body-list-item-area-day'>" + timeClock.day + ", " + timeClock.gym + "</div><div class='app-body-content-body-list-item-area-time-zone'>" + timeClock.zone + "</div></div><div class='app-body-content-body-list-item-time'></div></div>";
        $("#app-clock-body-content-clock .app-body-content-body-list").append(divElement);
    }
    let now = new Date();
    let i = 0;
    for(let time of config.timelist) {
        time.now = now.toLocaleString("fr-FR", {
            timeStyle: "short",
            timeZone: time.timezone
        });
        document.querySelectorAll("#app-clock-body-content-clock .app-body-content-body-list-item")[i].querySelector(".app-body-content-body-list-item-time").innerHTML = time.now;
        i += 1;
    }
	setInterval(function () {
        let now = new Date();
        let i = 0;
        for(let time of config.timelist) {
            time.now = now.toLocaleString("fr-FR", {
                timeStyle: "short",
                timeZone: time.timezone
            });
            document.querySelectorAll("#app-clock-body-content-clock .app-body-content-body-list-item")[i].querySelector(".app-body-content-body-list-item-time").innerHTML = time.now;
            i += 1;
        }
    }, 1000);
}

function activateAppSettings() {
    activateAppSettingsToggle = true;
    for(let wallpaper of config.wallpaper) {
        let divWallpaper = "<div data-wallpaper='" + wallpaper.title + "' class='settings-wallpaper-list-item'><div class='settings-wallpaper-list-item-img'><div class='settings-wallpaper-list-item-img-light'><img src='./assets/images/wallpaper/" + wallpaper.title + "-light.jpg' /></div><div class='settings-wallpaper-list-item-img-dark'><img src='./assets/images/wallpaper/" + wallpaper.title + "-dark.jpg' /></div><i class='fa-solid fa-circle-check wallpaper-active'></i><i class='fa-solid fa-circle-half-stroke'></i></div><span>" + wallpaper.label + "</span></div>";
        $("#settings-wallpaper-list").append(divWallpaper);
        $("#settings-wallpaper-lock-list").append(divWallpaper);
        let wallpaperElement = $("#settings-wallpaper-list").children().last();
        let wallpaperLockElement = $("#settings-wallpaper-lock-list").children().last();
        if(wallpaper.title == wallpaperActive) {
            wallpaperElement.addClass("active");
        }
        if(wallpaper.title == wallpaperLockActive) {
            wallpaperLockElement.addClass("active");
        }
        wallpaperElement.click(function() {
            wallpaperActive = $(this).attr("data-wallpaper");
            $("#settings-wallpaper-list .settings-wallpaper-list-item").removeClass("active");
            $("#phone-screen").removeClass();
            $("#phone-screen").css("background-image", "");
            wallpaperElement.addClass("active");
            $("#phone-screen").addClass(wallpaperActive);
        });
        wallpaperLockElement.click(function() {
            wallpaperLockActive = $(this).attr("data-wallpaper");
            $("#settings-wallpaper-lock-list .settings-wallpaper-list-item").removeClass("active");
            $("#phone-lock").removeClass();
            $("#phone-lock").css("background-image", "");
            wallpaperLockElement.addClass("active");
            $("#phone-lock").addClass(wallpaperLockActive);
        });
    }
    for(let soundNotificationItem of config.soundnotification) {
        let divSoundNotification = "<div data-soundnotification='" + soundNotificationItem.title + "' class='settings-list-item'><div class='settings-list-item-left'><div class='settings-list-item-left-title'><span>" + soundNotificationItem.label + "</span></div></div><div class='settings-list-item-right'><div class='settings-list-item-right-button'><i class='fa-solid fa-check settings-list-item-right-button-check'></i></div></div></div>";
        $("#settings-list-sound-notification").append(divSoundNotification);
        let soundNotificationElement = $("#settings-list-sound-notification").children().last();
        if(soundNotificationItem.title == soundNotificationActive) {
            soundNotificationElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundnotification .settings-list-item-right-info span").html(soundNotificationItem.label);
            soundNotification = new Audio("assets/sounds/notifications/" + soundNotificationActive + ".mp3");
            soundNotification.volume = soundNotificationVolume;
        }
        soundNotificationElement.click(function() {
            soundNotificationActive = $(this).attr("data-soundnotification");
            stopSounds();
            soundNotification = new Audio("assets/sounds/notifications/" + soundNotificationActive + ".mp3");
            soundNotification.volume = soundNotificationVolume;
            $("#settings-list-sound-notification .settings-list-item-right-button-check").removeClass("active");
            soundNotificationElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundnotification .settings-list-item-right-info span").html(soundNotificationItem.label);
            soundNotification.play();
        });
    }
    for(let soundRingingItem of config.soundringing) {
        let divSoundRinging = "<div data-soundringing='" + soundRingingItem.title + "' class='settings-list-item'><div class='settings-list-item-left'><div class='settings-list-item-left-title'><span>" + soundRingingItem.label + "</span></div></div><div class='settings-list-item-right'><div class='settings-list-item-right-button'><i class='fa-solid fa-check settings-list-item-right-button-check'></i></div></div></div>";
        $("#settings-list-sound-ringing").append(divSoundRinging);
        let soundRingingElement = $("#settings-list-sound-ringing").children().last();
        if(soundRingingItem.title == soundRingingActive) {
            soundRingingElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundringing .settings-list-item-right-info span").html(soundRingingItem.label);
            soundRinging = new Audio("assets/sounds/ringings/" + soundRingingActive + ".mp3");
            soundRinging.volume = soundRingingVolume;
        }
        soundRingingElement.click(function() {
            soundRingingActive = $(this).attr("data-soundringing");
            stopSounds();
            soundRinging = new Audio("assets/sounds/ringings/" + soundRingingActive + ".mp3");
            soundRinging.volume = soundRingingVolume;
            $("#settings-list-sound-ringing .settings-list-item-right-button-check").removeClass("active");
            soundRingingElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundringing .settings-list-item-right-info span").html(soundRingingItem.label);
            soundRinging.play();
        });
    }
    for(let soundAlarmItem of config.soundalarm) {
        let divSoundAlarm = "<div data-soundalarm='" + soundAlarmItem.title + "' class='settings-list-item'><div class='settings-list-item-left'><div class='settings-list-item-left-title'><span>" + soundAlarmItem.label + "</span></div></div><div class='settings-list-item-right'><div class='settings-list-item-right-button'><i class='fa-solid fa-check settings-list-item-right-button-check'></i></div></div></div>";
        $("#settings-list-sound-alarm").append(divSoundAlarm);
        let soundAlarmElement = $("#settings-list-sound-alarm").children().last();
        if(soundAlarmItem.title == soundAlarmActive) {
            soundAlarmElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundalarm .settings-list-item-right-info span").html(soundAlarmItem.label);
            soundAlarm = new Audio("assets/sounds/alarms/" + soundAlarmActive + ".mp3");
            soundAlarm.volume = soundAlarmVolume;
        }
        soundAlarmElement.click(function() {
            soundAlarmActive = $(this).attr("data-soundalarm");
            stopSounds();
            soundAlarm = new Audio("assets/sounds/alarms/" + soundAlarmActive + ".mp3");
            soundAlarm.volume = soundAlarmVolume;
            $("#settings-list-sound-alarm .settings-list-item-right-button-check").removeClass("active");
            soundAlarmElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundalarm .settings-list-item-right-info span").html(soundAlarmItem.label);
            soundAlarm.play();
        });
    }
    for(let generalZoomItem of config.generalzoom) {
        let divGeneralZoom = "<div data-generalzoom='" + generalZoomItem.title + "' class='settings-list-item'><div class='settings-list-item-left'><div class='settings-list-item-left-title'><span>" + generalZoomItem.label + "</span></div></div><div class='settings-list-item-right'><div class='settings-list-item-right-button'><i class='fa-solid fa-check settings-list-item-right-button-check'></i></div></div></div>";
        $("#settings-list-general-zoom").append(divGeneralZoom);
        let generalZoomElement = $("#settings-list-general-zoom").children().last();
        if(generalZoomItem.title == generalZoomActive) {
            generalZoomElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-generalzoom .settings-list-item-right-info span").html(generalZoomItem.label);
            generalZoom = generalZoomItem.value + "%";
            $("#phone").css("zoom", generalZoom);
        }
        generalZoomElement.click(function() {
            generalZoomActive = $(this).attr("data-generalzoom");
            generalZoom = generalZoomItem.value + "%";
            $("#phone").css("zoom", generalZoom);
            $("#settings-list-general-zoom .settings-list-item-right-button-check").removeClass("active");
            generalZoomElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-generalzoom .settings-list-item-right-info span").html(generalZoomItem.label);
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ uuid: userData.uuid, phone: { zoom: generalZoomActive } }));
        });
    }
}

function updateZoom() {
    for(let generalZoomItem of config.generalzoom) {
        if(generalZoomItem.title == generalZoomActive) {
            generalZoom = generalZoomItem.value + "%";
        }
    }
    $("#phone").css("zoom", generalZoom);
}

function updateProfile() {
    $("#settings-profile-serial-number").html(serialNumber);
    $("#settings-profile-first-name").html(firstName);
    $("#settings-profile-last-name").html(lastName);
    $("#settings-profile-number").html(phoneNumber);
}

function updateWallpaper() {
    let wallpaperElement = false;
    let wallpaperLockElement = false;
    for(let wallpaper of config.wallpaper) {
        if(wallpaper.title == wallpaperActive) {
            $("#phone-screen").removeClass();
            $("#phone-screen").addClass(wallpaperActive);
            wallpaperElement = true;
        }
        if(wallpaper.title == wallpaperLockActive) {
            $("#phone-lock").removeClass();
            $("#phone-lock").addClass(wallpaperLockActive);
            wallpaperLockElement = true;
        }
    }
    if(!wallpaperElement) {
        if(wallpaperActive.length > 0) {
            $("#phone-screen").css("background-image", "url(" + wallpaperActive + ")");
        }
    }
    if(!wallpaperLockElement) {
        if(wallpaperLockActive.length > 0) {
            $("#phone-screen").css("background-image", "url(" + wallpaperLockActive + ")");
        }
    }
}

function isImage(url) {
    return /^https?:\/\/.+\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(url);
}

function stopSounds() {
    soundNotification.pause();
    soundRinging.pause();
    soundAlarm.pause();
}

const config = {
    "apps": [
        {
            "name": "clock",
            "label": "Horloge"
        },
        {
            "name": "camera",
            "label": "Caméra"
        },
        {
            "name": "galery",
            "label": "Galerie"
        },
        {
            "name": "calandar",
            "label": "Calendrier"
        },
        {
            "name": "notes",
            "label": "Notes"
        },
        {
            "name": "calculator",
            "label": "Calculatrice"
        },
        {
            "name": "store",
            "label": "Magasin"
        },
        {
            "name": "music",
            "label": "Musique"
        },
        {
            "name": "templatetabbed",
            "label": "Template Tabbed"
        },
        {
            "name": "call",
            "label": "Appel",
            "isPrimary": true
        },
        {
            "name": "contacts",
            "label": "Contacts",
            "isPrimary": true
        },
        {
            "name": "message",
            "label": "Message",
            "isPrimary": true,
        },
        {
            "name": "settings",
            "label": "Paramètre",
            "isPrimary": true
        }
    ],
    "timelist": [
        { day: "Ajourd'hui", gym: "+0h", timezone: "Asia/Taipei", zone: "Taipei", now: 0 },
        { day: "Ajourd'hui", gym: "-12h", timezone: "America/New_York", zone: "New York", now: 0 },
        { day: "Ajourd'hui", gym: "-7h", timezone: "Europe/London", zone: "Londre", now: 0 }
    ],
    "wallpaper": [
        {
            "title": "wallpaper-ios15",
            "label": "IOS 15",
            "theme": true
        },
        {
            "title": "wallpaper-starlight",
            "label": "starlight",
            "theme": true
        },
        {
            "title": "wallpaper-midnight",
            "label": "midnight",
            "theme": true
        },
        {
            "title": "wallpaper-blue",
            "label": "blue",
            "theme": true
        },
        {
            "title": "wallpaper-pink",
            "label": "pink",
            "theme": true
        },
        {
            "title": "wallpaper-red",
            "label": "red",
            "theme": true
        },
        {
            "title": "wallpaper-green",
            "label": "green",
            "theme": true
        },
        {
            "title": "wallpaper-silver",
            "label": "silver",
            "theme": true
        },
        {
            "title": "wallpaper-graphite",
            "label": "graphite",
            "theme": true
        },
        {
            "title": "wallpaper-gold",
            "label": "gold",
            "theme": true
        },
        {
            "title": "wallpaper-sierraBlue",
            "label": "sierrablue",
            "theme": true
        },
        {
            "title": "wallpaper-alpineGreen",
            "label": "alpinegreen",
            "theme": true
        }
    ],
    "soundnotification": [
        {
            "title": "notification-ios12",
            "label": "IOS 12"
        },
        {
            "title": "notification-ios13",
            "label": "IOS 13"
        },
        {
            "title": "notification-ios420",
            "label": "IOS 420"
        },
        {
            "title": "notification-iosmessenger",
            "label": "IOS Messenger"
        },
        {
            "title": "notification-magic",
            "label": "Magic"
        },
        {
            "title": "notification-sms1",
            "label": "SMS 1"
        },
        {
            "title": "notification-sms2",
            "label": "SMS 2"
        },
        {
            "title": "notification-tune",
            "label": "Tune"
        },
    ],
    "soundringing": [
        {
            "title": "ringing-edsheeran",
            "label": "Ed Sheeran"
        },
        {
            "title": "ringing-iosdubstep",
            "label": "IOS Dubstep"
        },
        {
            "title": "ringing-iosoriginal",
            "label": "IOS Original"
        },
        {
            "title": "ringing-oldphone",
            "label": "Vieux Téléphone"
        },
        {
            "title": "ringing-zeze",
            "label": "ZEZE"
        },
    ],
    "soundalarm": [
        {
            "title": "alarm-iosradaroriginal",
            "label": "IOS Original"
        },
        {
            "title": "alarm-reflection",
            "label": "Reflection"
        },
    ],
    "generalzoom": [
        {
            "title": "zoom150%",
            "label": "150%",
            "value": 100
        },
        {
            "title": "zoom125%",
            "label": "125%",
            "value": 85
        },
        {
            "title": "zoom100%",
            "label": "100%",
            "value": 75
        },
        {
            "title": "zoom75%",
            "label": "75%",
            "value": 65
        },
        {
            "title": "zoom50%",
            "label": "50%",
            "value": 55
        },
        {
            "title": "zoom25%",
            "label": "25%",
            "value": 45
        },
    ],
}




// {
//     "playerId":1,
//     "uuid":"1ecf5795-5756-6e50-0f89-90dff4b5bac9",
//     "steamId":"steam:11000010e370f0a",
//     "phoneNumber":"5556585",
//     "firstName":"Mike",
//     "lastName":"Bell",
//     "phone":{
//         "id":1,
//         "playerUuid":"1ecf5795-5756-6e50-0f89-90dff4b5bac9",
//         "serialNumber":"5869-5852",
//         "firstName":"Mike",
//         "lastName":"Bell",
//         "number":"5559689",
//         "isActive":true,
//         "soundNotification":"notification-magic",
//         "soundRinging":"ringing-iosoriginal",
//         "soundAlarm":"alarm-iosradaroriginal",
//         "soundNotification":1,
//         "soundRingingVolume":1,
//         "soundAlarmVolume":1,
//         "darkMode":false,
//         "zoom":"zoom100%",
//         "wallpaper":"wallpaper-midnight",
//         "wallpaperLock":"wallpaper-midnight",
//         "luminosity":10,
//         "appHomeOrder":""
//     },
//     "contacts":
//         [
//             {
//                 "id":-1,
//                 "playerUuid":"1ecf5795-5756-6e50-0f89-90dff4b5bac9",
//                 "name":"Urgences",
//                 "number":"911"
//             }
//         ],
//     "messages":[],
//     "calls":[]
// }