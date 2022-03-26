
$(function () {
	window.addEventListener('message', function (event) {
		console.log(event)
		switch (event.data.action) {
			case 'showHint':
				$('#hint').html("")
				$('body').css('display', 'block')
				$('#hint').html(event.data.data)
				$('#rewardNumber').html(event.data.rewardNumber)
				break
			case 'hide':
				$('body').css('display', 'none')
		}
	})
})