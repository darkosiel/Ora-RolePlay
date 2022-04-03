
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
				$(".origine").last().html( event.data.data.data.identity.origine);
				$(".birth").last().html( event.data.data.data.identity.birth_date);

				$(".number").last().html( event.data.data.data.identity.serial);
				$(".sex").last().html( event.data.data.data.identity.male);

				$('.pic'). attr("src", event.data.data.data.identity.face_picutre);


				$('.im'). attr("src", "https://i.ibb.co/6RtLnFy/id.png");
				break
			case 'hide':
				$('body').css('opacity', '0.0')
		}
	})
})

