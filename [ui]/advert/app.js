$(document).ready(function(){ 
	var audio = new Audio('/html/Phone_Call_Sound_Effect.ogg');

	function ShowNotifs(query) {
		var img = query.url;
		
		$("#notif").css("display", "block");
		if (img !== 'undefined' && img !== undefined) {
            console.log(img);
    
            $('#pic').show();
            $('#pic').attr('src', ''+img+'');
            $('#pic').attr("display", "block");
		}
		else{
			$('#pic').css("display", "none");
		}
			
		var text = query.message;
		var author = query.author;
		$('#author').text("@"+author.replace(' ', '_'));
		$('#msg').text(text);
		query.message = "";
		query.author = "";
		query.url = "";
		query.foot = "";
			
	
		setTimeout(ShowNotifsOff, 10000,query)

	}
	
	function ShowNotifsOff(query) {

		$("#notif").css("display", "none");



	}
	

	function encode_utf8(s) {
		return unescape(encodeURIComponent(s));
	}
	
	function decode_utf8(s) {
		return decodeURIComponent(escape(s));
	}
	window.addEventListener('message', function(event){ // NUI EVENEMENT
        var item = event.data;


		if (item.showNew === true) {

			ShowNotifs(event.data.data)
		}
		
	});
});

