
// --- Variables constantes
// Dossier
const folderAssets = "./assets/";
const folderImages = folderAssets + "images/";
const folderWallpaper = folderImages + "wallpaper/";
const folderAppIcon = folderImages + "app-icon/";
const folderApps = folderImages + "apps/"
const folderContactsProfileIcon = folderApps + "contacts/profile-icon/";
const folderSounds = folderAssets + "sounds/";
const folderAlarms = folderSounds + "alarms/";
const folderNotifications = folderSounds + "notifications/";
const folderRingings = folderSounds + "ringings/";
const contactAvatarDefault = folderContactsProfileIcon + "50-Animals-avatar_49.png";

// SVG d'icones
const copyIcon =        `<svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.5" style="margin-right: 7px" fill="none" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>`;
const cutIcon =         `<svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.5" style="margin-right: 7px" fill="none" stroke-linecap="round" stroke-linejoin="round"><circle cx="6" cy="6" r="3"></circle><circle cx="6" cy="18" r="3"></circle><line x1="20" y1="4" x2="8.12" y2="15.88"></line><line x1="14.47" y1="14.48" x2="20" y2="20"></line><line x1="8.12" y1="8.12" x2="12" y2="12"></line></svg>`;
const pasteIcon =       `<svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.5" style="margin-right: 7px;top: -1px;" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg>`;
const downloadIcon =    `<svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.5" style="margin-right: 7px;top: -1px;" fill="none" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>`;
const deleteIcon =      `<svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2.5" style="margin-right: 7px" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>`;
const renameIcon =      `<svg viewBox="0 0 20 20" width="13" height="13" stroke-width="2.5" style="margin-right: 7px" fill="none" stroke-linecap="round" stroke-linejoin="round"><path fill="currentColor" d="M19.404,6.65l-5.998-5.996c-0.292-0.292-0.765-0.292-1.056,0l-2.22,2.22l-8.311,8.313l-0.003,0.001v0.003l-0.161,0.161c-0.114,0.112-0.187,0.258-0.21,0.417l-1.059,7.051c-0.035,0.233,0.044,0.47,0.21,0.639c0.143,0.14,0.333,0.219,0.528,0.219c0.038,0,0.073-0.003,0.111-0.009l7.054-1.055c0.158-0.025,0.306-0.098,0.417-0.211l8.478-8.476l2.22-2.22C19.695,7.414,19.695,6.941,19.404,6.65z M8.341,16.656l-0.989-0.99l7.258-7.258l0.989,0.99L8.341,16.656z M2.332,15.919l0.411-2.748l4.143,4.143l-2.748,0.41L2.332,15.919z M13.554,7.351L6.296,14.61l-0.849-0.848l7.259-7.258l0.423,0.424L13.554,7.351zM10.658,4.457l0.992,0.99l-7.259,7.258L3.4,11.715L10.658,4.457z M16.656,8.342l-1.517-1.517V6.823h-0.003l-0.951-0.951l-2.471-2.471l1.164-1.164l4.942,4.94L16.656,8.342z"></path></svg>`

// --- Variables par défauts

// Affichage
let menuSelected = "home";
let menuSelectedLast = "home";
let menuAppSelected = "first";
let menuAppSelectedLast = "first";
let displayToggle = false;
let displayTopbarToggle = false;
let formatOrientation = "portrait"
let phoneBottomShow = "30px";
let phoneBottomShowLandscape = "-150px";
let phoneBottomShowNot = "-900px";
let phoneLockToggle = false;
let lockIconSnoozeEffect = false;
let contextMenuItemClicked;
let notificationMode = "normal"; // normal / nosound / none
let phoneActive = false;
let phoneTest = false;

// App Home
let pageSelectedStart = 1;  
let hasChangePageOnDrag = false;
let mousePosition = {
    x: null,
    y: null
};
let offset = [0,0];
let pageSelected;
let isDown = false;
let contextMenuHomeTarget;

// App Clock
let activateAppClockToggle = false;
let alarmList = [];
let stopWatch = {
    stopStart: false,
    loopShow: false,
    loopNumber: 0,
    timer: "",
    hh: 0,
    mm: 0,
    ss: 0
};
let timer = {
    stopStart: false,
    loopShow: false,
    isFinish: false,
    timer: "",
    hh: 0,
    mm: 0,
    ss: 0
};

// App Store
let isDownloadApp = false;

// Settings / Data info
let userData;
let darkMode = false;
let wallpaperActive = "wallpaper-midnight";
let wallpaperLockActive = "wallpaper-midnight";
let soundNotificationActive = "notification-magic";
let soundNotification = "";
let soundNotificationVolume = 5;
let soundRingingActive = "ringing-iosoriginal";
let soundRinging = "";
let soundRingingVolume = 5;
let soundAlarmActive = "alarm-iosradaroriginal";
let soundAlarm = "";
let soundAlarmVolume = 5;
let soundCallWait = "";
let generalZoomActive = "zoom100%";
let generalZoom = "75%";
let serialNumber = "";
let firstName = "";
let lastName = "";
let phoneNumber = "";
let luminosityActive = 10;
let volumeActive = 10;

// App Call
let inReceiveCall = false;
let inCall = false;
let callData = "";

// App Contact
let contactId;
let contactPhoneNumber;
let contactName;
let contactAvatar;
// Save Call Notification
let callNotification;
let callNotificationLock;

// App Message
let conversationAuthors = [];
let conversationId = "";
let messageTargetNumber = "";
let longpress = true;
let startTime, endTime;
let gridPage1 = "";

// App Richter Motorsport
let RichterMotorSportCurrentAdvertisement;

// App Camera
let canvasActivate = false;

// App Notes
let notesListItem = false;
let notesNoteInputToggle = true;
let notesFolderContextMenu;
let notesNoteContextMenu;

// App Maps
let map;
let markerList = [];
let markerFavoriteList = [];
let mapsIntervalMyPosition;
let markerMyPosition;
let bounds;

const Delay = ms => new Promise(r=>setTimeout(r, ms));

$(function(){
    window.onload = async (e) => {

        // --- Inisialisation du téléphone --- //

            // Request user data / Pour des tests
            // $.post('https://OraPhone/request_user_data', JSON.stringify({}));

            // Intérception fonction Lua
            window.addEventListener('message', async (event) => {
                let item = event.data;
                if (item == undefined) {
                    return;
                }
                switch(item.type) {
                    case "oraPhoneUI":
                        displayPhone(item.display);
                        break;
                    case "updateUserData":
                        await updateUserData(item.data);
                        break;
                    case "receiveCall":
                        receiveCall(item);
                        break;
                    case "callStarted":
                        updateAppContent("callstarted");
                        stopSounds();
                        let name = item.targetNumber;
                        for(let contact of userData.contacts) {
                            if(contact.number.toString() == item.targetNumber.toString()) {
                                name = contact.name;
                            }
                        }
                        $("#callstarted-number").html("Appel en cours avec" + "<br/>" + name);
                        $("#callstarted-time").html("00:00");
                        let callStartedSec = 0;
                        let callStartedMin = 0;
                        let callStartedTimer = setInterval(function() {
                                $("#callstarted-time").html((callStartedMin < 10 ? "0" + callStartedMin : callStartedMin) + ":" + (callStartedSec < 10 ? "0" + callStartedSec : callStartedSec));
                                if(callStartedSec == 59) {
                                    callStartedSec = 0;
                                    callStartedMin++;
                                } else {
                                    callStartedSec++;
                                }
                                if(!inCall) {
                                    clearInterval(callStartedTimer);
                                }
                        }, 1000);
                        break;
                    case "callEnded":
                        inCall = false;
                        inReceiveCall = false;
                        callData = "";
                        if(menuAppSelectedLast != "call") {
                            updateContent(menuSelectedLast);
                        } else {
                            updateContent("home");
                        }
                        updateAppContent("first");
                        stopSounds();
                        if(callNotification != null && callNotification != undefined) {
                            callNotification.style.opacity = "0";
                            callNotificationLock.style.opacity = "0";
                            setTimeout(function() {
                                callNotification.remove();
                                callNotificationLock.remove();
                                if($("#notification-container").children().length == 0 && !displayToggle) {
                                    $("#phone").css("bottom", phoneBottomShowNot);
                                }
                            }, 750);
                        }
                        $.post('https://OraPhone/refresh_calls', JSON.stringify({ number: phoneNumber }));
                        break;
                    case "callNumberResponse":
                        updateContent("call");
                        updateAppContent("callnumber");
                        inCall = true;
                        soundCallWait.currentTime = 0;
                        soundCallWait.play();
                        break;
                    case "updateContacts":
                        userData.contacts = item.contacts;
                        updateAppContacts();
                        updateAppMessage();
                        $.post('https://OraPhone/refresh_conversations', JSON.stringify({ phoneId: userData.phone.id, number: userData.phone.number }));
                        $.post('https://OraPhone/refresh_calls', JSON.stringify({ number: phoneNumber }));
                        break;
                    case "updateCalls":
                        userData.calls = item.calls;
                        updateAppPhone();
                        break;
                    case "update_conversations":
                        userData.conversations = item.conversations;
                        if (item.conversationId != 0) {
                            conversationId = item.conversationId;
                        }
                        if (item.updatetype != "update_read" && menuAppSelected == "message") {
                            updateAppMessageLoad(conversationId);
                        }
                        updateConversationList();
                        break;
                    case "new_notification":
                        addNotification(item.notification.app, item.notification.appSub, item.notification.time, item.notification.title, item.notification.message, { conversationId: item.notification.conversationId });
                        break;
                    case "updateRichterMotorsportAdvertisement":
                        userData.richterMotorsportAdvertisement = item.richterMotorsportAdvertisement;
                        updateAppRichterMotorsport();
                        break;
                    case "updateGalleryPhoto":
                        userData.galleryPhoto = item.galleryPhoto;
                        updateAppGallery();
                        break;
                    case "updateRichterMotorsportRole":
                        for(let job of item.richterMotorsportRole) {
                                userData.richterMotorsportRole = job;
                                if(job.name == "concess") {
                                    $("#richtermotorsport-button-create-advertisement").css("display", "flex");
                                    break;
                                } else {
                                    $("#richtermotorsport-button-create-advertisement").css("display", "none");
                                    break;
                                }
                        }
                        break;
                    case "take_picture":
                        takeScreenshot(item.app, item.appSub);
                        MainRender.stop();
                        break;
                    case "cancel_picture":
                        updateContent("home");
                        MainRender.stop();
                        break;
                    case "updateNotes":
                        userData.notes = item.notes;
                        updateAppNotes();
                        break;
                    case "phoneActive":
                        phoneActive = item.toggle;
                        break;
                    case "updateMapsFavorite":
                        userData.mapsFavorite = item.positions;
                        updateAppMaps();
                        break;
                    case "updateMapsMyPosition":
                        let newLatLng = new L.LatLng(item.position[1], item.position[0]);
                        markerMyPosition.setLatLng(newLatLng);
                        break;
                    case "takeCall":
                        takeCall();
                        break;
                    case "cancelCall":
                        $.post('https://OraPhone/end_call', JSON.stringify({}));
                        break;
                }
            });

            // Gestion des touches
            document.onkeydown = function (data) {
                // Touche P pour ouvrir le téléphone
                // if (data.which == 80) {
                //     displayPhone();
                // }
                // Touche Entrer pour déverrouiller le téléphone
                if (data.which == 13) {
                    unlockPhone();
                }
                // Touche Echap pour fermer le téléphone
                if (data.which == 27) {
                    $.post('https://OraPhone/phone_close', JSON.stringify({}));
                }
            }
            // Gestion du clique droit
            $("#phone").bind("contextmenu",function() {
                return false;
            });
            // Gestion entrer/sortie des inputs
            $(':input').on('blur', function() {
                $.post('https://OraPhone/EnableInput', JSON.stringify({}));
            });
            $(':input').on('focus', function() {
                $.post('https://OraPhone/DisableInput', JSON.stringify({}));
            });

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

            // Initialisation des applications
            initializeApps();

        // --- Inisialisation de test --- //

            // Affichage de l'écran de test
            let dateTest = {
                'phone': {
                    'darkMode': 0, 'wallpaper': "wallpaper-midnight", 'wallpaperLock': "wallpaper-midnight", 'soundNotification': "notification-magic", 'soundNotificationVolume': 5, 'soundRinging': "ringing-iosoriginal", 'soundRingingVolume': 5, 'soundAlarm': "alarm-iosradaroriginal", 'soundAlarmVolume': 5, 'zoom': "zoom100%", 'serialNumber': "5555-5555", 'firstName': "Mike", 'lastName': "Bell", 'number': "5556868", 'luminosity': 100, 'appHomeOrder': JSON.stringify([ 'clock', 'camera', 'gallery', 'calandar', '', '', '', '', 'store', 'music', 'notes', 'calculator', '', '', '', '', 'richtermotorsport', 'maps', 'bank', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
                    ])
                }
            }
            if (phoneTest) {
                await updateUserData(dateTest);
                displayPhone(true);
                updateContent("bank");
                updateAppContent("first");
                $("#message-list").children().click(function () {
                    updateAppContent("message");
                });
                let messageInput = $("#app-message-footer-input");
                messageInput.on("keyup", function(e) {
                    if (e.key === 'Enter' || e.keyCode === 13) {
                        if (messageInput.val() != "") {
                            // if (/^https:\/\/i.imgur.com\/[a-zA-Z0-9_.-]+.jpg$/.test(messageInput.val())) {
                            //     let newMessageDiv = '<div class="myMessage"><p>Bonjour</p><span class="date"><b>Mike</b> 10:29</span></div>';
                            //     $('.app-message-conversation .messages').append(newMessageDiv);
                            // }
                            messageInput.val("");
                        }
                    }
                });
                $("#message-photo-button-gallery").click(function () {
                    updateContent("gallery");
                    $("#gallery-image-list .gallery-image-list-item").addClass("bind-click");
                    $("#gallery-image-list .gallery-image-list-item").bind("click", messageChooseImageGallery);
                });
            }
        
        // Ajout d'une bulle dans une conversation
        // $('.app-message-conversation .messages').append('<div class="chat-bubble"><div class="loading"><div class="dot one"></div><div class="dot two"></div><div class="dot three"></div></div><div class="tail"></div></div>');

	};
});

// --- Fonctions --- //

// Mise à jour total
async function updateUserData(data) {
    // Inisiialisation de l'accueil
    if (!phoneTest) {
        updateContent("home");
        updateAppContent("first");
        lockPhone();
    }
    // Update main variables
    userData = data;
    darkMode = (data.phone.darkMode == 1 ? true : false);
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
    updateSound();
    updateWallpaper();
    updateDarkMode();
    updateZoom();
    updateProfile();
    updateLuminosity();
    updateVolume();
    updateAppHomeOrder();

    // Mise à jour des applications
    $.post('https://OraPhone/refresh_contacts', JSON.stringify({ phoneId: userData.phone.id }));
    $.post('https://OraPhone/refresh_conversations', JSON.stringify({ phoneId: userData.phone.id, number: userData.phone.number }));
    $.post('https://OraPhone/refresh_calls', JSON.stringify({ number: phoneNumber }));
    $.post('https://OraPhone/refresh_gallery', JSON.stringify({ phoneId: userData.phone.id }));
    $.post('https://OraPhone/refresh_richtermotorsport_advertisement', JSON.stringify({ phoneId: userData.phone.id }));
    // $.post('https://OraPhone/refresh_notes', JSON.stringify({ phoneId: userData.phone.id }));
}

function initializeApps() {
    // Initialisation des applications
    initializeAppScreen();
    initializeAppContacts();
    initializeAppMessage();
    initializeAppCall();
    initializeAppPhone();
    initializeAppSettings();
    initializeAppStore();
    initializeAppClock();
    initializeAppCalculator();
    initializeAppCamera();
    initializeAppRichterMotorsport();
    initializeAppNotes();
    initializeAppGallery();
    initializeAppMaps();

    conversationAuthors = "";

    // Initialisation des boutons généraux de chaques applications
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
    $(".app-tab-button").click(function() {
        updateAppContent(this.id.split("-")[3]);
    });
    $("#app-store .app-body-content-body-list-item").click(function() {
        updateAppContent("app");
    });
}

// Initialisation des applications

