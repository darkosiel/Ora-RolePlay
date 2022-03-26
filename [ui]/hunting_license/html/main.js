
$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'showCards':
				this.console.log()
				$('body').css('opacity', '1.0')
				if (event.data.data.data.identity.first_name != undefined) {
					event.data.data.data.identity = event.data.data.data.identity.first_name + " " + event.data.data.data.identity.last_name
				}
				$(".name").last().html(event.data.data.data.identity);
				$(".origine").last().html( event.data.data.data.uid);

				$('.pic'). attr("src", event.data.data.data.identity.face_picutre);


				$('.im'). attr("src", "https://atlantiss-rp.com/prodImages/id-hunting.png");
				break
			case 'hide':
				$('body').css('opacity', '0.0')
		}
	})
})

