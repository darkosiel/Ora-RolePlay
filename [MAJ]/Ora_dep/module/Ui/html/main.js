
$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'showCards':
				this.console.log()
				$('body').css('opacity', '1.0')
				
				$('.numbeeer').text(JSON.stringify(event.data.data.number).replace(/(.{4})/g, '$1 ').trim())
				$('.auhtooor').text(event.data.data.name.toUpperCase())
				$('.credit-card-wrap').css('background-image','url(img/'+event.data.data.type+'.png)')
				break
			case 'hide':
				$('body').css('opacity', '0.0')
		}
	})
})