function initializeAppScreen() {
    $("#phone-screen-content-header").click(function () {
        displayTopbar();
    });
    $("#phone-screen-content-footer").click(function () {
        if(displayTopbarToggle) {
            displayTopbar();
        } else {
            updateContent("home");
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
    $("#topbar-box-button-notification-mode").click(function () {
        updateNotificationMode();
    });
    $("#topbar-box-button-torch").click(function () {
        $("#topbar-box-button-torch").toggleClass("active")
    });
    $("#topbar-box-button-clock").click(function () {
        updateContent("clock");
        displayTopbar();
    });
    $("#topbar-box-button-calculator").click(function () {
        updateContent("calculator");
        displayTopbar();
    });
    $("#topbar-box-button-camera").click(function () {
        updateContent("camera");
        displayTopbar();
    });
    $("#topbar-box-button-update-thememode").click(function() {
        switchThemeMode();
    });
    $("#app-unlock").click(function () {
        unlockPhone();
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
    $(window).click(function(e) {
        let elementTarget = e.target;
        if ($("#app-message-position").hasClass("active") && elementTarget != document.getElementById("message-position-button-show")) {
            $("#app-message-position").removeClass("active");
        }
        if ($("#app-message-photo").hasClass("active") && elementTarget != document.getElementById("message-photo-button-show")) {
            $("#app-message-photo").removeClass("active");
        }
    });
}

function initializeAppContacts() {
    // Inisialisation de la liste des icones
    for(let icon of config.contactsicon) {
        let divIcon = "<div data-title='" + icon.title + "' class='newcontact-icon-list-item'><img draggable='false' src='" + folderContactsProfileIcon + icon.title + ".png'/></div>";
        $("#newcontact-icon-list").append(divIcon);
        $("#newcontact-icon-list").children().last().click(function() {
            $("#newcontact-icon-custom-input").val("");
            $("#newcontact-icon-list").children().removeClass("active");
            $(this).addClass("active");
            let imgIcon = "<img draggable='false' src='" + folderContactsProfileIcon + $(this).data("title") + ".png'/>";
            $("#newcontact-profile-icon").empty();
            $("#newcontact-profile-icon").append(imgIcon);
            $("#newcontact-profile-icon").data("title", $(this).data("title"));
        });
        $("#editcontact-icon-list").append(divIcon);
        $("#editcontact-icon-list").children().last().click(function() {
            $("#editcontact-icon-custom-input").val("");
            $("#editcontact-icon-list").children().removeClass("active");
            $(this).addClass("active");
            let imgIcon = "<img draggable='false' src='" + folderContactsProfileIcon + $(this).data("title") + ".png'/>";
            $("#editcontact-profile-icon").empty();
            $("#editcontact-profile-icon").append(imgIcon);
            $("#editcontact-profile-icon").data("title", $(this).data("title"));
        });
    }
    // Inisialisation des inputs
    $("#newcontact-phone-number-input").on("input", function() {
        if($(this).val().length > 4) {
            $(this).val($(this).val().substring(0, 4));
        }
    });
    $("#editcontact-phone-number-input").on("input", function() {
        if($(this).val().length > 4) {
            $(this).val($(this).val().substring(0, 4));
        }
    });
    $("#newcontact-name-input").on("input", function() {
        if($(this).val().length > 25) {
            $(this).val($(this).val().substring(0, 25));
        }
        $("#newcontact-profile-name span").html($(this).val());
    });
    $("#editcontact-name-input").on("input", function() {
        if($(this).val().length > 25) {
            $(this).val($(this).val().substring(0, 25));
        }
        $("#editcontact-profile-name span").html($(this).val());
    });
    // Inisialisation des boutons
    $("#contacts-list-new-contact").click(function() {
        updateAppContent("newcontact");
    });
    $("#newcontact-create-button").click(function() {
        if($("#newcontact-phone-number-input").val().length == 4) {
            let profileIcon = ($("#newcontact-icon-custom-input").val() != '' && $("#newcontact-icon-custom-input").val().includes('http') ? $("#newcontact-icon-custom-input").val() : $("#newcontact-profile-icon").data("title"));
            let profilePhoneNumber = "555" + $("#newcontact-phone-number-input").val();
            let profileName = ($("#newcontact-name-input").val() != '' ? $("#newcontact-name-input").val() : "Nouveau Contact");
            $.post('https://OraPhone/add_contact', JSON.stringify({ phoneId: userData.phone.id, name: profileName, number: profilePhoneNumber, avatar: profileIcon }));
            updateAppContent("list");
            $("#newcontact-phone-number-input").val("");
            $("#newcontact-name-input").val("");
            $("#newcontact-icon-custom-input").val("");
            $("#newcontact-profile-name span").html("");
            $("#newcontact-profile-icon").data("title", "50-Animals-avatar_49");
            $("#newcontact-profile-icon img").attr("src", folderContactsProfileIcon + "50-Animals-avatar_49.png");
        }
    });
    $("#editcontact-save-button").click(function() {
        if($("#editcontact-phone-number-input").val().length == 4) {
            let profileIcon = ($("#editcontact-icon-custom-input").val() != '' && $("#editcontact-icon-custom-input").val().includes('http') ? $("#editcontact-icon-custom-input").val() : $("#editcontact-profile-icon").data("title"));
            let profilePhoneNumber = "555" + $("#editcontact-phone-number-input").val();
            let profileName = ($("#editcontact-name-input").val() != '' ? $("#editcontact-name-input").val() : "Nouveau Contact");
            $.post('https://OraPhone/update_contact', JSON.stringify({ id: contactId, phoneId: userData.phone.id, data: { name: profileName, number: profilePhoneNumber, avatar: profileIcon } }));
            updateAppContent("list");
        }
    });
    $("#editcontact-remove-button").click(function() {
        $.post('https://OraPhone/delete_contact', JSON.stringify({ id: contactId, phoneId: userData.phone.id }));
        updateAppContent("list");
    });
    $("#app-contacts-body-content-list-search-reset").click(function() {
        $("#app-contacts-body-content-list-search").val("");
        $(".contacts-list-row-item").css("display", "block");
    });
    $("#newcontact-button-takephoto").click(function() {
        activateAppCamera("contact", "newcontact");
    });
    $("#editcontact-button-takephoto").click(function() {
        activateAppCamera("contact", "editcontact");
    });
}

function initializeAppMessage() {
    $("#message-list-new-message").click(function() {
        updateAppContent("newmessage");
    });
    $("#newmessage-create-button").click(function() {
        conversationAuthors = [];
        conversationId = '';
        for(let contact of document.querySelectorAll("#newmessage-list .newmessage-list-item")) {
            if(contact.classList.contains("active")) {
                conversationAuthors.push(contact.dataset.number.toString());
                contact.classList.remove("active");
            }
        }
        conversationAuthors.push(userData.phone.number.toString());
        if(conversationAuthors.length < 2) {
            return;
        }
        $.post('https://OraPhone/message_create_conversation', JSON.stringify({ phoneId: userData.phone.id, number: userData.phone.number , authors: conversationAuthors }));
        updateAppContent("message");
    });
    $("#app-message-body-content-list-search-reset").click(function() {
        $("#app-message-body-content-list-search").val("");
        $("#message-list .app-body-content-body-list-item").css("display", "flex");
    });
    $("#message-position-button-show").click(function () {
        $("#app-message-position").toggleClass("active");
    })
    $("#message-photo-button-show").click(function () {
        $("#app-message-photo").toggleClass("active");
    })
    $("#message-header-button-remove").click(function() {
        $.post('https://OraPhone/message_delete_conversation', JSON.stringify({ id: $('.app-message-conversation .messages').data("conversation-id"), number: userData.phone.number }));
        updateAppContent("list");
    });
    $("#message-header-button-edit").click(function() {
        updateAppContent("editmessage");
        for (let conversation of userData.conversations) {
            if (conversation.id == $('.app-message-conversation .messages').data("conversation-id")) {
                if (conversation.name != null) {
                    $("#editmessage-list-item-rename input").val(conversation.name);
                } else {
                    $("#editmessage-list-item-rename input").val("");
                }
            }
        }
    });
    $("#message-header-button-save").click(function() {
        let conversationRenameInputVal = $("#editmessage-list-item-rename input").val();
        if (conversationRenameInputVal != "" && conversationRenameInputVal != null) {
            $.post('https://OraPhone/message_update_name_conversation', JSON.stringify({ id: $('.app-message-conversation .messages').data("conversation-id"), name: conversationRenameInputVal, number: userData.phone.number }));
            updateAppContent("message");
        }
    });
    $("#message-position-button-myposition").click(function () {
        $.post('https://OraPhone/add_message', JSON.stringify({ phoneId: userData.phone.id, targetNumber: messageTargetNumber, number: userData.phone.number, conversationId: conversationId, message: "GPSMYPOSITION" }));
    });
    $("#message-position-button-marker").click(function () {
        $.post('https://OraPhone/add_message', JSON.stringify({ phoneId: userData.phone.id, targetNumber: messageTargetNumber, number: userData.phone.number, conversationId: conversationId, message: "GPSMYMARKER" }));
    });
}

function initializeAppCall() {
    $("#callnumber-button-hangup").click(function() {
        $.post('https://OraPhone/end_call', JSON.stringify({}));
    });
    $("#callreceive-button-hangup").click(function() {
        $.post('https://OraPhone/end_call', JSON.stringify({}));
    });
    $("#callreceive-button-pickup").click(function() {
        takeCall();
    });
    $("#callstarted-button-hangup").click(function() {
        $.post('https://OraPhone/end_call', JSON.stringify({}));
    });
}

function initializeAppPhone() {
    $("#phonepad-phone-number span").html("555-");
    $("#phonepad-buttons li").click(function() {
        let targetNumber = $(this).data("number");
        if(targetNumber == "reset") {
            $("#phonepad-phone-number span").html("555-");
        } else if(targetNumber == "delete") {
            if($("#phonepad-phone-number span").html().length > 4) {
                $("#phonepad-phone-number span").html($("#phonepad-phone-number span").html().slice(0, -1));
            }
        } else if(targetNumber == "call") {
            if($("#phonepad-phone-number span").html().replace("-", "").length == 7) {
                callNumber($("#phonepad-phone-number span").html().replace("-", ""));
                $("#phonepad-phone-number span").html("555-");
            }
        } else {
            if($("#phonepad-phone-number span").html().length < 8) {
                $("#phonepad-phone-number span").html($("#phonepad-phone-number span").html() + targetNumber);
            }
        }
    });
}

function initializeAppSettings() {
    $("#settings-list-item-thememode label").change(function() {
        switchThemeMode();
    });
    $(".settings-list-item.child").click(function () {
        updateAppContent($(this).attr("id").split("-")[3]);
    });
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
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { wallpaper: wallpaperActive } }));
        });
        wallpaperLockElement.click(function() {
            wallpaperLockActive = $(this).attr("data-wallpaper");
            $("#settings-wallpaper-lock-list .settings-wallpaper-list-item").removeClass("active");
            $("#phone-lock").removeClass();
            $("#phone-lock").css("background-image", "");
            wallpaperLockElement.addClass("active");
            $("#phone-lock").addClass(wallpaperLockActive);
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { wallpaperLock: wallpaperLockActive } }));
        });
    }
    $("#settings-wallpaper-list-input div").click(function() {
        let link = $("#settings-wallpaper-list-input input").val();
        if(link.length > 0) {
            $("#phone-screen").css("background-image", "url(" + link + ")");
            $("#settings-wallpaper-list .settings-wallpaper-list-item").removeClass("active");
            wallpaperActive = link;
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { wallpaper: wallpaperActive } }));
        }
    });
    $("#settings-wallpaper-lock-list-input div").click(function() {
        let link = $("#settings-wallpaper-lock-list-input input").val();
        if(link.length > 0) {
            $("#phone-lock").css("background-image", "url(" + link + ")");
            $("#settings-wallpaper-lock-list .settings-wallpaper-list-item").removeClass("active");
            wallpaperLockActive = link;
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { wallpaperLock: wallpaperLockActive } }));
        }
    });
    for(let soundNotificationItem of config.soundnotification) {
        let divSoundNotification = "<div data-soundnotification='" + soundNotificationItem.title + "' class='settings-list-item'><div class='settings-list-item-left'><div class='settings-list-item-left-title'><span>" + soundNotificationItem.label + "</span></div></div><div class='settings-list-item-right'><div class='settings-list-item-right-button'><i class='fa-solid fa-check settings-list-item-right-button-check'></i></div></div></div>";
        $("#settings-list-sound-notification").append(divSoundNotification);
        let soundNotificationElement = $("#settings-list-sound-notification").children().last();
        if(soundNotificationItem.title == soundNotificationActive) {
            soundNotificationElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundnotification .settings-list-item-right-info span").html(soundNotificationItem.label);
            soundNotification = new Audio("assets/sounds/notifications/" + soundNotificationActive + ".mp3");
            soundNotification.volume = soundNotificationVolume / 10;
        }
        soundNotificationElement.click(function() {
            soundNotificationActive = $(this).attr("data-soundnotification");
            stopSounds();
            soundNotification = new Audio("assets/sounds/notifications/" + soundNotificationActive + ".mp3");
            soundNotification.volume = soundNotificationVolume / 10;
            $("#settings-list-sound-notification .settings-list-item-right-button-check").removeClass("active");
            soundNotificationElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundnotification .settings-list-item-right-info span").html(soundNotificationItem.label);
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { soundNotification: soundNotificationActive } }));
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
            soundRinging.volume = soundRingingVolume / 10;
        }
        soundRingingElement.click(function() {
            soundRingingActive = $(this).attr("data-soundringing");
            stopSounds();
            soundRinging = new Audio("assets/sounds/ringings/" + soundRingingActive + ".mp3");
            soundRinging.volume = soundRingingVolume / 10;
            $("#settings-list-sound-ringing .settings-list-item-right-button-check").removeClass("active");
            soundRingingElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundringing .settings-list-item-right-info span").html(soundRingingItem.label);
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { soundRinging: soundRingingActive } }));
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
            soundAlarm.volume = soundAlarmVolume / 10;
        }
        soundAlarmElement.click(function() {
            soundAlarmActive = $(this).attr("data-soundalarm");
            stopSounds();
            soundAlarm = new Audio("assets/sounds/alarms/" + soundAlarmActive + ".mp3");
            soundAlarm.volume = soundAlarmVolume / 10;
            $("#settings-list-sound-alarm .settings-list-item-right-button-check").removeClass("active");
            soundAlarmElement.find(".settings-list-item-right-button-check").addClass("active");
            $("#settings-list-item-soundalarm .settings-list-item-right-info span").html(soundAlarmItem.label);
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { soundAlarm: soundAlarmActive } }));
            soundAlarm.play();
        });
    }
    for(let e of document.querySelectorAll('input.settings-slider')) {
        if(e.id == "settings-slider-sound-notification") {
            e.style.setProperty('--value', soundNotificationVolume);
            e.value = soundNotificationVolume;
        } else if(e.id == "settings-slider-sound-ringing") {
            e.style.setProperty('--value', soundRingingVolume);
            e.value = soundRingingVolume;
        } else if(e.id == "settings-slider-sound-alarm") {
            e.style.setProperty('--value', soundAlarmVolume);
            e.value = soundAlarmVolume;
        }
        e.style.setProperty('--min', e.min == '' ? '0' : e.min);
        e.style.setProperty('--max', e.max == '' ? '100' : e.max);
        e.parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = e.value;
        e.addEventListener('input', () => {
            e.style.setProperty('--value', e.value);
            e.parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = e.value;
            if(e.id == "settings-slider-sound-notification") {
                soundNotificationVolume = e.value;
                soundNotification.volume = soundNotificationVolume / 10;
                $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { soundNotificationVolume: soundNotificationVolume } }));
            } else if(e.id == "settings-slider-sound-ringing") {
                soundRingingVolume = e.value;
                soundRinging.volume = soundRingingVolume / 10;
                $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { soundRingingVolume: soundRingingVolume } }));
            } else if(e.id == "settings-slider-sound-alarm") {
                soundAlarmVolume = e.value;
                soundAlarm.volume = soundAlarmVolume / 10;
                $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { soundAlarmVolume: soundAlarmVolume } }));
            }
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
            $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { zoom: generalZoomActive } }));
        });
    }
}

function initializeAppStore() {
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
}

function initializeAppClock() {
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
}

function initializeAppCalculator() {
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
        let OperatorStatus = false;
        let OperatorEqualStage = false;
        let historyReset = false;
        let NumberValue_first = 0;
        let NumberValue_secend = 0;
        let ScreenTotal = 0;
        let Operators = "";
        let PointLength_first = 0;
        let PointLength_secend = 0;
        let PointLengthMax = Math.max(PointLength_first, PointLength_secend);
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
}

function initializeAppRichterMotorsport() {
    $("#app-richtermotorsport-body-content-advertisement-search-reset").click(function() {
        $("#app-richtermotorsport-body-content-advertisement-search").val("");
        $(".richtermotorsport-list-item").css("display", "block");
    });
    $("#richtermotorsport-button-advertisement").click(function() {
        updateAppContent("advertisement");
    });
    $("#richtermotorsport-button-auction").click(function() {
        updateAppContent("auction");
    });
    $("#richtermotorsport-button-create").click(function() {
        $("#richtermotorsport-create-image-takephoto").show();
        $("#richtermotorsport-create-image-photo").hide();
        $("#richtermotorsport-create-image-photo").attr("src", "");
        updateAppContent("create");
    });
    $("#richtermotorsport-create-button-create").click(function() {
        let model = $("#richtermotorsport-create-input-model").val();
        let category = $("#richtermotorsport-create-select-category").val();
        let advertisementType = $("#richtermotorsport-create-select-advertisement-type").val();
        let image = ($("#richtermotorsport-create-image-photo").attr("src") != '' ? $("#richtermotorsport-create-image-photo").attr("src") : "null");
        let description = $("#richtermotorsport-create-textarea-description").val();
        let registration = $("#richtermotorsport-create-input-registration").val();
        let price = $("#richtermotorsport-create-input-price").val();
        if(model.length > 0 && description.length > 0 && registration.length > 0 && price.length > 0 && category != "choice" && advertisementType != "choice" && image != "null") {
            $.post('https://OraPhone/richtermotorsport_add_advertisement', JSON.stringify({ phoneId: userData.phone.id, image: image, model: model, category: category, advertisementType: advertisementType, description: description, registration: registration, price: price }));
            updateAppContent("home");
        }
    });
    $("#richtermotorsport-detail-favorite").click(function() {
        $.post('https://OraPhone/richtermotorsport_favorite_advertisement', JSON.stringify({ phoneId: userData.phone.id, advertisementId: RichterMotorSportCurrentAdvertisement.id, favorite: !RichterMotorSportCurrentAdvertisement.favorite }));
        if(!RichterMotorSportCurrentAdvertisement.favorite) {
            $("#richtermotorsport-detail-favorite").removeClass("fa-regular");
            $("#richtermotorsport-detail-favorite").addClass("fa-solid");
        } else {
            $("#richtermotorsport-detail-favorite").removeClass("fa-solid");
            $("#richtermotorsport-detail-favorite").addClass("fa-regular");
        }
        for(let advertisement of userData.richterMotorsportAdvertisement.advertisement) {
            if(advertisement.id == RichterMotorSportCurrentAdvertisement.id) {
                advertisement.favorite = !advertisement.favorite;
                break;
            }
        }
    });
    $("#richtermotorsport-create-image-takephoto").click(function() {
        activateAppCamera("richtermotorsport", "create");
    });
}

