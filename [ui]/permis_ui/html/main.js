function GetType(name) {
	switch(name) {
		case "permis-conduire-moto":
			return "Moto"
		break
		case "permis-conduire-pl":
			return "Poid-lourd"
		break
		default:
			return "Voiture"
		break
	}
}


$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'showCards':
				this.console.log()
				$('body').css('opacity', '1.0')
				if (event.data.data.data.identity.first_name != undefined) {
					event.data.data.data.identityS = event.data.data.data.identity.first_name + " " + event.data.data.data.identity.last_name
				}
				$(".name").last().html( event.data.data.data.identityS);
				$(".origine").last().html( event.data.data.data.points);
				$(".birth").last().html( event.data.data.data.uid);
				$(".type").last().html(`Type: ${GetType(event.data.data.name)}`);


				$('.pic'). attr("src", event.data.data.data.identity.face_picutre);


				$('.im'). attr("src", "https://i.ibb.co/vBSbHtK/permis.png");
				break
			case 'hide':
				$('body').css('opacity', '0.0')
		}
	})
})

