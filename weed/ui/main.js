var waterCount = 0;
var fertzCount = 0;

var data;
$(function () {
	window.addEventListener('message', function (event) {
		if (event.data.action == "setData") {
			waterCount = event.data.water
			fertzCount = event.data.fertz
		}
		if (event.data.action == "data") {
			data =  event.data.data;
			$(".water-done").css('width', event.data.data.water+"%");
			$(".status-done").css('width', event.data.data.percent+"%");
			$(".fertilization-done").css('width', event.data.data.fertz+"%");
		}
		if (event.data.action == "showUI") {
			this.console.log(JSON.stringify(event.data.data))
			$('#main').show()
			$('#stats').show()
			data =  event.data.data;
			$(".water-done").css('width', event.data.data.water+"%");
			$(".status-done").css('width', event.data.data.percent+"%");
			$(".fertilization-done").css('width', event.data.data.fertz+"%");

			$(".status-done").css('opacity', "1");

			$(".water-done").css('opacity', "1");

			$(".fertilization-done").css('opacity', "1");
			waterCount = event.data.items.water;
			fertzCount = event.data.items.fertz
		}
		if (event.data.action == "hide") {
			$('#main').hide()
			$('#stats').hide()
		}
	})
})

$(".drop").click(function() {
	if (waterCount > 0 && data.water + 25 <= 100) {
		waterCount = waterCount - 1
		$.post('http://weed/waterize')
	}
});

$(".purify").click(function() {
	if (fertzCount > 0 && data.fertz + 10 <= 100) {
		fertzCount = fertzCount - 1
		$.post('http://weed/purifizer')
	}
});

$(".weed").click(function() {
	if (data.percent == 100) {
		$.post('http://weed/harvest')
	}
});
$(this).on('keypress', function(event) {
	if (event.keyCode==108 ) {
		$.post('http://weed/exit')
	}

})