function initializeAppCamera() {
    $("#image-fullscreen").click(function() {
        document.getElementById("image-fullscreen").style.display = "none";
    });
    $("#camera-image").click(function() {
        $("#image-fullscreen img").attr("src", $(this).attr("src"));
        document.getElementById("image-fullscreen").style.display = "block";
    });
}

function initializeAppNotes() {
    $("#notes-folder-button-add").click(function() {
        let newDiv = `<div class="notes-list-item">
            <div class="notes-list-item-left">
                <i class="fa-regular fa-folder-closed notes-list-item-icon"></i>
                <input type="text" class="notes-list-item-title" disabled value="Nouveau dossier"/>
            </div>
            <div class="notes-list-item-right">
                <span class="notes-list-item-count">0</span>
                <i class="fa-solid fa-angle-right notes-list-item-arrow"></i>
            </div>
        </div>`;
        $("#notes-list-folders").append(newDiv);
        $("#notes-list-folders").children().last().click(function() {
            console.log(this);
            console.log($(this));
            updateAppContent("folder");
        });
        notesFolderContextMenu.updateTargetNode();
        $.post('https://OraPhone/notes_add_folder', JSON.stringify({ phoneId: userData.phone.id, name: "Nouveau dossier" }));
    });
    $("#notes-folder-note-button-add").click(function() {
        let newDiv = `<div class="notes-list-item">
            <span class="notes-list-item-title">Note #1</span>
            <span class="notes-list-item-date">16:29</span>
            <div class="notes-list-item-bottom">
                <i class="fa-regular fa-folder-closed notes-list-item-icon"></i>
                <span class="notes-list-item-folder">Notes rapides</span>
            </div>
        </div> `;
        $("#notes-list-notes").append(newDiv);
        $("#notes-list-notes").children().last().click(function() {
            updateAppContent("note");
        });
        notesNoteContextMenu.updateTargetNode();
    });
    const notesFolderMenuItems = [
        {
            content: `${renameIcon}Renommer le dossier`,
            events: {
                click: () =>  renameNotesFolder()
            }
        },
        {
            content: `${deleteIcon}Supprimer le dossier`,
            events: {
                click: () => removeNotesFolder()
            },
            divider: "top",
            class: "delete"
        },
    ];
    const notesNoteMenuItems = [
        {
            content: `${deleteIcon}Supprimer la note`,
            events: {
                click: () => removeNotesNote()
            },
            class: "delete"
        },
    ];
    notesFolderContextMenu = new ContextMenu({
        target: "#notes-list-folders .notes-list-item:not(.disabled)",
        menuItems: notesFolderMenuItems
    });
    notesNoteContextMenu = new ContextMenu({
        target: "#notes-list-notes .notes-list-item:not(.disabled)",
        menuItems: notesNoteMenuItems
    });
    notesFolderContextMenu.init();
    notesNoteContextMenu.init();
    $("#app-notes-body-content-folder-search-reset").click(function() {
        $("#app-notes-body-content-folder-search").val("");
        $(".notes-list-item").css("display", "flex");
    });
    // Inisialisation de la recherche de notes
    let searchInput = document.getElementById("app-notes-body-content-folder-search");
    searchInput.addEventListener('input', (e) => {
        for(let elt of document.querySelectorAll("#notes-list-notes .notes-list-item")) {
            if(elt.querySelector(".notes-list-item-title").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "flex";
            } else {
                elt.style.display = "none";
            }
        }
    });
    $("#notes-note-content").on("input", function() {
        this.style.height = 0;
        this.style.height = (this.scrollHeight) + "px";
    });
    $("#notes-checklist-button-add").click(function() {
        $("#notes-note-content").val($("#notes-note-content").val() + "\n- [ ] ");
    });
    $("#notes-note-button-edit").click(function() {
        updateNotesNoteContent();
    });
}

function initializeAppGallery() {
    $("#gallery-image").click(function () {
        $("#image-fullscreen img").attr("src", $("#gallery-image").attr("src"));
        document.getElementById("image-fullscreen").style.display = "block";
    });
    $("#gallery-image-button-remove").click(function () {
        updateAppContent("list");
        $.post('https://OraPhone/gallery_image_remove', JSON.stringify({ phoneId: userData.phone.id, id: $("#gallery-image").data("id") }));
    })
}

function initializeAppMaps() {
    const center_x = 117.3;
    const center_y = 172.8;
    const scale_x = 0.02072;
    const scale_y = 0.0205;
    const southWest = new L.LatLng(-4050, 6680);
    const northEast = new L.LatLng(8429.268292682927, -5650);

    let CUSTOM_CRS = L.extend({}, L.CRS.Simple, {
        projection: L.Projection.LonLat,
        scale: function(zoom) {
            return Math.pow(2, zoom);
        },
        zoom: function(sc) {
            return Math.log(sc) / 0.6931471805599453;
        },
        distance: function(pos1, pos2) {
            let x_difference = pos2.lng - pos1.lng; 
            let y_difference = pos2.lat - pos1.lat;
            return Math.sqrt(x_difference * x_difference + y_difference * y_difference);
        },
        transformation: new L.Transformation(scale_x, center_x, -scale_y, center_y),
        infinite: true
    });
    let AtlasStyle = L.tileLayer('assets/images/apps/maps/mapStyles/styleAtlas/{z}/{x}/{y}.jpg', {minZoom: 0, maxZoom: 5, noWrap: true, continuousWorld: false, attribution: 'Online map GTA V', id: 'styleAtlas map', bounds: [northEast, southWest]});
    map = L.map('map', {
        crs: CUSTOM_CRS,
        minZoom: 2,
        maxZoom: 5,
        Zoom: 5,
        zoomSnap: 0.25,
        dragging: true,
        maxNativeZoom: 5,
        preferCanvas: true,
        layers: AtlasStyle,
        attributionControl: false,
        center: [0, 0],
        zoom: 3,
        zoomControl: false
    });
    bounds = L.latLngBounds([northEast,southWest]);
    map.setMaxBounds(bounds);
    map.fitBounds(bounds);
    map.on('drag', function() {
        map.panInsideBounds(bounds, { animate: false });
    }); 

    markerMyPosition = L.marker([0, 0], {icon: customIcon("6")}).addTo(map).bindPopup("Ma position");

    for (let blip of Blips) {
        let marker = L.marker([blip.Pos.y, blip.Pos.x], {icon: customIcon(blip.sprite), riseOnHover: true}).addTo(map).bindPopup(blip.name);
        marker.on("click", function() {
            map.setView([blip.Pos.y, blip.Pos.x], 4);
        });
    }

    $("#map-tool-button").click(function() {
        $("#map-tool-container").toggleClass("active");
    });
    $("#map-tool-container-button-remove-marker").click(function() {
        $("#map-tool-container").removeClass("active");
        for (let marker of markerList) {
            map.removeLayer(marker);
        }
    });
    $("#map-tool-container-button-add-marker").click(function() {
        $("#map-tool-container").removeClass("active");
        $("#map-add-marker-container").addClass("active");
    });
    $("#map-add-marker-container-button-cancel").click(function() {
        $("#map-add-marker-container").removeClass("active");
        $("#map-add-marker-container-name").val("");
        for (let icon of $("#map-add-marker-container-icon-list .map-add-marker-container-icon-list-item")) {
            if ($(icon).hasClass("active")) {
                $(icon).removeClass("active")
                break;
            }
        }
    });
    $("#map-add-marker-container-button-add").click(function() {
        let markerName = "Position";
        let markerIcon = "162";
        if ($("#map-add-marker-container-name").val() != "") {
            markerName = $("#map-add-marker-container-name").val();
        }
        for (let icon of $("#map-add-marker-container-icon-list .map-add-marker-container-icon-list-item")) {
            if ($(icon).hasClass("active")) {
                markerIcon = $(icon).data("id");
                break;
            }
        }
        $.post('https://OraPhone/maps_favorite_add_marker', JSON.stringify({ phoneId: userData.phone.id, name: markerName, icon: markerIcon }));
        $("#map-add-marker-container").removeClass("active");
    });
    for (let icon of markerIcons) {
        let newIcon = '<div data-id="' + icon + '" class="map-add-marker-container-icon-list-item"><img src="assets/images/apps/maps/marker-icons/' + icon + '.png"/></div>';
        $("#map-add-marker-container-icon-list").append(newIcon);
    }
    $("#map-add-marker-container-icon-list .map-add-marker-container-icon-list-item").click(function() {
        $("#map-add-marker-container-icon-list .map-add-marker-container-icon-list-item").removeClass("active");
        $(this).addClass("active");
    });
}

function updateNotesNoteContent() {
    $("#notes-note-content").toggle();
    $("#notes-note-container").toggle();
    notesNoteInputToggle = !notesNoteInputToggle;
    if(notesNoteInputToggle) {
        $("#notes-note-content").focus();
    } else {
        $("#notes-note-container").empty();
        let lines = $("#notes-note-content").val().split("\n");
        let newContent = "";
        for(let line of lines) {
            if(line.startsWith("- [ ]")) {
                line = line.replace("- [ ]", "<li><input type='checkbox' class='notes-checklist-item-checkbox unchecked'/><span class='notes-checklist-item-text'>");
                line += "</span></li>";
            } else if(line.startsWith("- [x]")) {
                line = line.replace("- [x]", "<li><input type='checkbox' class='notes-checklist-item-checkbox checked' checked/><span class='notes-checklist-item-text'>");
                line += "</span></li>";
            }
            newContent += line + "<br/>";
        }
        $("#notes-note-container").empty();
        $("#notes-note-container").append(newContent);
        $("#notes-note-container input").on("input", function() {
            let find = "";
            let replacement = "";
            let index = "";
            if(this.checked) {
                find = "- [ ]";
                replacement = "- [x]";
                index = $("#notes-note-content").val().split(find, $(".notes-checklist-item-checkbox.unchecked").index(this) + 1).join(find).length;
                $(this).removeClass("unchecked");
                $(this).addClass("checked");
            } else {
                find = "- [x]";
                replacement = "- [ ]";
                index = $("#notes-note-content").val().split(find, $(".notes-checklist-item-checkbox.checked").index(this) + 1).join(find).length;
                $(this).removeClass("checked");
                $(this).addClass("unchecked");
            }
            $("#notes-note-content").val($("#notes-note-content").val().substring(0, index) + replacement + $("#notes-note-content").val().substring(index + replacement.length));
        });
    }
}

function removeNotesFolder() {
    if(notesListItem) {
        notesListItem.disabled = true;
        notesListItem.classList.remove("active");
        notesListItem = false;
    }
    let folder = contextMenuItemClicked.target.closest(".notes-list-item");
    folder.remove();
    $.post('https://OraPhone/notes_remove_folder', JSON.stringify({ phoneId: userData.phone.id, name: "Nouveau dossier" }));
}

function renameNotesFolder() {
    if(notesListItem) {
        notesListItem.disabled = true;
        notesListItem.classList.remove("active");
        notesListItem = false;
    }
    let input = contextMenuItemClicked.target.closest(".notes-list-item").querySelector(".notes-list-item-title");
    input.disabled = false;
    input.focus();
    input.classList.add("active");
    notesListItem = input;
    
}

function removeNotesNote() {
    let note = contextMenuItemClicked.target.closest(".notes-list-item");
    note.remove();
}

// Mise à jour des applications

function updateAppContacts() {
    $("#contacts-list").empty();
    let divItem = "";
    for (let contact of userData.contacts) {
        if (!/^[a-zA-Z]/.test(contact.name.toLowerCase())) {
            divItem += "<div class='contacts-list-row-item'><div class='contacts-list-row-item-top'><div class='contacts-list-row-item-top-avatar " + (contact.avatar.includes("http") ? "url" : "") + "'><img draggable='false' src='" + (contact.avatar.includes("http") ? contact.avatar : folderContactsProfileIcon + contact.avatar + ".png") + "'/></div><div class='contacts-list-row-item-top-name'><span>" + contact.name + "</span></div></div><div class='contacts-list-row-item-bottom'><div data-number='" + contact.number + "' class='contacts-list-row-item-bottom-button message-contact'><i class='fa-solid fa-envelope'></i></div>" + (!/[a-zA-Z]/.test(contact.number) ? "<div data-number='" + contact.number + "' data-avatar='" + contact.avatar + "' class='contacts-list-row-item-bottom-button call-contact'><i class='fa-solid fa-phone'></i></div>" : "") + (!/[a-zA-Z]/.test(contact.number) ? "<div data-id='" + contact.id + "' data-number='" + contact.number + "' data-name='" + contact.name + "' data-avatar='" + contact.avatar + "' class='contacts-list-row-item-bottom-button edit-contact'><i class='fa-solid fa-pen-to-square'></i></div>" : "") + "</div></div>";
        }
    }
    if(divItem != "") {
        let divRow = "<div class='contacts-list-row'><div class='contacts-list-row-letter'><span>0-9</span></div>" + divItem + "</div>";
        $('#contacts-list').append(divRow);
    }
    for(let i = 65; i <= 90; i++) {
        divItem = "";
        for (let contact of userData.contacts) {
            if (contact.name.substring(0,1).toLowerCase() == String.fromCharCode(i).toLowerCase()) {
                divItem += "<div class='contacts-list-row-item'><div class='contacts-list-row-item-top'><div class='contacts-list-row-item-top-avatar " + (contact.avatar.includes("http") ? "url" : "") + "'><img draggable='false' src='" + (contact.avatar.includes("http") ? contact.avatar : folderContactsProfileIcon + contact.avatar + ".png") + "'/></div><div class='contacts-list-row-item-top-name'><span>" + contact.name + "</span></div></div><div class='contacts-list-row-item-bottom'><div data-number='" + contact.number + "' class='contacts-list-row-item-bottom-button message-contact'><i class='fa-solid fa-envelope'></i></div>" + (!/[a-zA-Z]/.test(contact.number) ? "<div data-number='" + contact.number + "' data-avatar='" + contact.avatar + "' class='contacts-list-row-item-bottom-button call-contact'><i class='fa-solid fa-phone'></i></div>" : "") + (!/[a-zA-Z]/.test(contact.number) ? "<div data-id='" + contact.id + "' data-number='" + contact.number + "' data-name='" + contact.name + "' data-avatar='" + contact.avatar + "' class='contacts-list-row-item-bottom-button edit-contact'><i class='fa-solid fa-pen-to-square'></i></div>" : "") + "</div></div>";
            }
        }
        if(divItem != "") {
            let divRow = "<div class='contacts-list-row'><div class='contacts-list-row-letter'><span>" + String.fromCharCode(i).toUpperCase() + "</span></div>" + divItem + "</div>";
            $('#contacts-list').append(divRow);
        }
    }
    // Inisialisation bouton de contacte
    $(".edit-contact").click(function() {
        contactId = $(this).data("id");
        contactPhoneNumber = $(this).data("number").toString().substring(3);
        contactName = $(this).data("name");
        contactAvatar = $(this).data("avatar");
        updateAppContent("editcontact");
        $("#editcontact-profile-icon").data("title", contactAvatar);
        if(contactAvatar.includes("http")) {
            $("#editcontact-profile-icon").addClass("url");
        } else {
            $("#editcontact-profile-icon").removeClass("url");
        }
        $("#editcontact-profile-icon img").attr("src", (contactAvatar.includes("http") ? contactAvatar : folderContactsProfileIcon + contactAvatar + ".png"));
        $("#editcontact-profile-name span").html(contactName);
        $("#editcontact-phone-number-input").val(contactPhoneNumber);
        $("#editcontact-name-input").val(contactName);
        if(contactAvatar.includes("http")) {
            $("#editcontact-icon-custom-input").val(contactAvatar);
        } else {
            $("#editcontact-icon-custom-input").val("");
        }
        $("#editcontact-icon-list").children().removeClass("active");
        for(let icon of document.querySelectorAll("#editcontact-icon-list .newcontact-icon-list-item")) {
            if(icon.dataset.title == contactAvatar) {
                icon.classList.add("active");
            }
        }
    });
    $(".call-contact").click(function() {
        callNumber($(this).data("number"));
    });
    $(".message-contact").click(function() {
        conversationAuthors = [];
        conversationAuthors.push($(this).data("number"));
        conversationAuthors.push(userData.phone.number);
        if(conversationAuthors.length < 2) {
            return;
        }
        $.post('https://OraPhone/message_create_conversation', JSON.stringify({ phoneId: userData.phone.id, number: userData.phone.number , authors: conversationAuthors }));
        updateAppMessageLoad();
        updateContent("message");
        updateAppContent("message");
        let elementMessages = document.querySelector(".app-message-conversation .messages");
        elementMessages.scroll({ top: elementMessages.scrollHeight, behavior: "instant"});
    });
    // Inisialisation de la liste de l'alphabet
    $("#contacts-list-alphabet span").click(function() {
        for(let item of document.querySelectorAll(".contacts-list-row-letter")) {
            if(item.querySelector("span").innerText.charAt(0).toLowerCase() == this.title.toLowerCase()) {
                document.getElementById("contacts-list").scrollTo({top: item.parentNode.offsetTop, behavior: 'smooth'});
                return;
            }
        }
    });
    // Inisialisation de la recherche de contactes
    let searchInput = document.getElementById("app-contacts-body-content-list-search");
    searchInput.addEventListener('input', (e) => {
        for(let elt of document.querySelectorAll(".contacts-list-row-item")) {
            if(elt.querySelector(".contacts-list-row-item-top-name span").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "block";
            } else {
                elt.style.display = "none";
            }
        }
    });
    // Inisialisation des événements sur les contactes
    $(".contacts-list-row-item-top").click(function () {
        if($(this.parentNode).hasClass("active")) {
            $(this.parentNode).removeClass("active");
        } else {
            $(".contacts-list-row-item").removeClass("active");
            $(this.parentNode).addClass("active");
        }
    });
}

function updateAppMessage() {
    $('#newmessage-list').empty();
    for(let contact of userData.contacts) {
        if(contact.number.toString().length == 7 && /555\d{4}/.test(contact.number.toString())) {
            let div = "<div data-number='" + contact.number + "' data-name='" + contact.name + "' class='newmessage-list-item'><div class='newmessage-list-item-left'><div class='newmessage-list-item-left-avatar " + (contact.avatar.includes("http") ? "url" : "") + "'><img draggable='false' src='" + (contact.avatar.includes("http") ? contact.avatar : folderContactsProfileIcon + contact.avatar + ".png") + "'/><i class='fa-solid fa-check'></i></div></div><div class='newmessage-list-item-right'><div class='newmessage-list-item-right-header'><span class='newmessage-list-item-right-header-name'>" + contact.name + "</span></div><div class='newmessage-list-item-right-body'><span class='newmessage-list-item-right-body-number'>" + "555-" + contact.number.toString().substring(3) + "</span><span style='display:none;'>" + contact.number.toString() + "</span></div></div></div>";
            $('#newmessage-list').append(div);
        }
    }
    $(".newmessage-list-item").click(function() {
        this.classList.toggle("active");
    });
    $("#newmessage-list-alphabet span").click(function() {
        for(let item of document.querySelectorAll(".newmessage-list-item")) {
            if(item.querySelector(".newmessage-list-item-right-header-name").innerText.charAt(0).toLowerCase() == this.title.toLowerCase()) {
                document.getElementById("newmessage-list").scrollTo({top: item.offsetTop, behavior: 'smooth'});
                return;
            }
        }
    });
    let searchInput = document.getElementById("app-message-body-content-newmessage-search");
    searchInput.value = "";
    searchInput.addEventListener('input', (e) => {
        for(let elt of document.querySelectorAll(".newmessage-list-item")) {
            if(elt.querySelector(".newmessage-list-item-right-header-name").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase()) || elt.querySelector(".newmessage-list-item-right-body-number").nextElementSibling.innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "flex";
            } else {
                elt.style.display = "none";
            }
        }
        if (/555\d{4}/.test(searchInput.value) && searchInput.value.length == 7) {
            let canCreate = true;
            for (let elt of document.querySelectorAll(".newmessage-list-item")) {
                if (elt.querySelector(".newmessage-list-item-right-body-number").nextElementSibling.innerHTML == searchInput.value) {
                    canCreate = false;
                    break;
                }
            }
            if (canCreate) {
                let div = "<div id='newmessage-list-item-newnumber' data-number='" + searchInput.value + "' data-name='" + searchInput.value + "' class='newmessage-list-item'><div class='newmessage-list-item-left'><div class='newmessage-list-item-left-avatar'><img draggable='false' src='" + contactAvatarDefault + "'/><i class='fa-solid fa-check'></i></div></div><div class='newmessage-list-item-right'><div class='newmessage-list-item-right-header'><span class='newmessage-list-item-right-header-name'>" + searchInput.value + "</span></div><div class='newmessage-list-item-right-body'><span class='newmessage-list-item-right-body-number'>" + "555-" + searchInput.value.toString().substring(3) + "</span><span style='display:none;'>" + searchInput.value.toString() + "</span></div></div></div>";
                $('#newmessage-list').append(div);
                $("#newmessage-list-item-newnumber").click(function() {
                    this.classList.toggle("active");
                });
            } else if ($("#newmessage-list-item-newnumber")) {
                $("#newmessage-list-item-newnumber").remove();
            }
        } else {
            if ($("#newmessage-list-item-newnumber")) {
                $("#newmessage-list-item-newnumber").remove();
            }
        }
    });
}

function updateConversationList() {
    $("#message-list").empty();
    let conversationNotReadCount = 0;
    for (let conversation of userData.conversations) {
        let conversationName = "";
        let conversationTime = "";
        let conversationMessage = "";
        let conversationAvatar = contactAvatarDefault;
        let conversationIsRead = true;
        if (conversation.messages != "") {
            conversationTime = new Date(conversation.messages[conversation.messages.length - 1].msgTime).toLocaleString('fr-FR', { timeStyle: 'short' });
            conversationMessage = conversation.messages[conversation.messages.length - 1].message;
        }
        for (let user of JSON.parse(conversation.target_number)) {
            if (user.number != userData.phone.number) {
                let name = user.number;
                for (let contact of userData.contacts) {
                    if (user.number != undefined || user.number != null) {
                        if (contact.number.toString() == user.number.toString()) {
                            if (JSON.parse(conversation.target_number).length == 2) {
                                if (contact.avatar.includes("http")) {
                                    conversationAvatar = contact.avatar;
                                } else {
                                    conversationAvatar = folderContactsProfileIcon + contact.avatar + ".png";
                                }
                            }
                            name = contact.name;
                            break;
                        }
                    }
                }
                conversationName += name + ", ";
            } else if (!user.isRead) {
                conversationIsRead = false;
                conversationNotReadCount += 1;
            }
        }
        conversationName = conversationName.slice(0, -2);
        if (conversation.name != null) {
            conversationName = conversation.name;
        }
        let divConversation = "<div class='app-body-content-body-list-item'><div class='message-list-item-left'><div class='message-list-item-left-avatar " + (conversationAvatar.includes('http') ? "url" : "") + "'><img src='" + conversationAvatar + "' /></div>" + (!conversationIsRead ? "<div class='message-list-item-left-notread'>1</div>" : "") + "</div><div class='message-list-item-right'><div class='message-list-item-right-header'><div class='message-list-item-right-header-name'><span>" + conversationName + "</span></div><div class='message-list-item-right-header-date'><span>" + conversationTime + "</span><i class='fa-solid fa-chevron-right'></i></div></div><div class='message-list-item-right-body'><div class='message-list-item-right-body-text'><span>" + conversationMessage + "</span></div></div></div></div>";
        $("#message-list").append(divConversation);
        $("#message-list").children().last().click(function () {
            updateAppMessageLoad(conversation.id);
            updateAppContent("message");
            let elementMessages = document.querySelector(".app-message-conversation .messages");
            elementMessages.scroll({ top: elementMessages.scrollHeight, behavior: "instant"});
        });
    }
    if(conversationNotReadCount > 0) {
        if ($("#app-home-list-item-message .app-home-list-item-notread")) {
            $("#app-home-list-item-message .app-home-list-item-notread").remove();
        }
        $("#app-home-list-item-message").append("<div class='app-home-list-item-notread'>" + conversationNotReadCount + "</div>");
    } else if ($("#app-home-list-item-message .app-home-list-item-notread")) {
        $("#app-home-list-item-message .app-home-list-item-notread").remove();
    }
    let searchInput = document.getElementById("app-message-body-content-list-search");
    searchInput.value = "";
    searchInput.addEventListener('input', (e) => {
        for(let elt of document.querySelectorAll("#message-list .app-body-content-body-list-item")) {
            if(elt.querySelector(".message-list-item-right-header-name span").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "flex";
            } else {
                elt.style.display = "none";
            }
        }
    });
}

function updateAppMessageLoad(id = null) {
    if((id == '' || id == null) && conversationAuthors != '') {
        // Get conversationId from authors list
        for(let conversation of userData.conversations) {
            let targetNumbers = [];
            JSON.parse(conversation.target_number).map(targetNumber => {
                targetNumbers.push(targetNumber.number);
            });
            if(conversationAuthors.every(i => targetNumbers.includes(i)) && conversationAuthors.length == targetNumbers.length) {
                conversationId = conversation.id;
                break;
            }
        }
        conversationAuthors = '';
    } else {
        conversationId = id;
    }
    if(conversationId != "") {
        messageTargetNumber = "";
        $('.app-message-conversation .messages').data("conversation-id", conversationId);
        $('.app-message-conversation .messages').empty();
        for(let conversation of userData.conversations) {
            if(conversation.id == conversationId) {
                let conversationAvatar = contactAvatarDefault;
                let conversationName = "";
                messageTargetNumber = JSON.parse(conversation.target_number);
                if (messageTargetNumber.length > 2) {
                    $("#message-header-button-edit").show();
                } else {
                    $("#message-header-button-edit").hide();
                }
                for(let user of JSON.parse(conversation.target_number)) {
                    if(user.number != userData.phone.number) {
                        let name = user.number;
                        for(let contact of userData.contacts) {
                            if(contact.number == user.number) {
                                if(JSON.parse(conversation.target_number).length == 2) {
                                    if(contact.avatar.includes("http")) {
                                        conversationAvatar = contact.avatar;
                                    } else {
                                        conversationAvatar = folderContactsProfileIcon + contact.avatar + ".png";
                                    }
                                }
                                name = contact.name;
                                break;
                            }
                        }
                        conversationName += name + ", ";
                    } else {
                        if (!user.isRead) {
                            $.post('https://OraPhone/message_update_read_conversation', JSON.stringify({ id: conversation.id, number: userData.phone.number }));
                        }
                    }
                }
                conversationName = conversationName.slice(0, -2);
                if (conversation.name != null) {
                    conversationName = conversation.name;
                }
                if(conversationAvatar.includes("http")) {
                    $(".app-body-content-header-profil-avatar").addClass("url");
                } else {
                    $(".app-body-content-header-profil-avatar").removeClass("url");
                }
                $(".app-body-content-header-profil-avatar img").attr("src", conversationAvatar);
                $(".app-body-content-header-profil-name span").html(conversationName);
                for(let message of conversation.messages) {
                    let sourceName = "";
                    let sourceType = "";
                    let sourceDateTime = new Date(message.msgTime).toLocaleString('fr-FR', { dateStyle: 'short', timeStyle: 'medium' });
                    if(message.sourceNumber == userData.phone.number) {
                        sourceName = "Moi";
                        sourceType = "me";
                    } else {
                        sourceName = message.sourceNumber;
                        sourceType = "you";
                        for(let contact of userData.contacts) {
                            if(contact.number == message.sourceNumber) {
                                sourceName = contact.name;
                            }
                        }
                    }
                    responsiveChatPush(sourceName, sourceType, sourceDateTime, message.message);
                }
                break;
            }
        }
        let messageInput = $("#app-message-footer-input");
        messageInput.on("keyup", function(e) {
            if (e.key === 'Enter' || e.keyCode === 13) {
                if (messageInput.val() != "") {
                    let sourceDateTime = new Date().toLocaleString('fr-FR', { dateStyle: 'short', timeStyle: 'medium' });
                    responsiveChatPush("Moi", "me", sourceDateTime, messageInput.val());
                    let elementMessages = document.querySelector(".app-message-conversation .messages");
                    elementMessages.scroll({ top: elementMessages.scrollHeight, behavior: "instant"});
                    $.post('https://OraPhone/add_message', JSON.stringify({ phoneId: userData.phone.id, targetNumber: messageTargetNumber, number: userData.phone.number, conversationId: conversationId, message: messageInput.val() }));
                    messageInput.val("");
                }
            }
        });
        $("#message-photo-button-takephoto").click(function () {
            activateAppCamera("message", "message");
        });
        $("#message-photo-button-gallery").click(function () {
            updateContent("gallery");
            $("#gallery-image-list .gallery-image-list-item").addClass("bind-click");
            $("#gallery-image-list .gallery-image-list-item").bind("click", messageChooseImageGallery);
        });
        let elementMessages = document.querySelector(".app-message-conversation .messages");
        elementMessages.scroll({ top: elementMessages.scrollHeight, behavior: "instant"});
    }
}

function updateAppPhone() {
    $("#phonehistory-list").empty();
    for(let call of userData.calls) {
        let callTarget = "";
        let callSource = false;
        let callDuration = "";
        if(call.source_number == phoneNumber) {
            callSource = true;
            callTarget = call.target_number.toString();
        } else {
            callTarget = call.source_number.toString();
        }
        let callContactNumber = callTarget.length == 7 ? "555-" + callTarget.substring(3) : callTarget;
        let callName = callContactNumber;
        for(let contact of userData.contacts) {
            if(contact.number.toString() == callTarget.toString()) {
                callName = contact.name;
                break;
            }
        }
        let callAccepted = call.accepted;
        let callTime = new Date(call.call_time);
        let nowTime = new Date();
        if(callTime.toDateString() == nowTime.toDateString()) {
            callTime = callTime.toLocaleString('fr-FR', { timeStyle: 'short' });
        } else {
            let yesterday = new Date();
            yesterday.setDate(nowTime.getDate() - 1);
            if(callTime.toDateString() == yesterday.toDateString()) {
                callTime = "Hier";
            } else {
                let tmp = Math.ceil(Math.abs(nowTime - callTime) / (1000 * 60 * 60 * 24));
                if(tmp <= 7) {
                    callTime = callTime.toLocaleString('fr-FR', { weekday: 'long' });
                    callTime = callTime.charAt(0).toUpperCase() + callTime.slice(1);
                } else {
                    callTime = callTime.toLocaleString('fr-FR', { dateStyle: 'short' });
                }
            }
        }
        if(callAccepted) {
            let minutes = Math.floor(call.call_duration / 60);
            let seconds = call.call_duration - minutes * 60;
            callDuration = (minutes < 10 ? "0" + minutes : minutes)+ ":" + (seconds < 10 ? "0" + seconds : seconds);
        } else {
            callDuration = "Manqué";
        }

        let divCall = "<div class='phonehistory-list-item " + (callAccepted ? '' : 'miss') + "'><div class='phonehistory-list-item-left'><div class='phonehistory-list-item-type'><i class='fa-solid fa-phone'></i><i class='fa-solid fa-turn-" + (callSource ? 'up' : 'down') + "'></i></div><div class='phonehistory-list-item-body'><span class='phonehistory-list-item-body-name'>" + callName + "</span><span class='phonehistory-list-item-body-number'>" + callContactNumber + "</span></div></div><div class='phonehistory-list-item-time'><span>" + callTime + "</span></div><div class='phonehistory-list-item-duration'><span>" + callDuration + "</span></div></div>";
        $("#phonehistory-list").append(divCall);
        $("#phonehistory-list").children().last().click(function () {
            callNumber(callTarget);
        });
    }
}

function updateAppRichterMotorsport() {
    $("#richtermotorsport-list-favorite").empty();
    $("#richtermotorsport-list-advertisement").empty();
    $("#richtermotorsport-list-auction").empty();
    for(let advertisement of userData.richterMotorsportAdvertisement.advertisement) {
        let favorite = userData.richterMotorsportAdvertisement.favorite.find( favorite => favorite.advertisementId == advertisement.id);
        advertisement.favorite = (favorite ? true : false);
        let divItem = "";
        if(advertisement.advertisementType == "vente") {
            divItem = "<div data-id='" + advertisement.id + "' class='richtermotorsport-list-item'><div class='richtermotorsport-list-item-image'><img src='" + advertisement.imgUrl + "'/></div><div class='richtermotorsport-list-item-description'><div><span class='richtermotorsport-list-item-description-title'>" + advertisement.model + "</span>" + (advertisement.favorite ? "<i class='fa-solid fa-heart richtermotorsport-list-item-description-favorite'></i>" : "<i class='fa-regular fa-heart richtermotorsport-list-item-description-favorite'></i>") + "</div><div><span class='richtermotorsport-list-item-description-category'>" + advertisement.category + "</span><span class='richtermotorsport-list-item-description-price'>$ " + numberWithSpaces(advertisement.price) + "</span></div></div></div></div>";
            $("#richtermotorsport-list-advertisement").append(divItem);
        } else if(advertisement.advertisementType == "enchère") {
            divItem = "<div data-id='" + advertisement.id + "' class='richtermotorsport-list-item'><div class='richtermotorsport-list-item-image'><img src='" + advertisement.imgUrl + "'/></div><div class='richtermotorsport-list-item-description'><div><span class='richtermotorsport-list-item-description-title'>" + advertisement.model + "</span>" + (advertisement.favorite ? "<i class='fa-solid fa-heart richtermotorsport-list-item-description-favorite'></i>" : "<i class='fa-regular fa-heart richtermotorsport-list-item-description-favorite'></i>") + "</div><div><span class='richtermotorsport-list-item-description-category'>" + advertisement.category + "</span><span class='richtermotorsport-list-item-description-price'><span>A partir de </span>$ " + numberWithSpaces(advertisement.price) + "</span></div></div></div></div>";
            $("#richtermotorsport-list-auction").append(divItem);
        }
        if(advertisement.favorite) {
            $("#richtermotorsport-list-favorite").append(divItem);
        }
    }
    if($("#richtermotorsport-list-favorite").children().length == 0) {
        $("#richtermotorsport-list-favorite").append("<span class='richtermotorsport-no-favorite'>Aucun favoris</span>");
        $("#richtermotorsport-list-favorite").css("min-width", "100%");
    } else {
        $("#richtermotorsport-list-favorite").css("min-width", "auto");
    }
    $(".richtermotorsport-list-item").click(function() {
        let id = $(this).attr("data-id");
        let advertisement = userData.richterMotorsportAdvertisement.advertisement.find( advertisement => advertisement.id == id);
        $("#richtermotorsport-detail-model").html(advertisement.model);
        $("#richtermotorsport-detail-category").html(advertisement.category);
        if(advertisement.favorite) {
            $("#richtermotorsport-detail-favorite").removeClass("fa-regular");
            $("#richtermotorsport-detail-favorite").addClass("fa-solid");
        } else {
            $("#richtermotorsport-detail-favorite").removeClass("fa-solid");
            $("#richtermotorsport-detail-favorite").addClass("fa-regular");
        }
        $(".richtermotorsport-detail-image img").attr("src", advertisement.imgUrl);
        $("#richtermotorsport-detail-description").html(advertisement.description);
        $("#richtermotorsport-detail-registration").html(advertisement.registration);
        $("#richtermotorsport-detail-price").html("$ " + numberWithSpaces(advertisement.price));
        RichterMotorSportCurrentAdvertisement = advertisement;
        updateAppContent("detail");
    });
    let searchInput = document.getElementById("app-richtermotorsport-body-content-advertisement-search");
    searchInput.addEventListener('input', (e) => {
        for(let elt of document.querySelectorAll(".richtermotorsport-list-item")) {
            if(elt.querySelector(".richtermotorsport-list-item-description-title").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "block";
            } else {
                elt.style.display = "none";
            }
        }
    });
}

function updateAppNotes() {
    $("#notes-list-folders").empty();
    for(let folder of userData.notes) {
        let newDivFolder = `<div data-id="` + folder.id + `" class="notes-list-item">
            <div class="notes-list-item-left">
                <i class="fa-regular fa-folder-closed notes-list-item-icon"></i>
                <input type="text" class="notes-list-item-title" disabled value="` + folder.name + `"/>
            </div>
            <div class="notes-list-item-right">
                <span class="notes-list-item-count">` + folder.notes.length + `</span>
                <i class="fa-solid fa-angle-right notes-list-item-arrow"></i>
            </div>
        </div>`;
        $("#notes-list-folders").append(newDivFolder);
        notesFolderContextMenu.updateTargetNode();
    }
    $("#notes-list-folders .notes-list-item").click(function() {
        updateNotesFolderLoad($(this).data("id"));
        updateAppContent("folder");
    });
}

function updateNotesFolderLoad(id) {
    let folder = userData.notes.find( folder => folder.id == id);
    $("#notes-list-notes").empty();
    for(let note of folder.notes) {
        let noteDate = new Date(note.updateTime);
        let newDivNote = `<div data-folderid="` + note.folderId + `" data-id="` + note.id + `" class="notes-list-item">
                <span class="notes-list-item-title">` + note.name + `</span>
                <span class="notes-list-item-date">` + noteDate.getHours() + ":" + noteDate.getMinutes() + `</span>
            <div class="notes-list-item-bottom">
                <i class="fa-regular fa-folder-closed notes-list-item-icon"></i>
                <span class="notes-list-item-folder">` + folder.name + `</span>
            </div>
        </div> `;
        $("#notes-list-notes").append(newDivNote);
    }
    $("#notes-list-notes .notes-list-item").click(function() {
        updateNotesNoteLoad($(this).data("folderid"), $(this).data("id"));
        updateAppContent("note");
    });
    notesNoteContextMenu.updateTargetNode();
}

function updateNotesNoteLoad(folderId, id) {
    let folder = userData.notes.find( folder => folder.id == folderId);
    let note = folder.notes.find( note => note.id == id);
    $("#notes-note-title").val(note.name);
    $("#notes-note-content").val(note.content);
}

function updateAppGallery() {
    $("#gallery-image-list").empty();
    for(let image of userData.galleryPhoto) {
        let divImage = "<div data-id='" + image.id + "' class='gallery-image-list-item'><img src='" + image.imageLink + "'/></div>";
        $("#gallery-image-list").append(divImage);
        $("#gallery-image-list").children().last().click(function() {
            $("#gallery-image").attr("src", image.imageLink);
            $("#gallery-image").data("id", image.id);
            updateAppContent("image");
        });
    }
}

function updateAppMaps() {
    for (let marker of markerFavoriteList) {
        map.removeLayer(marker);
    }
    markerFavoriteList = [];
    for (let favorite of userData.mapsFavorite) {
        let popupText = favorite.name + `<br/><i onclick="mapsFavoriteRemove('` + favorite.id + `')" class="fa-solid fa-trash-can maps-marker-button-remove"></i>`;
        let marker = L.marker([favorite.y, favorite.x], {icon: customIcon(favorite.icon)}).addTo(map).bindPopup(popupText);
        marker.on("click", function() {
            map.setView([favorite.y, favorite.x], 4);
        });
        favorite.marker = marker;
        markerFavoriteList.push(marker);
    }
}

// Activer les applications

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

function activateAppRichterMotorsport() {
    $.post('https://OraPhone/richtermotorsport_find_job', JSON.stringify({ phoneId: userData.phone.id }));
}

function activateAppCamera(app, appSub) {
    $.post('https://OraPhone/open_camera', JSON.stringify({ app, appSub }));
    const canvas = document.getElementById("videocall-canvas");
    MainRender.renderToTarget(canvas);
}

// Application paramètre

function updateZoom() {
    $("#settings-list-general-zoom .settings-list-item-right-button-check").removeClass("active");
    for(let generalZoomItem of config.generalzoom) {
        if(generalZoomItem.title == generalZoomActive) {
            $("#settings-list-item-generalzoom .settings-list-item-right-info span").html(generalZoomItem.label);
            generalZoom = generalZoomItem.value + "%";
        }
    }
    for(let generalZoomItem of document.querySelectorAll("#settings-list-general-zoom .settings-list-item")) {
        if(generalZoomItem.dataset.generalzoom == generalZoomActive) {
            generalZoomItem.querySelector(".settings-list-item-right-button-check").classList.add("active");
        }
    }
    $("#phone").css("zoom", generalZoom);
}

function updateProfile() {
    $(".settings-profile-full-name").html(firstName + " " + lastName);
    $("#settings-profile-serial-number").html(serialNumber);
    $("#settings-profile-first-name").html(firstName);
    $("#settings-profile-last-name").html(lastName);
    $("#settings-profile-number").html("555-" + phoneNumber.toString().substring(3));
}

function updateDarkMode() {
    if(darkMode) {
        $("body").addClass("theme--dark");
        $("body").removeClass("theme--default");
        $("#topbar-box-button-update-thememode").addClass("active");
        $("#settings-list-item-thememode label input").prop("checked", true);
    } else {
        $("body").addClass("theme--default");
        $("body").removeClass("theme--dark");
        $("#topbar-box-button-update-thememode").removeClass("active");
        $("#settings-list-item-thememode label input").prop("checked", false);
    }
}

function updateLuminosity() {
    let slider = document.getElementById("topbar-box-button-slider-luminosity");
    slider.value = luminosityActive;
    slider.style.setProperty('--value', luminosityActive);
    slider.style.setProperty('--min', slider.min == '' ? '10' : slider.min);
    slider.style.setProperty('--max', slider.max == '' ? '100' : slider.max);
    $("#phone-screen").css("filter", "brightness(" + (slider.value) + "%)");
    slider.addEventListener('input', () => {
        slider.style.setProperty('--value', slider.value);
        $("#phone-screen").css("filter", "brightness(" + (slider.value) + "%)");
        luminosityActive = slider.value;
        $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { luminosity: luminosityActive } }));
    });
}

function updateVolume() {
    let slider = document.getElementById("topbar-box-button-slider-volume");
    slider.value = volumeActive;
    slider.style.setProperty('--value', volumeActive);
    slider.style.setProperty('--min', slider.min == '' ? '0' : slider.min);
    slider.style.setProperty('--max', slider.max == '' ? '100' : slider.max);
    slider.addEventListener('input', () => {
        slider.style.setProperty('--value', slider.value);
        volumeActive = slider.value;
    });
}

function updateWallpaper() {
    let wallpaperElement = false;
    let wallpaperLockElement = false;
    $(".settings-wallpaper-list-item").removeClass("active");
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
    if(wallpaperElement) {
        for(let wallpaper of document.querySelectorAll("#settings-wallpaper-list .settings-wallpaper-list-item")) {
            if(wallpaper.dataset.wallpaper == wallpaperActive) {
                wallpaper.classList.add("active");
            }
        }
    } else if(wallpaperActive.length > 0) {
        $("#phone-screen").css("background-image", "url(" + wallpaperActive + ")");
    }
    if(wallpaperLockElement) {
        for(let wallpaper of document.querySelectorAll("#settings-wallpaper-lock-list .settings-wallpaper-list-item")) {
            if(wallpaper.dataset.wallpaper == wallpaperLockActive) {
                wallpaper.classList.add("active");
            }
        }
    } else if(wallpaperLockActive.length > 0) {
        $("#phone-screen").css("background-image", "url(" + wallpaperLockActive + ")");
    }
}

function updateSound() {
    soundNotification = new Audio(folderNotifications + soundNotificationActive + ".mp3");
    soundNotification.volume = soundNotificationVolume / 10;
    for(let soundNotificationItem of document.querySelectorAll("#settings-list-sound-notification .settings-list-item")) {
        let buttonCheck = soundNotificationItem.querySelector(".settings-list-item-right-button-check");
        if(buttonCheck.classList.contains("active")) {
            buttonCheck.classList.remove("active");
        }
        if(soundNotificationItem.dataset.soundnotification == soundNotificationActive) {
            buttonCheck.classList.add("active");
            $("#settings-list-item-soundnotification .settings-list-item-right-info span").html(soundNotificationItem.querySelector(".settings-list-item-left-title span").innerHTML);
        }
    }
    soundRinging = new Audio(folderRingings + soundRingingActive + ".mp3");
    soundRinging.volume = soundRingingVolume / 10;
    for(let soundRingingItem of document.querySelectorAll("#settings-list-sound-ringing .settings-list-item")) {
        let buttonCheck = soundRingingItem.querySelector(".settings-list-item-right-button-check");
        if(buttonCheck.classList.contains("active")) {
            buttonCheck.classList.remove("active");
        }
        if(soundRingingItem.dataset.soundringing == soundRingingActive) {
            buttonCheck.classList.add("active");
            $("#settings-list-item-soundringing .settings-list-item-right-info span").html(soundRingingItem.querySelector(".settings-list-item-left-title span").innerHTML);
        }
    }
    soundAlarm = new Audio(folderAlarms + soundAlarmActive + ".mp3");
    soundAlarm.volume = soundAlarmVolume / 10;
    for(let soundAlarmItem of document.querySelectorAll("#settings-list-sound-alarm .settings-list-item")) {
        let buttonCheck = soundAlarmItem.querySelector(".settings-list-item-right-button-check");
        if(buttonCheck.classList.contains("active")) {
            buttonCheck.classList.remove("active");
        }
        if(soundAlarmItem.dataset.soundalarm == soundRingingActive) {
            buttonCheck.classList.add("active");
            $("#settings-list-item-soundalarm .settings-list-item-right-info span").html(soundAlarmItem.querySelector(".settings-list-item-left-title span").innerHTML);
        }
    }
    soundCallWait = new Audio(folderSounds + "sound-call-wait.mp3");
    soundCallWait.volume = 0.5;

    document.getElementById("settings-slider-sound-notification").style.setProperty('--value', soundNotificationVolume);
    document.getElementById("settings-slider-sound-notification").value = soundNotificationVolume;
    document.getElementById("settings-slider-sound-notification").parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = soundNotificationVolume;
    document.getElementById("settings-slider-sound-ringing").style.setProperty('--value', soundRingingVolume);
    document.getElementById("settings-slider-sound-ringing").value = soundRingingVolume;
    document.getElementById("settings-slider-sound-ringing").parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = soundRingingVolume;
    document.getElementById("settings-slider-sound-alarm").style.setProperty('--value', soundAlarmVolume);
    document.getElementById("settings-slider-sound-alarm").value = soundAlarmVolume;
    document.getElementById("settings-slider-sound-alarm").parentNode.parentNode.querySelector('.settings-list-item-top-right-amount').innerHTML = soundAlarmVolume;
}

function updateAppHomeOrder() {
    // Création de la liste des applications
    userData.phone.appHomeOrder = JSON.parse(userData.phone.appHomeOrder);
    $("#app-home-page-1 .app-home-list .icons-list ul").empty();
    for(let app of userData.phone.appHomeOrder) {
        let divAppElement = "<li data-name='" + app + "'>";
        if(app != '') {
            let label = (config.apps.find( application => application.name == app).label ? config.apps.find( application => application.name == app).label : app);
            if(app == "clock") {
                divAppElement += "<div id='app-home-list-item-" + app + "' class='app-home-list-item'><div id='centered'><div id='app'><div id='circle'><ul><li>1</li><li>2</li><li>3</li><li>4</li><li>5</li><li>6</li><li>7</li><li>8</li><li>9</li><li>10</li><li>11</li><li>12</li></ul><div class='hand' id='hours'></div><div class='hand' id='minutes'></div><div class='hand' id='seconds'></div><div id='black-circle'></div><div id='red-circle'></div></div></div></div><span>" + label + "</span></div>";
            } else {
                divAppElement += "<div id='app-home-list-item-" + app + "' class='app-home-list-item'><img src='" + folderAppIcon + "app-" + app + "-icon.png'/><span>" + label + "</span></div>";
            }
        } else {
            divAppElement = "<li class='empty-place'>";
            divAppElement += "<div class='app-home-list-item empty-place'></div>";
        }
        $("#app-home-page-1 .app-home-list .icons-list > ul").append(divAppElement + "</li>");
        // $(".app-home-list .icons-list > ul li > div").click(function(e) {
        $(".app-home-list .icons-list > ul > li").last().find("div").click(function(e) {
            if(longpress) {
                e.preventDefault();
            } else {
                if(this.id) {
                    updateContent(this.id.split("-")[4]);
                }
            }
        });
    }
    // Création des application principales
    $("#app-home-list-primary").empty();
    for(let app of config.apps) {
        if(app.isPrimary) {
            let divAppElement = "<div draggable='false' id='app-home-list-item-" + app.name + "' class='app-home-list-item app-home-list-item-primary'><img src='" + folderAppIcon + "app-" + app.name + "-icon.png'/></div>";
            $("#app-home-list-primary").append(divAppElement);
            $("#app-home-list-primary").children().last().click(function () {
                if(this.id) {
                    updateContent(this.id.split("-")[4]);
                }
            });
        }
    }
    //Icon Horloge
    if(userData.phone.appHomeOrder.includes("clock")) {
        window.requestAnimFrame = (function() {
            return  window.requestAnimationFrame       ||
                    window.webkitRequestAnimationFrame ||
                    window.mozRequestAnimationFrame    ||
                    function( callback ){
                        window.setTimeout(callback, 1000 / 60);
                    };
        })();
        (function clock() { 
            let hour = document.getElementById("hours"),
                min = document.getElementById("minutes"),
                sec = document.getElementById("seconds");
                (function loop(){
                    requestAnimFrame(loop);
                    draw();
                })();
                function draw(){
                    let now = new Date(),
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
    }
    // Souris changement de page
    pageSelected = document.getElementById("app-home-page-container");
    pageSelected.addEventListener('mousedown', function(e) {
        if(e.which != 1) {
            return;
        }
        if(e.target.tagName == "UL" || e.target.classList.contains("empty-place") || e.target.classList.contains("icons-list") || e.target.classList.contains("app-home-list") || e.target.classList.contains("app-home-page") || e.target.id == "app-home-page-container") {
            isDown = true;
            offset = [
                pageSelected.offsetLeft - e.clientX,
                pageSelected.offsetTop - e.clientY
            ];
        }
    }, true);
    pageSelected.addEventListener('mouseup', function(e) {
        if(e.which != 1) {
            return;
        }
        if(e.target.tagName == "UL" || e.target.classList.contains("empty-place") || e.target.classList.contains("icons-list") || e.target.classList.contains("app-home-list") || e.target.classList.contains("app-home-page") || e.target.id == "app-home-page-container") {
            isDown = false;
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
                        if(mousePosition.x + offset[0] >= -280) {
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
            mousePosition = {
                x: null,
                y: null
            }
        }
    }, true);
    pageSelected.addEventListener('mousemove', function(event) {
        if (isDown) {
            event.preventDefault();
            mousePosition = {
                x : event.clientX,
                y : event.clientY
            };
            pageSelected.style.left = (mousePosition.x + offset[0]) + 'px';
        }
    }, true);
    setInterval(function () {
        saveHomeOrder()
    }, 300000);
    createShuffleGrid();
}

function switchThemeMode() {
    if(darkMode) {
        $("body").addClass("theme--default");
        $("body").removeClass("theme--dark");
        darkMode = false;
    } else {
        $("body").removeClass("theme--default");
        $("body").addClass("theme--dark");
        darkMode = true;
    }
    $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { darkMode: darkMode } }));
    $("#topbar-box-button-update-thememode").toggleClass("active");
    $("#settings-list-item-thememode label input").prop("checked", darkMode);
}

function saveHomeOrder() {
    gridPage1.itemVOs.sort(dynamicSortMultiple("row", "col"));
    let appHomeOrderSave = userData.phone.appHomeOrder;
    userData.phone.appHomeOrder = [];
    for(let icon of gridPage1.itemVOs) {
        if(icon.item.dataset.name != null) {
            userData.phone.appHomeOrder.push(icon.item.dataset.name);
        } else {
            userData.phone.appHomeOrder.push('');
        }
    }
    if(appHomeOrderSave.toString() != userData.phone.appHomeOrder.toString()) {
        $.post('https://OraPhone/patch_user_data', JSON.stringify({ id: userData.phone.id, phone: { appHomeOrder: JSON.stringify(userData.phone.appHomeOrder) } }));
    }
}

function updateNotificationMode() {
    let notificationModeButtonParent = $("#topbar-box-button-notification-mode");
    let notificationModeButton = $("#topbar-box-button-notification-mode i");
    if (notificationMode == "normal") {
        notificationMode = "nosound";
        notificationModeButton.removeClass("fa-bell");
        notificationModeButton.addClass("fa-volume-xmark");
        notificationModeButtonParent.addClass("active");
    } else if (notificationMode == "nosound") {
        notificationMode = "none";
        notificationModeButton.removeClass("fa-volume-xmark");
        notificationModeButton.addClass("fa-bell-slash");
        notificationModeButtonParent.removeClass("active");
    } else if (notificationMode == "none") {
        notificationMode = "normal";
        notificationModeButton.removeClass("fa-bell-slash");
        notificationModeButton.addClass("fa-bell");
        notificationModeButtonParent.addClass("active");
    }
}

// Application Message

function responsiveChatPush(sender, origin, date, message) {
    let originClass;
    if (origin == 'me') {
        originClass = 'myMessage';
    } else {
        originClass = 'fromThem';
    }
    let newMessageDiv = "";
    if (/^GPS:\s-?\d+.?\d+,\s-?\d+.?\d+,\s-?\d+.?\d+$/.test(message)) {
        newMessageDiv = '<div class="' + originClass + '"><p><div class="message-button-list"><button class="message-button-show-map">Afficher carte</button><button class="message-button-add-marker">Appliquer point</button></div></p><span class="date"><b>' + sender + '</b> ' + date + '</span></div>';
        $('.app-message-conversation .messages').append(newMessageDiv);
        $('.app-message-conversation .messages').children().last().find(".message-button-show-map").click(function() {
            let messagePos = message.replaceAll(/\s/g, '').substring(4).split(",");
            addMarkerToMap(messagePos[0], messagePos[1]);
            updateContent("maps");
        });
        $('.app-message-conversation .messages').children().last().find(".message-button-add-marker").click(function() {
            let messagePos = message.replaceAll(/\s/g, '').substring(4).split(",");
            $.post('https://OraPhone/add_potition_on_map', JSON.stringify({ x: messagePos[0], y: messagePos[1], z: messagePos[2] }));
        });
    } else if (/^https:\/\/i.imgur.com\/[a-zA-Z0-9_.-]+.jpg$/.test(message)) {
        newMessageDiv = '<div class="' + originClass + '"><p><img src="' + message + '"/></p><span class="date"><b>' + sender + '</b> ' + date + '</span></div>';
        $('.app-message-conversation .messages').append(newMessageDiv);
        $('.app-message-conversation .messages').children().last().click(function() {
            $("#image-fullscreen img").attr("src", message);
            document.getElementById("image-fullscreen").style.display = "block";
        });
    } else {
        newMessageDiv = '<div class="' + originClass + '"><p>' + message + '</p><span class="date"><b>' + sender + '</b> ' + date + '</span></div>';
        $('.app-message-conversation .messages').append(newMessageDiv);
    }
}

function messageChooseImageGallery() {
    let image = $(this).find("img").attr("src");
    $("#gallery-image-list .gallery-image-list-item").removeClass("bind-click").unbind("click", messageChooseImageGallery);
    $.post('https://OraPhone/add_message', JSON.stringify({ phoneId: userData.phone.id, targetNumber: messageTargetNumber, number: userData.phone.number, conversationId: conversationId, message: image }));
    updateContent("message");
    setTimeout(function() {
        updateAppContent("message");
    }, 500);
}

// Apllication Appel

function receiveCall(data) {
    callData = data;
    inReceiveCall = true;
    let avatar = contactAvatarDefault;
    let name = callData.fromNumber;
    for(let contact of userData.contacts) {
        if(contact.number.toString() == callData.fromNumber.toString()) {
            if(contact.avatar.includes("http")) {
                avatar = contact.avatar;
            } else {
                avatar = folderContactsProfileIcon + contact.avatar + ".png";
            }
            name = contact.name;
        }
    }
    if(!displayToggle) {
        addNotification("call", "callreceive", "Maintenant", "Appel", name, "", avatar);
    }
    $("#call-callreceive-title").html("Appel de " + name);
    updateContent("call");
    updateAppContent("callreceive");
    soundRinging.currentTime = 0;
    soundRinging.play();
    setTimeout(function() {
        if(inReceiveCall) {
            $.post('https://OraPhone/end_call', JSON.stringify({}));
            inReceiveCall = false;
        }
    }, 10000);
}

function callNumber(callNumber) {
    let number = callNumber.toString();
    callData.targetNumber = number;
    let callName = (number.length == 7 ? "555-" + number.substring(3) : number);
    let callAvatar = contactAvatarDefault;
    for(let contact of userData.contacts) {
        if(contact.number.toString() == number.toString()) {
            callAvatar = (contact.avatar.includes("http") ? contact.avatar : folderContactsProfileIcon + contact.avatar + ".png");
            callName = contact.name;
            break;
        }
    }
    $.post('https://OraPhone/call_number', JSON.stringify({ targetNumber: number, fromNumber: phoneNumber }));
    $("#callnumber-title-number").html("Appel vers " + callName);
    $("#callnumber-icon img").attr("src", callAvatar);
    if(callAvatar.includes("http")) {
        $("#callnumber-icon").addClass("url");
    } else {
        $("#callnumber-icon").removeClass("url");
    }
}

function takeCall() {
    inReceiveCall = false;
    inCall = true;
    updateAppContent("callstarted");
    stopSounds();
    $.post('https://OraPhone/accept_call', JSON.stringify({ channel: callData.channel }));
    if(callNotification != null && callNotification != undefined) {
        callNotification.style.opacity = "0";
        callNotificationLock.style.opacity = "0";
        setTimeout(function() {
            callNotification.remove();
            callNotificationLock.remove();
            if($("#notification-container").children().length == 0 && !displayToggle) {
                $("#phone").css("bottom", phoneBottomShowNot);
            }
        }, 750);
    }
    let name = callData.fromNumber;
    for(let contact of userData.contacts) {
        if(contact.number.toString() == callData.fromNumber.toString()) {
            name = contact.name;
        }
    }
    $("#callstarted-number").html("Appel en cours avec" + "<br/>" + name);
    $("#callstarted-time").html("00:00");
    let callStartedSec = 0
    let callStartedMin = 0
    let callStartedTimer = setInterval(function() {
        $("#callstarted-time").html((callStartedMin < 10 ? "0" + callStartedMin : callStartedMin) + ":" + (callStartedSec < 10 ? "0" + callStartedSec : callStartedSec));
        if(callStartedSec == 59) {
            callStartedSec = 0;
            callStartedMin++;
        } else {
            callStartedSec++;
        }
        if(!inCall) {
            clearInterval(callStartedTimer);
        }
    }, 1000);
}

// Application Camera

async function takeScreenshot(app, appSub) {
    updateContent(app);
    setTimeout(function() {
        updateAppContent(appSub);
    }, 400);
    $("#camera-image").attr("src", "");
    let resp = await MainRender.requestScreenshot("https://api.imgur.com/3/image/", "image");
    if (app == "camera") {
        $.post('https://OraPhone/camera_add_image', JSON.stringify({ phoneId: userData.phone.id, image: resp.data.link }));
    } else if (appSub == "newcontact") {
        $("#newcontact-icon-custom-input").val(resp.data.link);
        $("#newcontact-profile-icon img").attr("src", resp.data.link);
        $("#newcontact-profile-icon").addClass("url");
    } else if (appSub == "editcontact") {
        $("#editcontact-icon-custom-input").val(resp.data.link);
        $("#editcontact-profile-icon img").attr("src", resp.data.link);
        $("#editcontact-profile-icon").addClass("url");
    } else if (app == "richtermotorsport" && appSub == "create") {
        $("#richtermotorsport-create-image-takephoto").hide();
        $("#richtermotorsport-create-image-photo").attr("src", resp.data.link);
        $("#richtermotorsport-create-image-photo").show();
    } else if (app == "message" && appSub == "message") {
        $.post('https://OraPhone/add_message', JSON.stringify({ phoneId: userData.phone.id, targetNumber: messageTargetNumber, number: userData.phone.number, conversationId: conversationId, message: resp.data.link }));
    }
    $.post('https://OraPhone/close_camera', JSON.stringify({}));
    MainRender.stop();
    $("#camera-image").attr("src", resp.data.link);
}

function setCameraImage(image) {
    if(menuSelected == "camera") {
        $("#camera-image").attr("src", image);
        switchFormatOrientation("landscape");
    }
}

function switchFormatOrientation(orientation = false) {
    if(orientation) {
        if(orientation == formatOrientation) {
            return;
        }
        formatOrientation = orientation;
    } else {
        formatOrientation = formatOrientation == "landscape" ? "portrait" : "landscape";
    }
    if(formatOrientation == "portrait") {
        $("#phone").css("rotate", "0deg");
        $("#phone").css("bottom", phoneBottomShow);
        $("#phone").css("right", "100px");
    } else {
        $("#phone").css("rotate", "-90deg");
        $("#phone").css("bottom", phoneBottomShowLandscape);
        $("#phone").css("right", "330px");
    }
}

// Application Home

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
    $("#phone-lock").css("transform", "translate(0, -100%)");
    setTimeout(function() {
        $("#phone-lock").css("visibility", "hidden");
    }, 400);
    $("#app-content").css("transform", "scale(1)");
    $("#app-content").css("opacity", "1");
    phoneLockToggle = false;
    $("#phone-lock-button i").removeClass("fa-lock-open");
    $("#phone-lock-button i").addClass("fa-lock");
    if(!displayToggle) {
        displayPhone(true);
    }
}

function lockPhone() {
    let menuSelectedLock = document.getElementById("app-" + menuSelected);
    if(menuSelectedLock != null && menuSelectedLock.id != "app-home") {
        $("#phone-screen-content").removeClass();
    }
    $("#phone-lock").css("visibility", "visible");
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

// Application Horloge

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

// Application Maps

function addMarkerToMap(x, y) {
    let marker = L.marker([y, x]).addTo(map).bindPopup("Point GPS");
    markerList.push(marker);
    map.setView([y, x], 4);
    marker.on("click", function() {
        map.setView([y, x], 4);
    });
}

function mapsFavoriteRemove(id) {
    $.post('https://OraPhone/maps_favorite_remove_marker', JSON.stringify({ phoneId: userData.phone.id, id: id }));
}

function mapsUpdateMyPosition(toggle) {
    if (toggle) {
        mapsIntervalMyPosition = setInterval(function() {
            $.post('https://OraPhone/maps_update_my_position', JSON.stringify({ }));
        }, 2000);
    } else {
        clearInterval(mapsIntervalMyPosition);
    }
}

function customIcon(icon){
    return L.icon({
        iconUrl: `./assets/images/apps/maps/marker-icons/${icon}.png`,
        iconSize:     [32, 32],
        iconAnchor:   [16, 16],
        popupAnchor:  [0, -15]
    });
}

// Fonctions d'affichage

function updateContent(menu) {
    for(let app of config.apps) {
        if(menu == app.name && app.maintenance) {
            menu = "maintenance";
            break;
        }
    }
    let appSelected = document.getElementById("app-" + menu);
    if(!appSelected) {
        return;
    }
    if (menu == "clock" && !activateAppClockToggle) {
        activateAppClock();
    } else if (menu == "richtermotorsport") {
        activateAppRichterMotorsport();
    } else if (menu == "camera") {
        if(!canvasActivate) {
            canvasActivate = true;
            activateAppCamera("camera", "photo");
        }
    } else if (menu == "maps") {
        map.fitBounds(bounds);
        mapsUpdateMyPosition(true);
    }
    if (menuSelected == "maps") {
        mapsUpdateMyPosition(false);
    } else if (menuSelected == "gallery") {
        for (let item of document.querySelectorAll("#gallery-image-list .gallery-image-list-item")) {
            if ($(item).hasClass("bind-click")) {
                $(item).removeClass("bind-click").unbind("click", messageChooseImageGallery);
            }
        }
    }
    switchFormatOrientation("portrait");
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
        $("#phone-screen-content").removeClass();
        if(appSelected.classList.contains("app-tabbed")) {
            $("#phone-screen-content").addClass("app-tabbed");
        } else if(appSelected.classList.contains("app-modal")) {
            $("#phone-screen-content").addClass("app-modal");
        }
        $("#phone-screen-content").addClass("app-" + menu);
        updateAppContent("first");
    } else if(menu == "home") {
        menuAppSelected = "first";
        $("#phone-screen-content").removeClass();
        canvasActivate = false;
        setTimeout(function() {
            updateAppContent("first");
        }, 300);
    }
    menuSelectedLast = menuSelected;
    menuSelected = menu;
}

function updateAppContent(element) {
    menuAppSelectedLast = menuAppSelected;
    menuAppSelected = element;
    let elementSelected = "";
    for(let content of document.getElementsByClassName("app-body-content")) {
        content.style.display = "none";
    }
    $(".app-tab-button").removeClass("active");
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
    let oldClass = $("#phone-screen-content").data("app-content-class");
    if(oldClass) {
        $("#phone-screen-content").removeClass(oldClass);
    }
    $("#phone-screen-content").addClass(menuSelected + "-" + elementSelected);
    $("#phone-screen-content").data("app-content-class", menuSelected + "-" + elementSelected);
    if(element == "newmessage") {
        let searchInput = document.getElementById("app-message-body-content-newmessage-search");
        searchInput.value = "";
        for(let elt of document.querySelectorAll(".newmessage-list-item")) {
            if(elt.querySelector(".newmessage-list-item-right-header-name").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "flex";
            } else {
                elt.style.display = "none";
            }
        }
    }
    // Remise à zéro de la liste des contactes
    if(menuSelected == "contacts" && menuSelectedLast != "camera") {
        let searchInput = document.getElementById("app-contacts-body-content-list-search");
        searchInput.value = "";
        for(let elt of document.querySelectorAll(".contacts-list-row-item")) {
            if(elt.querySelector(".contacts-list-row-item-top-name span").innerHTML.toLowerCase().includes(searchInput.value.toLowerCase())) {
                elt.style.display = "block";
            } else {
                elt.style.display = "none";
            }
        }
    }
}

function displayPhone(visible) {
    if(visible) {
        if(formatOrientation == "landscape") {
            $("#phone").css("bottom", phoneBottomShowLandscape);
        } else {
            $("#phone").css("bottom", phoneBottomShow);
        }
        displayToggle = true;
    } else {
        $("#phone").css("bottom", phoneBottomShowNot);
        displayToggle = false;
    }
}

function displayTopbar() {
    if(displayTopbarToggle) {
        $("#topbar-blur").css("opacity", "0");
        $("#topbar-blur").css("visibility", "hidden");
        $("#phone-screen-content-topbar").css("visibility", "hidden");
        $("#topbar-content").css("top", "-700px");
        displayTopbarToggle = false;
    } else {
        $("#phone-screen-content-topbar").css("visibility", "visible");
        $("#topbar-blur").css("visibility", "visible");
        $("#topbar-blur").css("opacity", "1");
        $("#topbar-content").css("top", "0px");
        displayTopbarToggle = true;
    }
}

// Notification

function addNotification(app, appSub, time, title, message, data, avatar = false) {
    if (notificationMode == "none" || !phoneActive) {
        return;
    }
    let label = "Inconnu";
    let divNotification = "";
    let divNotificationLock = "";
    if (!displayToggle) {
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
    if (app == "message") {
        let messageName = "";
        for(let user of title) {
            if(user != userData.phone.number) {
                let name = user;
                for(let contact of userData.contacts) {
                    if(contact.number.toString() == user.toString()) {
                        name = contact.name;
                        break;
                    }
                }
                messageName += name + ", ";
            }
        }
        title = messageName.slice(0, -2);
    }
    if (app == "call") {
        divNotification = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-main call'><div class='notification-item-main-avatar " + (avatar && avatar != '' ? (avatar.includes('http') ? 'url' : '') : '')  + "'><img src='" + avatar + "'/></div><div class='notification-item-main-info'><span class='notification-item-main-info-header'>" + title + "</span><span class='notification-item-main-info-message'>" + message + "</span></div><div class='notification-item-main-hangup'><i class='fa-solid fa-phone-slash'></i></div><div class='notification-item-main-pickup'><i class='fa-solid fa-phone'></i></div></div></div></div>";
        divNotificationLock = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-main call'><div class='notification-item-main-avatar " + (avatar && avatar != '' ? (avatar.includes('http') ? 'url' : '') : '') + "'><img src='" + avatar + "'/></div><div class='notification-item-main-info'><span class='notification-item-main-info-header'>" + title + "</span><span class='notification-item-main-info-message'>" + message + "</span></div><div class='notification-item-main-hangup'><i class='fa-solid fa-phone-slash'></i></div><div class='notification-item-main-pickup'><i class='fa-solid fa-phone'></i></div></div></div></div>";
    } else {
        divNotification = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-header'><div class='notification-item-background-blur'></div><div class='notification-item-header-content'><div class='notification-item-header-content-left'><img src='"+ folderAppIcon + "app-" + app + "-icon.png'/>" + label + "</div><div class='notification-item-header-content-right'>" + time + "</div></div></div><div class='notification-item-main'><span class='notification-item-main-header'>" + title + "</span><span class='notification-item-main-message'>" + message + "</span></div></div></div>";
        divNotificationLock = "<div class='notification-item close'><div class='notification-item-content'><div class='notification-item-background-blur'></div><div class='notification-item-icon'><img src='"+ folderAppIcon + "app-" + app + "-icon.png'/></div><div class='notification-item-content-body'><div class='notification-item-content-body-header'><div class='notification-item-content-body-header-left'>" + label + "</div><div class='notification-item-content-body-header-right'>" + time + "</div></div><div class='notification-item-content-body-content'><div class='notification-item-content-body-content-message'>" + message + "</div></div></div></div></div>";
    }
    $("#notification-container").prepend(divNotification);
    $("#notification-container-lock").prepend(divNotificationLock);
    let notification = document.getElementById("notification-container").firstElementChild;
    let notificationLock = document.getElementById("notification-container-lock").firstElementChild;
    if (app == "call") {
        callNotification = notification;
        callNotificationLock = notificationLock;
        $(".notification-item-main-pickup").click(function() {
            inReceiveCall = false;
            inCall = true;
            updateAppContent("callstarted");
            stopSounds();
            $.post('https://OraPhone/accept_call', JSON.stringify({ channel: callData.channel }));
            if(callNotification != null && callNotification != undefined) {
                callNotification.style.opacity = "0";
                callNotificationLock.style.opacity = "0";
                setTimeout(function() {
                    callNotification.remove();
                    callNotificationLock.remove();
                    if($("#notification-container").children().length == 0 && !displayToggle) {
                        $("#phone").css("bottom", phoneBottomShowNot);
                    }
                }, 750);
            }
            let name = callData.fromNumber;
            for(let contact of userData.contacts) {
                if(contact.number.toString() == callData.fromNumber.toString()) {
                    name = contact.name;
                }
            }
            $("#callstarted-number").html("Appel en cours avec" + "<br/>" + name);
            $("#callstarted-time").html("00:00");
            let callStartedSec = 0
            let callStartedMin = 0
            let callStartedTimer = setInterval(function() {
                $("#callstarted-time").html((callStartedMin < 10 ? "0" + callStartedMin : callStartedMin) + ":" + (callStartedSec < 10 ? "0" + callStartedSec : callStartedSec));
                if(callStartedSec == 59) {
                    callStartedSec = 0;
                    callStartedMin++;
                } else {
                    callStartedSec++;
                }
                if(!inCall) {
                    clearInterval(callStartedTimer);
                }
            }, 1000);
        });
        $(".notification-item-main-hangup").click(function() {
            $.post('https://OraPhone/end_call', JSON.stringify({}));
        });
    } else {
        notification.addEventListener("click", function() {
            if(!phoneLockToggle) {
                if(!displayToggle) {
                    displayPhone(true);
                }
                updateContent(app);
                updateAppContent(appSub);
                notification.remove();
                stopSounds();
                if(app == "message") {
                    updateAppMessageLoad(data.conversationId);
                    let elementMessages = document.querySelector(".app-message-conversation .messages");
                    elementMessages.scroll({ top: elementMessages.scrollHeight, behavior: "instant"});
                }
            }
        });
        notificationLock.addEventListener("click", function() {
            if(phoneLockToggle) {
                if(!displayToggle) {
                    displayPhone(true);
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
    }
    $(".notification-item-main-hangup").click(function() {
        stopSounds();
    });
    setTimeout(function() {
        notification.classList.remove("close");
        notificationLock.classList.remove("close");
        let notificationTime = "5000";
        if (app == "call") {
            if (notificationMode != "nosound") {
                soundRinging.currentTime = 0;
                soundRinging.play();
            }
            notificationTime = "10000";
        } else if (app == "clock") {
            if (notificationMode != "nosound") {
                soundAlarm.currentTime = 0;
                soundAlarm.play();
            }
            notificationTime = "30000";
        } else {
            if (notificationMode != "nosound") {
                soundNotification.currentTime = 0;
                soundNotification.play();
            }
        }
        setTimeout(function() {
            if(app != "call") {
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
            }
        }, notificationTime);
    }, 25);
}

// Fonctions diverses

function dynamicSort(property) {
    let sortOrder = 1;
    if(property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a,b) {
        /* next line works with strings and numbers, 
         * and you may want to customize it to your needs
         */
        let result = 0;
        if (a[property] < b[property]) {
            result = -1;
        } else if (a[property] > b[property]) {
            result = 1;
        }
        return result * sortOrder;
    }
}

function dynamicSortMultiple() {
    /*
     * save the arguments object as it will be overwritten
     * note that arguments object is an array-like object
     * consisting of the names of the properties to sort by
     */
    let props = arguments;
    return function (obj1, obj2) {
        let i = 0, result = 0, numberOfProperties = props.length;
        /* try getting a different result from 0 (equal)
         * as long as we have extra properties to compare
         */
        while(result === 0 && i < numberOfProperties) {
            result = dynamicSort(props[i])(obj1, obj2);
            i++;
        }
        return result;
    }
}

function numberWithSpaces(x) {
    let parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    return parts.join(".");
}

function isImage(url) {
    return /^https?:\/\/.+\.(jpg|jpeg|png|webp|avif|gif|svg)$/.test(url);
}

function stopSounds() {
    soundNotification.pause();
    soundNotification.load();
    soundRinging.pause();
    soundRinging.load();
    soundAlarm.pause();
    soundAlarm.load();
    soundCallWait.pause();
    soundCallWait.load();
}

function createShuffleGrid() {
    let ShuffleGrid, addClass, hasClass, iconsList, removeClass;
    addClass = function(el, className) {
        if (hasClass(el, className)) {
            return;
        }
        if (el.classList) {
            el.classList.add(className);
        } else {
            el.className += ' ' + className;
        }
    };
    removeClass = function(el, className) {
        if (el.classList) {
            el.classList.remove(className);
        } else {
            el.className = el.className.replace(new RegExp("(^|\\b)" + className.split(" ").join("|") + "(\\b|$)", "gi"), " ");
        }
    };
    hasClass = function(el, className) {
        if (el.classList) {
            return el.classList.contains(className);
        } else {
            return new RegExp("(^| )" + className + "( |$)", "gi").test(el.className);
        }
    };
    ShuffleGrid = (function() {
        class ShuffleGrid {
            constructor(context, cols, rows, colSize, rowSize, paddingX = 0, paddingY = 0) {
                this.initIndex = this.initIndex.bind(this);
                this.addItem = this.addItem.bind(this);
                this.shuffleItems = this.shuffleItems.bind(this);
                this.snapToGrid = this.snapToGrid.bind(this);
                this.positionItem = this.positionItem.bind(this);
                this.getPosition = this.getPosition.bind(this);
                this.getCell = this.getCell.bind(this);
                this.onMousePress = this.onMousePress.bind(this);
                this.onMouseMove = this.onMouseMove.bind(this);
                this.onMouseRelease = this.onMouseRelease.bind(this);
                this.numCells = this.numCells.bind(this);
                this.startDrag = this.startDrag.bind(this);
                this.stopDrag = this.stopDrag.bind(this);
                this.context = context;
                this.cols = cols;
                this.rows = rows;
                this.colSize = colSize;
                this.rowSize = rowSize;
                this.paddingX = paddingX;
                this.paddingY = paddingY;
                this.numItems = 0;
                this.initIndex();
                this.items = [].slice.call(this.context.children);
                this.items.forEach((item, id) => {
                    return this.addItem(item);
                });
            }
            initIndex() {
                let i;
                this.itemVOs = [];
                this.index = new Array(this.rows);
                i = 0;
                while (i < this.rows) {
                    this.index[i++] = new Array(this.cols);
                }
            }
            addItem(item) {
                let col, id, itemVO, position, row;
                col = this.numItems % this.cols;
                row = Math.floor(this.numItems / this.cols);
                position = this.getPosition(row, col);
                id = this.numItems;
                this.numItems++;
                itemVO = {
                        row: row,
                        col: col,
                        item: item,
                        id: id
                };
                item.style.width = `${this.colSize}px`;
                item.style.height = `${this.rowSize}px`;
                item.setAttribute('id', id);
                this.positionItem(item, position.x, position.y);
                this.index[row][col] = itemVO;
                this.itemVOs[id] = itemVO;
                if (hasClass(item, 'placeholder')) {
                        return;
                }
                item.children[0].style.webkitAnimationDelay = Math.random() * 0.5 + 's';
                item.children[0].style.MozAnimationDelay = Math.random() * 0.5 + 's';
                item.addEventListener('mousedown', this.onMousePress, false);
                return item;
            }
            shuffleItems() {
                let cell, col, hMove, i, item, itemVO, move, row, vMove;
                itemVO = this.itemVOs[this.currentItem.getAttribute('id')];
                cell = this.getCell(parseInt(this.currentItem.getAttribute('x')), parseInt(this.currentItem.getAttribute('y')));
                col = cell.x;
                row = cell.y;
                if (col === itemVO.col && row === itemVO.row) {
                    return;
                }
                hMove = col - itemVO.col;
                vMove = row - itemVO.row;
                move = [];
                if (hMove < 0) {
                    i = itemVO.col - 1;
                    while (i >= itemVO.col + hMove) {
                    if (this.index[itemVO.row][i]) {
                        item = this.index[itemVO.row][i];
                        item.col++;
                        this.index[item.row][item.col] = item;
                        move.push(item);
                    }
                    i--;
                    }
                } else {
                    i = itemVO.col + 1;
                    while (i <= itemVO.col + hMove) {
                    if (this.index[itemVO.row][i]) {
                        item = this.index[itemVO.row][i];
                        item.col--;
                        this.index[item.row][item.col] = item;
                        move.push(item);
                    }
                    i++;
                    }
                }
                if (vMove < 0) {
                    i = itemVO.row - 1;
                    while (i >= itemVO.row + vMove) {
                    if (this.index[i][itemVO.col + hMove]) {
                        item = this.index[i][itemVO.col + hMove];
                        item.row++;
                        this.index[item.row][item.col] = item;
                        move.push(item);
                    }
                    i--;
                    }
                } else {
                    i = itemVO.row + 1;
                    while (i <= itemVO.row + vMove) {
                    if (this.index[i][itemVO.col + hMove]) {
                        item = this.index[i][itemVO.col + hMove];
                        item.row--;
                        this.index[item.row][item.col] = item;
                        move.push(item);
                    }
                    i++;
                    }
                }
                i = 0;
                while (i < move.length) {
                    this.snapToGrid(move[i++]);
                }
                itemVO.row = row;
                itemVO.col = col;
                this.index[row][col] = itemVO;
            }
            snapToGrid(itemVO) {
                let position = this.getPosition(itemVO.row, itemVO.col);
                this.positionItem(itemVO.item, position.x, position.y);
            }
            positionItem(item, x, y) {
                item.style.transform = `translateX(${x}px) translateY(${y}px)`;
            }
            getPosition(row, col) {
                // Only used for the iOS demo
                let position = {
                    x: col * (this.colSize + this.paddingX),
                    y: row * (this.rowSize + this.paddingY)
                };
                return position;
            }
            getCell(x, y) {
                let cell = {
                    x: Math.max(0, Math.min(this.cols - 1, Math.round(x / (this.colSize + this.paddingX)))),
                    y: Math.max(0, Math.min(this.rows - 1, Math.round(y / (this.rowSize + this.paddingY))))
                };
                return cell;
            }
            onMousePress(event) {
                if(event.which != 1) {
                        return;
                }
                startTime = new Date().getTime();
                let itemSave = this;
                let itemCurrent = event.currentTarget;
                if(itemCurrent.firstElementChild.classList.contains('empty-place')) {
                        return;
                }
                this.context.addEventListener('mouseup', function() {
                        endTime = new Date().getTime();
                        if (endTime - startTime < 250) {
                            longpress = false;
                            setTimeout(function() {
                                longpress = true;
                            }, 300);
                        }
                }, false);
                setTimeout(function() {
                        if(longpress) {
                            var contextOffset, left, top, zoom;
                            itemSave.currentItem = itemCurrent;
                            contextOffset = itemSave.context.getBoundingClientRect();
                            zoom = $("#phone").css("zoom");
                            left = contextOffset.left * parseFloat(zoom) - 25;
                            top = contextOffset.top * parseFloat(zoom) - 5;
                            itemSave.originOffset = {
                                    x: event.offsetX + left + 24,
                                    y: event.offsetY + top + 0
                            };
                            itemSave.startDrag(itemSave.currentItem);
                            itemSave.onMouseMove(event);
                            itemSave.context.addEventListener('mouseup', itemSave.onMouseRelease, false);
                            itemSave.context.addEventListener('mousemove', itemSave.onMouseMove, false);
                            itemSave.context.addEventListener('mouseleave', itemSave.onMouseRelease, false);
                        }
                }, 275);
            }
            onMouseMove(event) {
                let x, y, zoom, zoomPadding;
                x = event.clientX - this.originOffset.x;
                y = event.clientY - this.originOffset.y;
                zoom = parseFloat($("#phone").css("zoom"));
                for(let generalZoomItem of config.generalzoom) {
                        if(generalZoomItem.title == generalZoomActive) {
                            zoomPadding = generalZoomItem.home;
                        }
                }
                x = x + (x / Math.exp((zoom * 100 - 50) / (this.paddingX - zoomPadding)));
                y = y + (y / Math.exp((zoom * 100 - 50) / (this.paddingY - zoomPadding)));
                this.currentItem.setAttribute('x', x);
                this.currentItem.setAttribute('y', y);
                this.positionItem(this.currentItem, x, y);
                this.shuffleItems();
            }
            onMouseRelease(event) {
                this.currentItem.removeEventListener('mouseout', this.onMouseRelease);
                this.stopDrag(this.currentItem);
                this.context.removeEventListener('mousemove', this.onMouseMove);
                this.snapToGrid(this.itemVOs[this.currentItem.getAttribute('id')]);
            }
            numCells() {
                return this.rows * this.cols;
            }
            startDrag(item) {
                this.zIndex++;
                item.style.zIndex = this.zIndex;
                addClass(item, 'dragging');
                addClass(this.context, 'shaking');
            }
            stopDrag(item) {
                removeClass(item, 'dragging');
                removeClass(this.context, 'shaking');
                $(window).off('mousemove');
            }
        };
        ShuffleGrid.prototype.zIndex = 100;
        return ShuffleGrid;
    }).call(this);
    iconsList = document.querySelector('.icons-list ul');
    gridPage1 = new ShuffleGrid(iconsList, 8, 5, 60, 60, 38, 30);
}

// Objet config
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
            "name": "gallery",
            "label": "Galerie"
        },
        {
            "name": "calandar",
            "label": "Calendrier",
            "maintenance": true
        },
        {
            "name": "notes",
            "label": "Notes",
            "maintenance": true
        },
        {
            "name": "calculator",
            "label": "Calculatrice"
        },
        {
            "name": "store",
            "label": "Magasin",
            "maintenance": true
        },
        {
            "name": "music",
            "label": "Musique",
            "maintenance": true
        },
        // {
        //     "name": "templatetabbed",
        //     "label": "Template Tabbed"
        // },
        {
            "name": "richtermotorsport",
            "label": "Richter Motorsport"
        },
        {
            "name": "maps",
            "label": "Carte"
        },
        {
            "name": "bank",
            "label": "Banque",
            "maintenance": true
        },
        {
            "name": "phone",
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
            "value": 100,
            "home": 19
        },
        {
            "title": "zoom125%",
            "label": "125%",
            "value": 85,
            "home": 15
        },
        {
            "title": "zoom100%",
            "label": "100%",
            "value": 75,
            "home": 12
        },
        {
            "title": "zoom75%",
            "label": "75%",
            "value": 65,
            "home": 9
        },
        {
            "title": "zoom50%",
            "label": "50%",
            "value": 55,
            "home": 9
        },
        {
            "title": "zoom25%",
            "label": "25%",
            "value": 45,
            "home": 8
        },
    ],
    "contactsicon": [
        {
            "title": "50-Animals-avatar_1"
        },
        {
            "title": "50-Animals-avatar_2"
        },
        {
            "title": "50-Animals-avatar_3"
        },
        {
            "title": "50-Animals-avatar_4"
        },
        {
            "title": "50-Animals-avatar_5"
        },
        {
            "title": "50-Animals-avatar_9"
        },
        {
            "title": "50-Animals-avatar_10"
        },
        {
            "title": "50-Animals-avatar_16"
        },
        {
            "title": "50-Animals-avatar_21"
        },
        {
            "title": "50-Animals-avatar_49"
        },
        {
            "title": "50-Esports_1"
        },
        {
            "title": "50-Gaming_Icons_2"
        },
        {
            "title": "50-Gaming_Icons_32"
        },
        {
            "title": "50-Gaming_Icons_40"
        },
        {
            "title": "50-Gaming_Icons_49"
        },
        {
            "title": "50-Supermarket-Icons_1"
        },
        {
            "title": "50-Supermarket-Icons_5"
        },
        {
            "title": "50-Supermarket-Icons_13"
        },
        {
            "title": "50-Supermarket-Icons_33"
        },
        {
            "title": "50-Supermarket-Icons_34"
        },
        {
            "title": "50-Supermarket-Icons_45"
        },
        {
            "title": "50-Supermarket-Icons_49"
        },
        {
            "title": "Animal_Protection_1"
        },
        {
            "title": "Animal_Protection_4"
        },
        {
            "title": "Animal_Protection_5"
        },
        {
            "title": "Animal_Protection_6"
        },
        {
            "title": "Animal_Protection_21"
        },
        {
            "title": "Avatar_Users2_1"
        },
        {
            "title": "Avatar_Users2_2"
        },
        {
            "title": "Avatar_Users2_3"
        },
        {
            "title": "Avatar_Users2_4"
        },
        {
            "title": "Avatar_Users2_5"
        },
        {
            "title": "Avatar_Users2_6"
        },
        {
            "title": "Avatar_Users2_7"
        },
        {
            "title": "Avatar_Users2_8"
        },
        {
            "title": "Avatar_Users2_9"
        },
        {
            "title": "Avatar_Users2_10"
        },
        {
            "title": "Avatar_Users2_11"
        },
        {
            "title": "Avatar_Users2_13"
        },
        {
            "title": "Avatar_Users2_14"
        },
        {
            "title": "Avatar_Users2_15"
        },
        {
            "title": "Avatar_Users2_16"
        },
        {
            "title": "Avatar_Users2_17"
        },
        {
            "title": "Avatar_Users2_19"
        },
        {
            "title": "Avatar_Users2_20"
        },
        {
            "title": "Avatar_Users2_23"
        },
        {
            "title": "Avatar_Users2_25"
        },
        {
            "title": "Avatar_Users2_26"
        },
        {
            "title": "Avatar_Users2_27"
        },
        {
            "title": "Avatar_Users2_28"
        },
        {
            "title": "Avatar_Users2_30"
        },
        {
            "title": "Avatar_Users2_34"
        },
        {
            "title": "Avatar_Users2_35"
        },
        {
            "title": "Avatar_Users2_36"
        },
        {
            "title": "Avatar_Users2_37"
        },
        {
            "title": "Avatar_Users2_38"
        },
        {
            "title": "Avatar_Users2_43"
        },
        {
            "title": "Avatar_Users2_44"
        },
        {
            "title": "Avatar_Users2_45"
        },
        {
            "title": "Avatar_Users2_47"
        },
        {
            "title": "Avatar_Users2_49"
        },
        {
            "title": "Bio_Food_and_Agriculture_15"
        },
        {
            "title": "Bio_Food_and_Agriculture_21"
        },
        {
            "title": "Blogging_2"
        },
        {
            "title": "Blogging_4"
        },
        {
            "title": "Blogging_5"
        },
        {
            "title": "Blogging_15"
        },
        {
            "title": "Blogging_18"
        },
        {
            "title": "Blogging_22"
        },
        {
            "title": "Blogging_39"
        },
        {
            "title": "Blogging_40"
        },
        {
            "title": "Blogging_46"
        },
        {
            "title": "Blogging_47"
        },
        {
            "title": "Bowling_3"
        },
        {
            "title": "Bowling_5"
        },
        {
            "title": "Bowling_6"
        },
        {
            "title": "Bowling_48"
        },
        {
            "title": "Bowling_49"
        },
        {
            "title": "Cars_14"
        },
        {
            "title": "Cars_15"
        },
        {
            "title": "Cars_17"
        },
        {
            "title": "Cars_19"
        },
        {
            "title": "Cars_27"
        },
        {
            "title": "Cars_46"
        },
        {
            "title": "Cars_47"
        },
        {
            "title": "Creative_Design_1"
        },
        {
            "title": "Creative_Design_2"
        },
        {
            "title": "Creative_Design_7"
        },
        {
            "title": "Creative_Design_8"
        },
        {
            "title": "Creative_Design_11"
        },
        {
            "title": "Creative_Design_30"
        },
        {
            "title": "Creative_Design_49"
        },
        {
            "title": "Law_and_order_1"
        },
        {
            "title": "Law_and_order_2"
        },
        {
            "title": "Law_and_order_3"
        },
        {
            "title": "Law_and_order_4"
        },
        {
            "title": "Law_and_order_7"
        },
        {
            "title": "Law_and_order_10"
        },
        {
            "title": "Law_and_order_11"
        },
        {
            "title": "Law_and_order_14"
        },
        {
            "title": "Law_and_order_16"
        },
        {
            "title": "Law_and_order_17"
        },
        {
            "title": "Law_and_order_18"
        },
        {
            "title": "Law_and_order_20"
        },
        {
            "title": "Law_and_order_21"
        },
        {
            "title": "Law_and_order_22"
        },
        {
            "title": "Law_and_order_23"
        },
        {
            "title": "Law_and_order_24"
        },
        {
            "title": "Law_and_order_25"
        },
        {
            "title": "Law_and_order_27"
        },
        {
            "title": "Law_and_order_28"
        },
        {
            "title": "Law_and_order_29"
        },
        {
            "title": "Law_and_order_30"
        },
        {
            "title": "Law_and_order_35"
        },
        {
            "title": "Law_and_order_43"
        },
        {
            "title": "Law_and_order_46"
        },
        {
            "title": "Law_and_order_47"
        },
        {
            "title": "Law_and_order_49"
        },
        {
            "title": "Pharmacy_4"
        },
        {
            "title": "Pharmacy_7"
        },
        {
            "title": "Pharmacy_8"
        },
        {
            "title": "Pharmacy_12"
        },
        {
            "title": "Pharmacy_15"
        },
        {
            "title": "Pharmacy_20"
        },
        {
            "title": "Pharmacy_26"
        },
        {
            "title": "Pharmacy_33"
        },
        {
            "title": "Protest_17"
        },
        {
            "title": "Protest_20"
        },
        {
            "title": "Protest_41"
        },
        {
            "title": "Protest_42"
        },
        {
            "title": "Protest_43"
        },
        {
            "title": "Rent_1"
        },
        {
            "title": "Rent_3"
        },
        {
            "title": "Rent_10"
        },
        {
            "title": "Rent_11"
        },
        {
            "title": "Rent_20"
        },
        {
            "title": "Rent_31"
        },
        {
            "title": "Rent_32"
        },
        {
            "title": "Rent_40"
        }
    ]
}

// Menu context au clique droit / Désactivé
class ContextMenu {
    constructor({ target = null, menuItems = [] }) {
        this.target = target;
        this.menuItems = menuItems;
        this.targetNode = this.getTargetNode();
        this.menuItemsNode = this.getMenuItemsNode();
        this.contextMenu = null;
        this.isOpened = false;
    }
    getTargetNode() {
        const nodes = document.querySelectorAll(this.target);   
        if (nodes && nodes.length !== 0) {
            return nodes;
        } else {
            console.error(`getTargetNode :: "${this.target}" target not found`);
            return [];
        }
    }
    getMenuItemsNode() {
            const nodes = [];
            if (!this.menuItems) {
                console.error("getMenuItemsNode :: Please enter menu items");
                return [];
            }
            this.menuItems.forEach((data, index) => {
                const item = this.createItemMarkup(data);
                item.firstChild.setAttribute(
                    "style",
                    `animation-delay: ${index * 0.08}s`
                );
                nodes.push(item);
            });
            return nodes;
    }
    createItemMarkup(data) {
            const button = document.createElement("BUTTON");
            const item = document.createElement("LI");
            button.innerHTML = data.content;
            button.classList.add("contextMenu-button");
            item.classList.add("contextMenu-item");
            if (data.divider) item.setAttribute("data-divider", data.divider);
            if (data.class) button.classList.add(data.class);
            item.appendChild(button);
            if (data.events && data.events.length !== 0) {
                Object.entries(data.events).forEach((event) => {
                    const [key, value] = event;
                    button.addEventListener(key, value);
                });
            }
            return item;
    }
    renderMenu() {
        const menuContainer = document.createElement("UL");
        menuContainer.classList.add("contextMenu");
        this.menuItemsNode.forEach((item) => menuContainer.appendChild(item));
        return menuContainer;
    }
    closeMenu(menu) {
            if (this.isOpened) {
                this.isOpened = false;
                menu.remove();
            }
    }
    init() {
        this.contextMenu = this.renderMenu();
        document.addEventListener("click", () => this.closeMenu(this.contextMenu));
        window.addEventListener("blur", () => this.closeMenu(this.contextMenu));
        // document.addEventListener("contextmenu", (e) => {
            //     this.targetNode.forEach((target) => {
            //         if (!e.target.contains(target)) {
            //             contextMenu.remove();
            //         }
            //     });
            // });
        this.targetNode.forEach((target) => {
            target.addEventListener("contextmenu", (e) => {
                e.preventDefault();
                this.isOpened = true;
                contextMenuHomeTarget = target;
                contextMenuItemClicked = e;
    
                const { clientX, clientY } = e;
                document.body.appendChild(this.contextMenu);
        
                const positionY =
                    clientY + this.contextMenu.scrollHeight >= window.innerHeight
                    ? window.innerHeight - this.contextMenu.scrollHeight - 20
                    : clientY;
                const positionX =
                    clientX + this.contextMenu.scrollWidth >= window.innerWidth
                    ? window.innerWidth - this.contextMenu.scrollWidth - 20
                    : clientX;
        
                this.contextMenu.setAttribute(
                    "style",
                    `--width: ${this.contextMenu.scrollWidth}px;
                    --height: ${this.contextMenu.scrollHeight}px;
                    --top: ${positionY}px;
                    --left: ${positionX}px;`
                );
            });
        });
    }
    updateTargetNode() {
        this.targetNode = this.getTargetNode();
        this.targetNode.forEach((target) => {
            target.addEventListener("contextmenu", (e) => {
                e.preventDefault();
                this.isOpened = true;
                contextMenuHomeTarget = target;
                contextMenuItemClicked = e;

                const { clientX, clientY } = e;
                document.body.appendChild(this.contextMenu);
        
                const positionY =
                    clientY + this.contextMenu.scrollHeight >= window.innerHeight
                    ? window.innerHeight - this.contextMenu.scrollHeight - 20
                    : clientY;
                const positionX =
                    clientX + this.contextMenu.scrollWidth >= window.innerWidth
                    ? window.innerWidth - this.contextMenu.scrollWidth - 20
                    : clientX;
        
                this.contextMenu.setAttribute(
                    "style",
                    `--width: ${this.contextMenu.scrollWidth}px;
                    --height: ${this.contextMenu.scrollHeight}px;
                    --top: ${positionY}px;
                    --left: ${positionX}px;`
                );
            });
        });
    }
}

// const menuItems = [
//     {
//         content: `${copyIcon}Changer page`,
//         events: {
//             click: (e) => changeAppPlacePage()
//         }
//     },
//     {
//         content: `${copyIcon}Copy`,
//         events: {
//             click: (e) => console.log(e, "Copy Button Click")
//             // mouseover: () => console.log("Copy Button Mouseover")
//             // You can use any event listener from here
//         }
//     },
//     {
//         content: `${cutIcon}Cut`,
//         divider: "top-bottom" // top, bottom, top-bottom
//     },
// ];

// const contextMenuHome = new ContextMenu({
//     target: "#app-home",
//     menuItems
// });
// contextMenuHome.init();



const Blips = [
    {name: "Poste de police", color: 29, sprite: 60, size: 1.0, Pos: {x: -1072.52, y: -856.42, z: 4.87}},
    {name: "Sherif - Paleto Bay", color: 70, sprite: 60, size: 1.0, Pos: {x: -440.43, y: 6019.48, z: 31.49}},
    {name: "Vanilla Unicorn", color: 61, sprite: 121, size: 0.8, Pos: {x: 119.47, y: -1308.58, z: 29.71}},
    {name: "Distributeur de Billets", color: 2, sprite: 434, size: 0.80, Pos: {x: -526.065, y: -1221.99, z: 18.4549}},
    {name: "Distributeur de Billets", color: 2, sprite: 434, size: 0.80, Pos: {x: -2073.44, y: -317.245, z: 13.316}},
    {name: "Distributeur de Billets", color: 2, sprite: 434, size: 0.80, Pos: {x: -821.17, y: -1083.29, z: 11.1324}},
    {name: "Distributeur de Billets", color: 2, sprite: 434, size: 0.80, Pos: {x: 1686.4, y: 4816.36, z: 42.0092}},
    {name: "Distributeur de Billets", color: 2, sprite: 434, size: 0.80, Pos: {x: -95.90, y: 6455.62, z: 31.45}},
    {name: "Pacific Banque", color: 2, sprite: 605, size: 0.80, Pos: {x: 227.49, y: 212.99, z: 105.53}},
    {name: "Pawn Shop", color: 12, sprite: 587, Pos: {x: 105.43, y: 9.43, z: 67.86}},
    {name: "Hôpital Los Santos", color: 5, sprite: 61, Pos: {x: -1858.35, y: -324.27, z: 53.77}},
    {name: "LSFD", color: 1, sprite: 61, Pos: {x: 1196.3460, y: -1479.672851, z: 29.39}},
    {name: "Mécano", color: 3, sprite: 777, Pos: {x: -351.73, y: -120.49, z: 38.43}},
    {name: "Benny's", color: 63, sprite: 488, size: 1.05, Pos: {x: -207.31, y: -1305.09, z: 31.36}},
    {name: "Weazel News", color: 2, sprite: 184, Pos: {x: -582.75, y: -927.19, z: 36.83}},
    {name: "Taxi", color: 5, sprite: 198, Pos: {x: 909.18, y: -179.6, z: 74.17}},
    {name: "Coiffeur", color: 64, sprite: 71, Pos: {x: 138.25, y: -1709.13, z: 29.42}},
    {name: "Barber", color: 64, sprite: 71, Pos: {x: -36.48, y: -155.96, z: 57.07}},
    {name: "Ponsonbys", color: 64, sprite: 366, Pos: {x: -716.84, y: -156.75, z: 36.98}},
    {name: "Binco", color: 64, sprite: 366, Pos: {x: -829.413, y: -1073.710, z: 10.328}},
    {name: "Agence immobilière", color: 64, sprite: 492, Pos: {x: -707.79388, y: 269.2157, z: 94.2941}},
    {name: "Burger Shot", color: 75, sprite: 106, Pos: {x: -1182.10, y: -883.58, z: 13.78}},
    {name: "LTD Davis", color: 3, sprite: 59, Pos: {x: 30.42, y: -1345.17, z: 29.5}},       
    {name: "LTD Grove Street", color: 3, sprite: 59, Pos: {x: -49.9785, y: -1753.45, z: 29.42}},        
    {name: "Le Pearls", color: 3, sprite: 267, Pos: {x: -1825.48, y: -1190.6, z: 14.44}}, 
    {name: "Galaxy Club", color: 83, sprite: 614, Pos: {x: 356.18, y: 304.66, z: 103.72}},
    {name: "Bahama's", color: 83, sprite: 766, Pos: {x: -1394.71, y: -608.88, z: 30.32}},
    {name: "Gouvernement", color: 0, sprite: 419, Pos: {x: -1296.13, y: -575.13, z: 30.56}},
    {name: "DOJ", color: 0, sprite: 419, Pos: {x: -544.45, y: -205.01, z: 38.214}},
    {name: "Armurerie - Los Santos", color: 49, sprite: 313, Pos: {x: 812.04, y: -2145.56, z: 29.33}},
    {name: "Stand de tir", color: 49, sprite: 458, Pos: {x: 17.3187, y: -1105.2624, z: 29.7969}},
    {name: "Tequi-la-la", color: 5, sprite: 93, size: 0.80, Pos: {x: -557.66, y: 283.59, z: 82.08}},
    {name: "Cabinet Hermerion", color: 25, sprite: 805, Pos: {x: -1038.0477, y: -411.1166, z: 39.27}},
    {name: "Salon de tatouage", color: 1, sprite: 75, Pos: {x: -1149.7503, y: -1428.5909, z: 3.95}},
    {name: "Salon de tatouage el burro", color: 1, sprite: 75, Pos: {x: 1323.7127, y: -1652.8209, z: 3.95}},
    {name: "Coiffeur Mirror Park", color: 64, sprite: 71, Pos: {x: 1212.6756, y: -472.9996, z: 3.95}},
    {name: "Post OP", color: 21, sprite: 616, Pos: {x: 1218.5623, y: -3274.3474, z: 29.7969}},
    {name: "Bar - San-Inn", color: 59, sprite: 93, Pos: {x: -172.66, y: 291.57, z: 92.76}}
];

const markerIcons = [
    40,
    50,
    162,
    163,
    164,
    225,
    523,
    475,
    492,
    525,
    568,
    590,
    617,
    744
];