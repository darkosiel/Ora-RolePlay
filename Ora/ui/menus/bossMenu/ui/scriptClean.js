let selected = 0
var currentUI = ""
let select = null
let select_paycheck = null
let book_select_type = null
let book_select_tag = null
let selected_bill = -1
let id_bp_offers_selected = -1
let selected_job_offer = -1
let selected_job_request = -1
let selected_busi_job_offer = -1
let selected_busi_book  = -1
let id_pound_busi = -1
let last_reset_busi_prod = null
let current_busi = null
let loading_state = false
let current_selected = null
let job_select_busi = null
let job_seclect_offers = null
let busi_offers_reqs = null
let is_request_from = false
let is_medic = false

$(function(){

	//////////////////////////////////////////
	//              FUNCTIONS               //
	//////////////////////////////////////////

	function resetData() {
		// this a 100% memory optimization
		selected = 0
		currentUI = ""
		select = null
		select_paycheck = null
		book_select_type = null
		book_select_tag = null
		selected_bill = -1
		id_bp_offers_selected = -1
		selected_job_offer = -1
		selected_job_request = -1
		selected_busi_job_offer = -1
		last_reset_busi_prod = null
		current_busi = null
		loading_state = false
		current_selected = null
		job_select_busi = null
		job_seclect_offers = null
		busi_offers_reqs = null
		is_request_from = false
		is_medic = false
	}

	// loading screen
	function activateLoading() {
		$("#jobUI").prop('disabled',true)
		$("#jobUI").children().prop('disabled',true)
		$("#load").css('display', "block")
		loading_state = true
	}

	function disableLoading() {
		$("#jobUI").prop('enabled',true)
		$("#jobUI").children().prop('enabled',true)
		$("#load").css('display', "none")
		loading_state = false
	}

	function initBusiBills() {
		selected_bill = -1
		$('#bill_sender').attr('placeholder', "")
		$('#bill_receiver').attr('placeholder', "")
		$('#bill_time').attr('placeholder', "")
		$('#bill_type').attr('placeholder', "")
		$('#bill_retry').attr('placeholder', "")
		$('#bill_amount').attr('placeholder', "")
		$('#bill_msg').attr('placeholder', "")
		$('#bill_method').attr('placeholder', "")
		//document.getElementById("bill_state").innerHTML = "STATUS"
		//document.getElementById('bill_state').style.backgroundColor = "#4CAF50"
	}

	function checkMyRequestsIndex(){
		if(selected_job_request != -1){
			try {
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('my_job_request_'+selected_job_request).style.backgroundColor = ''
			} catch (e) {
				$.post('http://Atlantiss/log', JSON.stringify({log: "checkMyRequestsIndex" + e}))
			} finally {
			   selected_job_request = -1
			}
		}
	}

	function showRequestForm(table_id){
		let offer_job = job_seclect_offers[table_id]
		$('#request_form').css('display', 'block')
		$('#jobselector').css('display', 'none')
		$('#resquest_form_busi').attr('placeholder', offer_job.name)
		$('#resquest_form_creator').attr('placeholder', offer_job.creator)
		$('#resquest_form_title').attr('placeholder', offer_job.title)
		$('#resquest_form_desc').attr('placeholder', offer_job.desc)
		$("#request_form_msg").val("")
		is_request_from = true
	}

	function closeRequestForm(){
		$('#jobselector').css('display', 'block')
		$('#request_form').css('display', 'none')
		is_request_from = false
	}

	function numberWithSpaces(int) {
    return int.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ")
	}

	function initJobRequests(){
		checkMyRequestsIndex()
		$('#jobselect_request_job_tilte').attr('placeholder', "")
		$('#jobselect_request_busi').attr('placeholder', "")
		$('#jobselect_request_rank').attr('placeholder', "")
		$('#jobselect_request_paycheck').attr('placeholder', "")
		$('#jobselect_request_desc').attr('placeholder', "")
		$('#jobselect_request_time').attr('placeholder', "")
		$('#jobselect_request_msg').attr('placeholder', "")
		document.getElementById("jobselect_request_state").innerHTML = "STATUS"
		document.getElementById('jobselect_request_state').style.backgroundColor = "#4CAF50"
	}

	// clear gov events
	function clearGovEvents() {
	    $("#setgovernor").off("click")
	    $("#setvice_governor").off("click")
	    $("#setpolice_rank_1").off("click")
	    $("#setpolice_rank_2").off("click")
	    $("#setpolice_rank_3").off("click")
	    $("#setpolice_rank_4").off("click")
	    $("#setpolice_rank_5").off("click")
	    $("#setpolice_rank_6").off("click")
	    $("#setpolice_rank_7").off("click")
	    $("#setemergency_rank_1").off("click")
	    $("#setemergency_rank_2").off("click")
	    $("#setemergency_rank_3").off("click")
	    $("#setemergency_rank_4").off("click")
	    $("#setemergency_rank_5").off("click")
	    $("#setemergency_rank_6").off("click")
	    $("#setemergency_rank_7").off("click")
	    $("#setfbi_rank_1").off("click")
	    $("#setfbi_rank_2").off("click")
	    $("#setfbi_rank_3").off("click")
	    $("#setfbi_rank_4").off("click")
	    $("#setfbi_rank_5").off("click")
	    $("#setfbi_rank_6").off("click")
	    $("#setfbi_rank_7").off("click")
	    $("#setsheriff_rank_1").off("click")
	    $("#setsheriff_rank_2").off("click")
	    $("#setsheriff_rank_3").off("click")
	    $("#setsheriff_rank_4").off("click")
	    $("#setsheriff_rank_5").off("click")
	    $("#setsheriff_rank_6").off("click")
	    $("#setsheriff_rank_7").off("click")
	    $("#setgov_help").off("click")
	    $("#setgov_salary_help").off("click")
	    $("#setunemployee_tax").off("click")
	    $("#setsalary_tax").off("click")
	    $("#setgov_salary_tax").off("click")
	    $("#setbusi_startup_tax").off("click")
	    $("#setbusi_sarl_tax").off("click")
	    $("#setbusi_pme_tax").off("click")
	    $("#setbusi_big_tax").off("click")
	    $("#setbusi_modify_tax").off("click")
	    $("#setbusi_create_tax").off("click")
	    $("#setbasic_house_tax").off("click")
	    $("#setconfort_house_tax").off("click")
	    $("#setrich_house_tax").off("click")
	    $("#setjustice_tax").off("click")
	    $("#setnew_ident_tax").off("click")
	    $("#setcar_learn_tax").off("click")
			$("#setweapon_learn_tax").off("click")
	    $("#setweapon_buy_tax").off("click")
	    $("#setcar_buy_tax").off("click")
	    $("#setdiv_buy_tax").off("click")
	    $("#setfood_buy_tax").off("click")
	    $("#setjuge_rank_1").off("click")
	    $("#setpound_tax").off("click")
	}

	function clearBusiSalEvents() {
	    $("#set_busi_paycheck_rank_0").off("click")
	    $("#set_busi_paycheck_rank_1").off("click")
	    $("#set_busi_paycheck_rank_2").off("click")
	    $("#set_busi_paycheck_rank_3").off("click")
	    $("#set_busi_paycheck_rank_4").off("click")
	    $("#set_busi_paycheck_rank_5").off("click")
			$("#set_busi_paycheck_rank_6").off("click")
	}

	function checkOffersIndex(){
		if(selected_job_offer != -1){
			try {
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('busi_job_offers_'+selected_job_offer).style.backgroundColor = ''
			} catch (e) {
				$.post('http://Atlantiss/log', JSON.stringify({log: "checkOffersIndex" + e}))
			} finally {
			   selected_job_offer = -1
			}
		}
	}

	function clearOldOffers(){
		checkOffersIndex()
		activateLoading()
		// he for each dynamically created block
		// we will cancel click events and remove divs
		$("[id^='job_selector_getpost_']").each(function(){
		 	let id = "#" + $(this).attr('id')
		 	//$.post('http://Atlantiss/log', JSON.stringify({log: "DESACTIVATION CLICK " + id}))
		 	$(id).off("click")
		 	// test disable
		 	$(id).click()
		})
		// .off("click")
		$("[id^='job_selector_offer_div_']").each(function(){
		 	let id = "#" + $(this).attr('id')
		 	//$.post('http://Atlantiss/log', JSON.stringify({log: "SUPRESSION DIV " + id}))
		 	$(id).remove()
		})
		disableLoading()
	}

	function checkBusiOffersIndex(){
		if(selected_busi_job_offer != -1){
			try {
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('busi_offer_'+selected_busi_job_offer).style.backgroundColor = ''
			} catch (e) {
				$.post('http://Atlantiss/log', JSON.stringify({log: "checkBusiOffersIndex" + e}))
			} finally {
			   selected_busi_job_offer = -1
			}
		}
	}

	function eventPlayerBusi(){
		$(".player").off("click")
		$(".player").click(function(){
			let id = $(this).attr('id').replace('player_', '')
			let _prod = $(this).data('prod')
			let _sal = $(this).data('salary_sal')
			let _rank = $(this).data('rank')
			//$.post('http://Atlantiss/log', JSON.stringify({log: $(this).data('rank')}))
			selected = parseInt(id)

			$('.player').removeClass('selected')
			$(this).addClass('selected')
			current_selected = $(this)

			document.getElementById("busi_rank").innerHTML = "Rang : " + _rank
			//document.getElementById("busi_productivity").innerHTML = "Productivité : $" + _prod + " (dernier reset le : " + last_reset_busi_prod + ")"
			document.getElementById("busi_productivity").innerHTML = _prod == undefined || _prod == null ? "Veuillez fermer puis réouvrir votre menu patron pour charger la productivité." : _prod
			//document.getElementById("busi_paycheck_sal").innerHTML = "Salaire : " + _sal
			_sal == 0 ? $('#busi_paycheck_sal').text('Salaire : $0') : $('#busi_paycheck_sal').text('Salaire : $'+_sal+'')

			if(_prod != undefined){
				if(_prod.includes("$0") || _prod.includes("$-")){
					document.getElementById('busi_productivity').style.backgroundColor = '#B31F1F'
				}else {
					document.getElementById('busi_productivity').style.backgroundColor = ''
				}
			}


			$('#exist_busi_salaries').find('h1').text($(this).text())
			$('#notexist_busi_salaries').css('display', 'none')
			$('#exist_busi_salaries').css('display', 'block')
		})
	}

	function clearOldBusiOffers(){
		checkBusiOffersIndex()
		activateLoading()
		$('#busi_purpose_title').attr('placeholder', "")
		$('#busi_purpose_date').attr('placeholder', "")
		$('#busi_purpose_rank').attr('placeholder', "")
		$('#busi_purpose_paycheck').attr('placeholder', "")
		$('#busi_purpose_desc').attr('placeholder', "")

		// he for each dynamically created block
		// we will cancel click events and remove divs
		$("[id^='busi_offers_offer_button_']").each(function(){
		 	let id = "#" + $(this).attr('id')
		 	//$.post('http://Atlantiss/log', JSON.stringify({log: "DESACTIVATION CLICK " + id}))
		 	$(id).off("click")
		 	// test disable
		 	$(id).click()
		})
		// .off("click")
		$("[id^='busi_offers_offer_req_div_']").each(function(){
		 	let id = "#" + $(this).attr('id')
		 	//$.post('http://Atlantiss/log', JSON.stringify({log: "SUPRESSION DIV " + id}))
		 	$(id).remove()
		})
		disableLoading()
	}

	function checkBusiBillIndex(){
		if(selected_bill != -1){
			try {
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('bill_'+selected_bill).style.backgroundColor = ''
			} catch (e) {
				$.post('http://Atlantiss/log', JSON.stringify({log: "checkBusiBillIndex" + e}))
			} finally {
			   selected_bill = -1
			}
		}
	}

	function initTickJobOffers(){
		$(".tick").off("click")
		$(".tick").click(function(){
			let id = $(this).attr('id').replace('busi_job_offers_', '')
			//$.post('http://Atlantiss/log', JSON.stringify({log: "LALA "+ id}))
			
			if(selected_job_offer != -1){
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('busi_job_offers_'+selected_job_offer).style.backgroundColor = ''
			}

			clearOldOffers()
			selected_job_offer = parseInt(id)

			// remove old offers
			let job_state
			let job_name			
			for(let i in job_seclect_offers){
				let offer_job = job_seclect_offers[i]
				//$.post('http://Atlantiss/log', JSON.stringify({log: "BIBI " + offer_job.bus_id + " "+ id}))
				if (offer_job.bus_id === parseInt(id)){

					if (offer_job.rank == 0) {
						job_state = "IMMEDIAT"
						job_name = "Intérimaire"
					} else {
						job_state = "CANDIDATURE"
						job_name = "Salarié rang " + offer_job.rank
					}

					// creat offer block for each offers
					$('#job_offers_range').append('<div id="job_selector_offer_div_'+ offer_job.id + '" class="panel3"><h1>Présentation de l\'offre</h1>' +
					'<p class="status">Emploie : <span id="jobselect_state_'+ offer_job.id + '" class="status"></span></p><div class="set"><label>Entrprise</label>' +
					'<input id="jobselect_buisness_'+ offer_job.id + '" type="text" placeholder=""  disabled></input></div><div class="group_set">' +
					'<label>Date</label><input id="jobselect_date_'+ offer_job.id + '" type="text" placeholder=""  disabled></input></div><div class="group_set">' +
					'<label>Poste</label><input id="jobselect_rank_'+ offer_job.id + '" type="text" placeholder=""  disabled></input><label>Salaire</label>' +
					'<input id="jobselect_salary_'+ offer_job.id + '" type="text" placeholder=""  disabled></input><label>Secteur</label>' +
					'<input id="jobselect_jobs_'+ offer_job.id + '" type="text" placeholder=""  disabled></input><label>Contact</label>' + 
					'<input id="jobselect_contact_'+ offer_job.id + '" type="text" placeholder=""  disabled></input></div><div class="set"><label>Description</label>' +
					'<textarea id="jobselect_desc_'+ offer_job.id + '" type="text" placeholder=""  disabled></textarea></div><div class="group_set">' + 
					'<button class="quick" id="job_selector_getpost_'+ offer_job.id + '" data-offer_table="'+i+'">Postuler</button></div></div>')

				
					document.getElementById("jobselect_state_"+ offer_job.id).innerHTML = job_state
					if(job_state === "IMMEDIAT"){
						document.getElementById("jobselect_state_"+ offer_job.id).style.backgroundColor = '#4CAF50'
					} else if(job_state === "CANDIDATURE"){
						document.getElementById("jobselect_state_"+ offer_job.id).style.backgroundColor = '#F5B022'
					}
					$('#jobselect_buisness_'+ offer_job.id).attr('placeholder', offer_job.name)
					$('#jobselect_date_'+ offer_job.id).attr('placeholder', offer_job.date)
					$('#jobselect_rank_'+ offer_job.id).attr('placeholder', job_name)
					$('#jobselect_salary_'+ offer_job.id).attr('placeholder', offer_job.sal + " $")
					$('#jobselect_jobs_'+ offer_job.id).attr('placeholder', offer_job.sector)
					$('#jobselect_contact_'+ offer_job.id).attr('placeholder', offer_job.creator)
					$('#jobselect_desc_'+ offer_job.id).attr('placeholder', offer_job.desc)

					$("#job_selector_getpost_"+ offer_job.id).click(function(){
						id_bp_offers_selected = $(this).attr('id')
						let table_id = $(this).data('offer_table')
						//$.post('http://Atlantiss/log', JSON.stringify({log: "BOUTON " + id_bp_offers_selected + " CLICK EVENT !!"}))
						// rework id
						id_bp_offers_selected = parseInt(id_bp_offers_selected.replace('job_selector_getpost_', ''))
						if(job_seclect_offers[table_id].rank == 0){
							// immediat job no need to made a request
							$.post('http://Atlantiss/set_job_search', JSON.stringify({type: "immediat_job", param: job_seclect_offers[table_id].bus_id, value : id_bp_offers_selected}))
							activateLoading()
						} else {
							showRequestForm(table_id)
						}
					})
				}
			}

			document.getElementById('busi_job_offers_'+selected_job_offer).style.backgroundColor = '#428BCA'
		})
	}

	function initTickJobRequest(){
		$(".tick").off("click")
		$(".tick").click(function(){
			let id = $(this).attr('id').replace('my_job_request_', '')
			//$.post('http://Atlantiss/log', JSON.stringify({log: "MY REQUEST "+ id}))

			if(selected_job_request != -1){
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('my_job_request_'+selected_job_request).style.backgroundColor = ''
			}

			selected_job_request = parseInt(id)

			let rank = $(this).data('rank')
			if (rank == 0) {
				job_name = "Intérimaire"
			} else {
				job_name = "Salarié rang " + rank
			}

			$('#jobselect_request_busi').attr('placeholder', $(this).data('busi_name'))
			$('#jobselect_request_job_tilte').attr('placeholder', $(this).data('title'))
			$('#jobselect_request_rank').attr('placeholder', job_name)
			$('#jobselect_request_paycheck').attr('placeholder', $(this).data('paycheck'))
			$('#jobselect_request_desc').attr('placeholder', $(this).data('busi_desc'))
			$('#jobselect_request_time').attr('placeholder', $(this).data('date'))
			$('#jobselect_request_msg').attr('placeholder', $(this).data('msg'))

			let state = $(this).data('state')
			document.getElementById("jobselect_request_state").innerHTML = state
			if(state === "ATTENTE"){
				document.getElementById('jobselect_request_state').style.backgroundColor = '#F5B022'
			} else if(state === "REFUSE"){
				document.getElementById('jobselect_request_state').style.backgroundColor = '#B31F1F'
			}

			document.getElementById('my_job_request_'+selected_job_request).style.backgroundColor = '#428BCA'
		})
	}

	function initTickBusiBills(){
		$(".tick").off("click")
		$(".tick").click(function(){
			let id = $(this).attr('id').replace('bill_', '')

			if(selected_bill != -1){
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('bill_'+selected_bill).style.backgroundColor = ''
			}

			selected_bill = parseInt(id)
			$('#bill_sender').attr('placeholder', $(this).data('sender'))
			$('#bill_receiver').attr('placeholder', $(this).data('receiver'))
			$('#bill_time').attr('placeholder', $(this).data('time'))
			/* let type = $(this).data('type')
			if(type === "IN"){
				$('#bill_type').attr('placeholder', "ENTREE")
			}else {
				$('#bill_type').attr('placeholder', "SORTIE")
			}
			$('#bill_retry').attr('placeholder', $(this).data('retry')) */
			$('#bill_amount').attr('placeholder', "$"+numberWithSpaces($(this).data('amount')))
			$('#bill_msg').attr('placeholder', $(this).data('msg'))
			$('#bill_method').attr('placeholder', $(this).data('method'))

			$('#bill_'+selected_bill).css("background-color", "rgba(65, 179, 79, 0.5)")
		})
	}


	function initTickBusiOffers(){
		$(".tick").off("click")
		$(".tick").click(function(){
			let id = $(this).attr('id').replace('busi_offer_', '')
			clearOldBusiOffers()
			$('#busi_purpose_title').attr('placeholder', $(this).data('title'))
			$('#busi_purpose_date').attr('placeholder', $(this).data('date'))
			$('#busi_purpose_rank').attr('placeholder', $(this).data('rank'))
			$('#busi_purpose_paycheck').attr('placeholder', $(this).data('paycheck') + " $")
			$('#busi_purpose_desc').attr('placeholder', $(this).data('desc'))

			if(selected_busi_job_offer != -1){
				// there is already a selection so we update it
				// by setting to empty color the element get the class color !
				document.getElementById('busi_offer_'+selected_busi_job_offer).style.backgroundColor = ''
			}


			selected_busi_job_offer = parseInt(id)
			activateLoading()
			for(let i in busi_offers_reqs){
				let req_job = busi_offers_reqs[i]
				//$.post('http://Atlantiss/log', JSON.stringify({log: "BIBI " + req_job.offer_id + " "+ selected_busi_job_offer}))
				if (req_job.offer_id === selected_busi_job_offer){
					//$.post('http://Atlantiss/log', JSON.stringify({log: "BIBI CREATE DIV"}))

					// creat offer block for each offers
					$('#busi_offers').append('<div id="busi_offers_offer_req_div_'+ req_job.id + '" class="panel3"><h1>Candidature</h1><div class="group_set"><label>Candidat</label>' +
						'<input id="busi_offers_offer_req_name_'+ req_job.id + '" type="text" placeholder=""  disabled></input></div><div class="group_set"><label>Telephone</label>' + 
						'<input id="busi_offers_offer_req_tel_'+ req_job.id + '" type="text" placeholder=""  disabled></input>' + 
						'</div><div class="group_set"><label>Date</label><input id="busi_offers_offer_req_time_'+ req_job.id + '" type="text" placeholder=""  disabled></input>' +
						'</div><div class="set"><label>Lettre de motivation</label><textarea id="busi_offers_offer_req_msg_'+ req_job.id + '" type="text" placeholder=""  disabled></textarea></div>' +
						'<div class="set"><button class="quick" id="busi_offers_offer_button_tel_'+ req_job.id + '" data-user_id="'+req_job.user_id+'">Ajouter N° TEL</button><button class="quick" id="busi_offers_offer_button_ok_'+ req_job.id 
						+ '" data-user_id="'+req_job.user_id+'">Embaucher</button><button class="quick" id="busi_offers_offer_button_nok_'+ req_job.id + '" data-user_id="'+req_job.user_id+'">Refuser</button></div></div>')

					
					$('#busi_offers_offer_req_name_'+ req_job.id).attr('placeholder', req_job.name)
					$('#busi_offers_offer_req_tel_'+ req_job.id).attr('placeholder', req_job.tel)
					$('#busi_offers_offer_req_time_'+ req_job.id).attr('placeholder', req_job.date)
					$('#busi_offers_offer_req_msg_'+ req_job.id).attr('placeholder', req_job.msg)
					

					$("#busi_offers_offer_button_tel_"+ req_job.id).click(function(){
						let id_bp = $(this).attr('id')
						let short_id = $(this).attr('id').replace('busi_offers_offer_button_tel_', '')
						//$.post('http://Atlantiss/log', JSON.stringify({log: "BOUTON TEL " + id_bp + " CLICK EVENT !!"}))
						//$.post('http://Atlantiss/log', JSON.stringify({log: "TEL INFO" + short_id + "  " + $("#busi_offers_offer_req_tel_" + short_id).attr('placeholder') + "  " + $("#busi_offers_offer_req_name_" + short_id).attr('placeholder')}))
						$.post('http://Atlantiss/busi_offers_action', JSON.stringify({type: 'tel', value: $("#busi_offers_offer_req_tel_" + short_id).attr('placeholder'), param: $("#busi_offers_offer_req_name_" + short_id).attr('placeholder')}))
						$(this).blur()
					})

					$("#busi_offers_offer_button_ok_"+ req_job.id).click(function(){
						let id_bp = $(this).attr('id')
						var user_id = $(this).attr('data-user_id')
						let short_id = $(this).attr('id').replace('busi_offers_offer_button_ok_', '')
						//$.post('http://Atlantiss/log', JSON.stringify({log: "BOUTON OK " + id_bp + " SHORT ID " + short_id +  " CLICK EVENT !! USER " + user_id}))
						$.post('http://Atlantiss/busi_offers_action', JSON.stringify({type: 'ok', value: short_id, param: user_id}))
						activateLoading()
						$(this).blur()
					})

					$("#busi_offers_offer_button_nok_"+ req_job.id).click(function(){
						let id_bp = $(this).attr('id')
						var user_id = $(this).attr('data-user_id')
						let short_id = $(this).attr('id').replace('busi_offers_offer_button_nok_', '')
						//$.post('http://Atlantiss/log', JSON.stringify({log: "BOUTON NOK " + id_bp + " SHORT ID " + short_id + " CLICK EVENT !! USER " + user_id}))
						$.post('http://Atlantiss/busi_offers_action', JSON.stringify({type: 'nok', value: short_id, param: user_id}))
						activateLoading()
						$(this).blur()
					})
				}
			}
			disableLoading()

			document.getElementById('busi_offer_'+selected_busi_job_offer).style.backgroundColor = '#428BCA'
		})
	}

	function cleanBusiSalaries() {
		$('.player').addClass('selected')

		if(current_selected != null ){
			current_selected.removeClass('selected')
			current_selected = null
		}
		//document.getElementById("busi_paycheck_sal").innerHTML = ""

		$('#exist_busi_salaries').find('h1').text("Selectionnez un.e employé.e")
		$('#notexist_busi_salaries').css('display', 'block')
		$('#exist_busi_salaries').css('display', 'none')

		$("#busi_prime_input").val("1")
		$('#busi_prime_input option:first-child').prop('selected', true)
		//$('#busi_rank_input').children().remove()
		$('#busi_rank_input').empty()
		$('#busi_rank_rib').val('ATL-')
		$("busi_rank").val("")
		$("#busi_productivity").val("")
	}

	function initBusiOffers(event) {
		clearOldBusiOffers()
		disableLoading()	

		let job_name
		busi_offers_reqs = event.data.offers_reqs
		$('#table_offers').empty()
		for(let i in event.data.offers){
			let offer = event.data.offers[i]
			if (offer.rank == 0) {
				job_name = "Intérimaire"
			} else {
				job_name = "Salarié rang " + offer.rank
			}
			$('#table_offers').append('<tr class="tick" id="busi_offer_' + offer.id + '" data-title="' + offer.title +  '" data-date="' + offer.date + '" data-rank="' 
				+ job_name + '" data-paycheck="' + offer.sal + '" data-desc="' + offer.desc +'"><td>' + offer.date + '</td><td>' + offer.title + '</td></tr>')
		}

		initTickBusiOffers()
	}

	function initJobSearch(event){
		job_select_busi = event.data.list_busi
		job_seclect_offers = event.data.list_offers

		$('#table_jobs').empty()
		clearOldOffers()

		$('#list_jobselect').empty()
		for(let i in event.data.list_sectors){
			let sector_job = event.data.list_sectors[i]
			//$.post('http://Atlantiss/log', JSON.stringify({log: "log " + sector_job.name}))
			$('#list_jobselect').append('<div class="player" id="job_offer_activity_' + sector_job.name + '">' + sector_job.name + '</div>')
		}
		$('#table_jobselect_request').empty()
		for(let i in event.data.list_requests){
			let request = event.data.list_requests[i]
			$('#table_jobselect_request').append('<tr class="tick" id="my_job_request_' + request.id + '" data-date="' + request.date +  '" data-msg="' + request.msg + '" data-state="' 
				+ request.state + '" data-busi_name="' + request.busi_name + '" data-title="' + request.title + '" data-rank="' + request.rank + '" data-paycheck="' + request.paycheck +
				 '" data-busi_desc="' + request.busi_desc +'"><td>' + request.date + '</td><td>' + request.busi_name + '</td><td>' + request.state + '</td></tr>')
		}

		$(".player").off("click")
		$(".player").click(function(){
			clearOldOffers()
			let id = $(this).attr('id').replace('job_offer_activity_', '')

			//$.post('http://Atlantiss/log', JSON.stringify({log: "PLAYER CLICKED "}))

			activateLoading()
			$('#table_jobs').empty()
			for(let i in job_select_busi){
				let busi_job = job_select_busi[i]
				//$.post('http://Atlantiss/log', JSON.stringify({log: "BABA " + busi_job.sector + " "+ id}))
				if (busi_job.sector === id){
					//$.post('http://Atlantiss/log', JSON.stringify({log: "BOBO " + busi_job.id + " "+ busi_job.name}))
					$('#table_jobs').append('<tr class="tick" id="busi_job_offers_' + busi_job.id +'"><td>' + busi_job.name + '</td></tr>')
				}
			}
			disableLoading()
			initTickJobOffers()

			$('.player').removeClass('selected')
			$(this).addClass('selected')

			$('#exist_jobselect').find('h1').text("Secteur d'activité : " + $(this).text())
			$('#notexist_jobselect').css('display', 'none')
			$('#exist_jobselect').css('display', 'block')

			//$.post('http://Atlantiss/log', JSON.stringify({log: "PLAYER FIN "}))
		})
	}

	//////////////////////////////////////////
	//          LUA EVENT MANAGER           //
	//////////////////////////////////////////

	window.addEventListener('message', function(event) {

		//////////////////////////////////////////
		//                  GOV                 //
		//////////////////////////////////////////
		
		if(event.data.type == "open_gov_menu"){
			currentUI="gov_menu"
			$('#notexist').css('display', 'block')
			$('#exist').css('display', 'none')
			$("#jobUI").css('display', "block")
			$("#gouverneur").css('display', "block")
			$('input').val("")

			$('.header-right h4').html("Budget de la ville : " + event.data.citymoney)
			$('.header-right h3').html("")
			document.getElementById("jobTitle").innerHTML = "Gouvernement"

			$('#list').empty()
			for(let i in event.data.players){
				let player = event.data.players[i]
				$('#list').append('<div class="player" id="player_' + player.id + '">' + player.name + '</div>')
			}
			for(let i in event.data.outgoings){
				let table = event.data.outgoings[i]
				$('#' + table.name).attr('placeholder', table.value)

				// manage button event
				$("#set" + table.name).click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "outgoings", user: -1, type: table.name, param: $("#" + table.name).val()})); $('#' + table.name).attr('placeholder', $("#" + table.name).val()); $(this).blur()})
			}
			for(let i in event.data.earnings){
				let table = event.data.earnings[i]
				$('#' + table.name).attr('placeholder', table.value)

				// manage button event
				$("#set" + table.name).click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "earnings", user: -1, type: table.name, param: $("#" + table.name).val()})); $('#' + table.name).attr('placeholder', $("#" + table.name).val()); $(this).blur()})
			}
			$(".player").click(function(){
				let id = $(this).attr('id').replace('player_', '')
				selected = parseInt(id)

				$('.player').removeClass('selected')
				$(this).addClass('selected')

				$('#exist').find('h1').text($(this).text())

				$('#notexist').css('display', 'none')
				$('#exist').css('display', 'block')
			})
		}
		if(event.data.type == "update_gov_menu"){
			$('.header-right h4').html("Budget de la ville : " + event.data.citymoney )
		}


		//////////////////////////////////////////
		//              JOB SEARCH              //
		//////////////////////////////////////////

		if(event.data.type == "open_job_search_menu"){
			disableLoading()
			currentUI="job_search_menu"
			$("#jobUI").css('display', "block")
			$('#jobselector').css('display', 'block')
			$("#select_jobselect_offert").click()
			$('#search_jobselect').css('display', 'block')
			$('#exist_jobselect').css('display', 'none')
			$('#notexist_jobselect').find('h1').text("Selectionner un secteur d'activité")
			$.post('http://Atlantiss/log', JSON.stringify({log: "ICI"}))

			$('.header-right h4').html("")
			$('.header-right h3').html("")
			document.getElementById("jobTitle").innerHTML = "GRAINCH'EMPLOI"

			initJobSearch(event)

			//initTickJobOffers()
			initJobRequests()
		}
		if(event.data.type == "update_job_search_menu"){
			disableLoading()

			initJobSearch(event)

			initJobRequests()
			initTickJobRequest()
		}
		if(event.data.type == "close_job_search_menu_request"){
			disableLoading()
			closeRequestForm()
		}
		if(event.data.type == "close_job_search_menu"){
			disableLoading()
			$("#jobUI").css('display', "none")
			$('#jobselector').css('display', 'none')
			$.post('http://Atlantiss/close_job_search_menu', JSON.stringify({}))
		}

		//////////////////////////////////////////
		//               BUSINESS               //
		//////////////////////////////////////////
		
		if (event.data.type == "open_business_menu") {
			$('#select_busi_treas').html('Trésorerie')
			disableLoading()
			initBusiBills()
			cleanBusiSalaries()
			selected_bill = -1
			last_reset_busi_prod = event.data.bus_prod_reset
			currentUI = "business_menu"
			$("#jobUI").css('display', "block")
			$("#entreprise").css('display', "block")
			$("#select_busi_salaries").click()
			$('input').val("")
			$('#table_bills').empty()
			$('#exist_busi_salaries').css('display', 'none')
			$('#notexist_busi_salaries').find('h1').text("Selectionnez un.e employé.e")

			$("#busi_prime_input").val("1")
			$('#busi_rank_input option[value="CDD"]').prop('selected', true)

			is_medic = event.data.medic_state

			if (event.data.isSelf) {
				$('.header-right h3').html("Auto-entrepreneur")
				$('.header-right h4').html("")
				$('#select_busi_treas').css('display', 'none')
				$('.selfStuff').css('display', 'none')
			} else {
				$('.header-right h3').html("Compte bancaire de l'entreprise : $" + numberWithSpaces(event.data.cap))
				$('.header-right h4').html("Trésorerie : $" + numberWithSpaces(event.data.treas))
				$('#select_busi_treas').css('display', 'inline-block')
				$('.selfStuff').css('display', 'inline-block')
			}

			document.getElementById("jobTitle").innerHTML = event.data.bus_name
			select = document.getElementById("bill-select")

			if (event.data.bus_name == "gouvernement") {
				$('#select_busi_treas').html('Trésorerie / Taxe')
			}

			initBusiOffers(event)

			$('#list_busi_salaries').empty()
			let arrRanks = event.data.bus_ranks
			if (event.data.isSelf) {
				for(let i in event.data.bus_sal){
					let salary = event.data.bus_sal[i]
					if (salary.uuid != event.data.plyUuid) continue
					let salaryRank
					let salarySlry
					if(salary.name == event.data.job_name){
						salaryRank = arrRanks[salary.rank-1]
					}else{
						salaryRank = arrRanks[salary.orga_rank-1]
					}
					for(let j = 0; j < event.data.bus_slry.length; j++){
						if(salaryRank == event.data.bus_slry[j][0]){
							salarySlry = event.data.bus_slry[j][1]
						}	
					}
					//$.post('http://Atlantiss/log', JSON.stringify({log: salary.first_name+" "+salary.name+" "+event.data.job_name+" "+salary.rank}))
					$('#list_busi_salaries').append('<div class="player" id="player_' + salary.sal_id + '" data-rank="' + salaryRank +'">' + salary.first_name + " " + salary.last_name  + '</div>')
					$('#list_busi_salaries .player').last().data("salary_name", {fname: salary.first_name, lname: salary.last_name})
					$('#list_busi_salaries .player').last().data("salary_uuid", salary.uuid)
					$('#list_busi_salaries .player').last().data("salary_sal", salarySlry)
					event.data.orgas ? $('#list_busi_salaries .player').last().data("salary_job", salary.orga) : $('#list_busi_salaries .player').last().data("salary_job", salary.name)
					$('#list_busi_salaries .player').last().data("salary_orga", salary.orga)
					$('#list_busi_salaries .player').last().data("job_title", event.data.job_name)
					$('#list_busi_salaries .player').last().data("prod", salary.prod)
				}
				$('#busi_prime_rib').val("ATL-")
				let firstRank = arrRanks.shift()
				$('#busi_rank_input').append('<option value="'+firstRank+'" selected>'+firstRank+'</option>')
				for(let i in arrRanks){
					$('#busi_rank_input').append('<option value="'+arrRanks[i]+'">'+arrRanks[i]+'</option>')
				}
				arrRanks = []
				
				eventPlayerBusi()
			} else {
				for(let i in event.data.bus_sal){
					let salary = event.data.bus_sal[i]
					let salaryRank
					let salarySlry
					if(salary.name == event.data.job_name){
						salaryRank = arrRanks[salary.rank-1]
					}else{
						salaryRank = arrRanks[salary.orga_rank-1]
					}
					for(let j = 0; j < event.data.bus_slry.length; j++){
						if(salaryRank == event.data.bus_slry[j][0]){
							salarySlry = event.data.bus_slry[j][1]
						}	
					}
					//$.post('http://Atlantiss/log', JSON.stringify({log: salary.first_name+" "+salary.name+" "+event.data.job_name+" "+salary.rank}))
					$('#list_busi_salaries').append('<div class="player" id="player_' + salary.sal_id + '" data-rank="' + salaryRank +'">' + salary.first_name + " " + salary.last_name  + '</div>')
					$('#list_busi_salaries .player').last().data("salary_name", {fname: salary.first_name, lname: salary.last_name})
					$('#list_busi_salaries .player').last().data("salary_uuid", salary.uuid)
					$('#list_busi_salaries .player').last().data("salary_sal", salarySlry)
					event.data.orgas ? $('#list_busi_salaries .player').last().data("salary_job", salary.orga) : $('#list_busi_salaries .player').last().data("salary_job", salary.name)
					$('#list_busi_salaries .player').last().data("salary_orga", salary.orga)
					$('#list_busi_salaries .player').last().data("job_title", event.data.job_name)
					$('#list_busi_salaries .player').last().data("prod", salary.prod)
				}
				$('#busi_prime_rib').val("ATL-")
				let firstRank = arrRanks.shift()
				$('#busi_rank_input').append('<option value="'+firstRank+'" selected>'+firstRank+'</option>')
				for(let i in arrRanks){
					$('#busi_rank_input').append('<option value="'+arrRanks[i]+'">'+arrRanks[i]+'</option>')
				}
				arrRanks = []
				
				eventPlayerBusi()
			}
		}
		if(event.data.type == "update_business_treas_menu"){
			$('.header-right h3').html("Trésorerie : " + event.data.treas)
		}
		if(event.data.type == "update_business_sal_menu"){
			disableLoading()
			cleanBusiSalaries()
			$('.header-right h3').html("Compte bancaire de l'entreprise : $" + numberWithSpaces(event.data.cap))
			$('.header-right h4').html("Trésorerie : $" + numberWithSpaces(event.data.treas))
			selected = ""
			$('.player').addClass('selected')

			$('#busi_rank_input').children().remove()
			$("#busi_prime_input").val("0")


			$('#list_busi_salaries').empty()
			let arrRanks = event.data.bus_ranks
			for(let i in event.data.bus_sal){
				let salary = event.data.bus_sal[i]
				let salaryRank
				let salarySlry
				if(salary.name == event.data.job_name){
					salaryRank = arrRanks[salary.rank-1]
				}else{
					salaryRank = arrRanks[salary.orga_rank-1]
				}
				for(let j = 0; j < event.data.bus_slry.length; j++){
					if(salaryRank == event.data.bus_slry[j][0]){
						salarySlry = event.data.bus_slry[j][1]
					}	
				}
				// $.post('http://Atlantiss/log', JSON.stringify({log: "log " + salary.name + " "+ salary.sal_id + " "+ salary.rank + " "+ salary.prod + " "+ salary.pay}))
				$('#list_busi_salaries').append('<div class="player" id="player_' + salary.sal_id + '" data-rank="' + salaryRank +'">' + salary.first_name + " " + salary.last_name  + '</div>')
				$('#list_busi_salaries .player').last().data("salary_name", {fname: salary.first_name, lname: salary.last_name})
				$('#list_busi_salaries .player').last().data("salary_uuid", salary.uuid)
				$('#list_busi_salaries .player').last().data("salary_sal", salarySlry)
				event.data.orgas ? $('#list_busi_salaries .player').last().data("salary_job", salary.orga) : $('#list_busi_salaries .player').last().data("salary_job", salary.name)
				$('#list_busi_salaries .player').last().data("job_title", event.data.job_name)
				$('#list_busi_salaries .player').last().data("prod", salary.prod)
			}
			$('#busi_prime_rib').val("ATL-")
			let firstRank = arrRanks.shift()
			$('#busi_rank_input').append('<option value="'+firstRank+'" selected>'+firstRank+'</option>')
			for(let i in arrRanks){
				$('#busi_rank_input').append('<option value="'+arrRanks[i]+'">'+arrRanks[i]+'</option>')
			}
			arrRanks = []
			
			eventPlayerBusi()
		}
		if(event.data.type == "business_disable_loading"){disableLoading()}
		/* if(event.data.type == "update_business_offers_menu"){
			initBusiOffers(event)
			disableLoading()

			$('.header-right h4').html("Capital de l'entreprise : " + numberWithSpaces(event.data.cap))
			$('.header-right h3').html("Trésorerie : " + event.data.treas)
			document.getElementById("jobTitle").innerHTML = event.data.bus_name

			$('#list_busi_salaries').empty()
			for(let i in event.data.bus_sal){
				let salary = event.data.bus_sal[i]
				// $.post('http://Atlantiss/log', JSON.stringify({log: "log " + salary.name + " "+ salary.sal_id + " "+ salary.rank + " "+ salary.prod + " "+ salary.pay}))
				$('#list_busi_salaries').append('<div class="player" id="player_' + salary.sal_id + '" data-rank="' + salary.rank +'" data-prod="' + salary.prod + '" data-salary_val="' + salary.pay + '">' + salary.name + '</div>')
			}

			select_paycheck = document.getElementById("paychek-select")
			select_paycheck.options.length = 0
			for(let i in event.data.paychecks){
				let paycheck = event.data.paychecks[i]
				//$.post('http://bloopis_admin/log', JSON.stringify({value: items.item}))
				var option = document.createElement("option")
				option.text = paycheck.name + " ["+ paycheck.pay + "$]"
				option.value = paycheck.rank
				option.innerHTML = paycheck.name + " ["+ paycheck.pay + "$]"
				select_paycheck.appendChild(option)
			}
		} */
		if(event.data.type == "update_business_bill_menu"){
			disableLoading()
			initBusiBills()
			$('#table_bills').empty()
			for(let i in event.data.bills){
				let bill = event.data.bills[i]
				bill.method = bill.method == undefined ? "Inconnue" : bill.method
				$('#table_bills').append('<tr class="tick" id="bill_' + bill.id + '" data-sender="' + bill.src + '" data-receiver="' + bill.dest + '" data-time="' + bill.time + '" data-msg="' + bill.reason + '" data-method="' + bill.method + '" data-amount="' + bill.amount + '"><td>' + bill.time + '</td><td>' + bill.dest + '</td><td>$' + numberWithSpaces(bill.amount) + '</td></tr>')
			}
			initTickBusiBills()
		}
	})

	//////////////////////////////////////////
	//            CLOSE ACTIONS             //
	//////////////////////////////////////////

	$(document).keyup(function(e) {
		if(e.keyCode == 27 && loading_state == false && is_request_from == false){
			$("#jobUI").css('display', 'none')
			if(currentUI == "gov_menu"){
				$("#gouverneur").css('display', "none")
				clearGovEvents()
			} else if(currentUI == "business_menu"){
				$("#entreprise").css('display', "none")
				clearBusiSalEvents()
			} else if(currentUI == "illness_menu"){
				$("#illnessbook").css('display', "none")
			} else if(currentUI == "business_creator_menu"){
				$("#createntreprise").css('display', "none")
			} else if(currentUI == "business_manag_menu"){
				$("#modifentreprise").css('display', "none")
			} else if(currentUI == "job_search_menu"){
				$("#jobselector").css('display', "none")
			} else if(currentUI == "business_book_menu"){
				$("#book_bill").css('display', "none")
			}else if (currentUI == "pound_menu"){
				$("#poundselect").css('display', "none")
			}

			$.post('http://Atlantiss/close_' + currentUI, JSON.stringify({}))
			resetData()
		}
	})

	$("#close").click(() => {
		if(loading_state == false && is_request_from == false){
			$("#jobUI").css('display', 'none')
			if(currentUI == "gov_menu"){
				$("#gouverneur").css('display', "none")
				clearGovEvents()
			} else if(currentUI == "business_menu"){
				$("#entreprise").css('display', "none")
				clearBusiSalEvents()
			} else if(currentUI == "illness_menu"){
				$("#illnessbook").css('display', "none")
			} else if(currentUI == "business_creator_menu"){
				$("#createntreprise").css('display', "none")
			} else if(currentUI == "business_manag_menu"){
				$("#modifentreprise").css('display', "none")
			} else if(currentUI == "job_search_menu"){
				$("#jobselector").css('display', "none")
			} else if(currentUI == "business_book_menu"){
				$("#book_bill").css('display', "none")
			}else if (currentUI == "pound_menu"){
				$("#poundselect").css('display', "none")
			}

			$.post('http://Atlantiss/close_' + currentUI, JSON.stringify({}))
			resetData()
		}
	})

	//////////////////////////////////////////
	//              GOV TAB                 //
	//////////////////////////////////////////

	$("#select_users").click(() => {
		$('#server').css('display', 'none')
		$('#weather').css('display', 'none')
		$('#users').css('display', 'block')
		$('#warning').css('display', 'none')
		$('#panel1').css('display', 'none')
		$('#panel2').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_users").addClass("selected")
		$("#select_users").blur()
	})

	$("#select_server").click(() => {
		$('#users').css('display', 'none')
		$('#server').css('display', 'block')
		$('#weather').css('display', 'none')
		$('#panel1').css('display', 'block')
		$('#panel2').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_server").addClass("selected")
		$("#select_server").blur()
	})

	$("#select_weather").click(() => {
		$('#server').css('display', 'none')
		$('#weather').css('display', 'block')
		$('#panel1').css('display', 'none')
		$('#panel2').css('display', 'block')
		$('#users').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_weather").addClass("selected")
		$("#select_weather").blur()
	})

	
	//////////////////////////////////////////
	//             BUSINESS TAB             //
	//////////////////////////////////////////

	$("#select_busi_salaries").click(() => {
		checkBusiOffersIndex()
		checkBusiBillIndex()
		eventPlayerBusi()
		$('#busi_salaries').css('display', 'block')
		$('#busi_bills').css('display', 'none')
		$('#busi_offer').css('display', 'none')
		$('#busi_offers').css('display', 'none')
		$('#busi_paycheck').css('display', 'none')
		$('#busi_treas').css('display', 'none')
		$('#panel3').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_busi_salaries").addClass("selected")
		$("#select_busi_salaries").blur()
	})

	$("#select_busi_treas").click(() => {
		$('#busi_treas').css('display', 'block')
		$('#busi_salaries').css('display', 'none')
		$('#busi_bills').css('display', 'none')
		$('#busi_offer').css('display', 'none')
		$('#busi_offers').css('display', 'none')
		$('#busi_paycheck').css('display', 'none')
		$('#panel3').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_busi_treas").addClass("selected")
		$("#select_busi_treas").blur()
	})

	$("#select_busi_offers").click(() => {
		checkBusiOffersIndex()
		checkBusiBillIndex()
		clearOldBusiOffers()
		initTickBusiOffers()
		$('#busi_offers').css('display', 'block')
		$('#busi_bills').css('display', 'none')
		$('#busi_offer').css('display', 'none')
		$('#busi_salaries').css('display', 'none')
		$('#busi_paycheck').css('display', 'none')
		$('#busi_treas').css('display', 'none')
		$('#panel3').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_busi_offers").addClass("selected")
		$("#select_busi_offers").blur()
	})

	$("#select_busi_offer").click(() => {
		checkBusiOffersIndex()
		checkBusiBillIndex()
		$('#busi_offer').css('display', 'block')
		$('#busi_bills').css('display', 'none')
		$('#busi_offers').css('display', 'none')
		$('#busi_salaries').css('display', 'none')
		$('#busi_paycheck').css('display', 'none')
		$('#busi_treas').css('display', 'none')
		$('#panel3').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_busi_offer").addClass("selected")
		$("#select_busi_offer").blur()
	})

	$("#select_busi_paycheck").click(() => {
		checkBusiOffersIndex()
		checkBusiBillIndex()
		if (is_medic == false){
			$('#busi_paycheck').css('display', 'block')
		}
		$('#busi_bills').css('display', 'none')
		$('#busi_offer').css('display', 'none')
		$('#busi_salaries').css('display', 'none')
		$('#busi_offers').css('display', 'none')
		$('#busi_treas').css('display', 'none')
		$('#panel3').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_busi_paycheck").addClass("selected")
		$("#select_busi_paycheck").blur()
	})

	$("#select_busi_bills").click(() => {
		checkBusiOffersIndex()
		checkBusiBillIndex()
		initBusiBills()
		initTickBusiBills()
		$('#busi_bills').css('display', 'block')
		$('#busi_offers').css('display', 'none')
		$('#busi_offer').css('display', 'none')
		$('#busi_salaries').css('display', 'none')
		$('#busi_paycheck').css('display', 'none')
		$('#busi_treas').css('display', 'none')
		$('#panel3').css('display', 'block')
		$(".tab").removeClass("selected")
		$("#select_busi_bills").addClass("selected")
		$("#select_busi_bills").blur()
	})


	//////////////////////////////////////////
	//            JOB SEARCH TAB            //
	//////////////////////////////////////////

	/* $("#select_jobselect_offert").click(() => {
		clearOldOffers()
		checkOffersIndex()
		initTickJobOffers()
		$('#search_jobselect').css('display', 'block')
		$('#jobselect_request').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_jobselect_offert").addClass("selected")
		$("#select_jobselect_offert").blur()
	})

	$("#select_jobselect_request").click(() => {
		initJobRequests()
		initTickJobRequest()
		$('#jobselect_request').css('display', 'block')
		$('#search_jobselect').css('display', 'none')
		$(".tab").removeClass("selected")
		$("#select_jobselect_request").addClass("selected")
		$("#select_jobselect_request").blur()
	}) */


	//////////////////////////////////////////
	//            BUTTONS EVENTS            //
	//////////////////////////////////////////

	$("#setgroup").click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "other", user: selected, type: 'group', param: $("#newgroup").val()})); $(this).blur()})
	$("#setkick").click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "other", user: selected, type: 'kick', param: $("#putkick").val()})); $(this).blur()})
	$("#setbank").click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "other", user: selected, type: 'bank', param: $("#newbank").val()})); $(this).blur()})
	$("#setrank").click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "other", user: selected, type: 'rank', param: $("#newrank").val()})); $(this).blur()})
	$("#allow_busi").click(function() {$.post('http://Atlantiss/set_gov', JSON.stringify({cat: "other", user: selected, type: 'allowBusiness', param: -1})); $(this).blur()})

	$("#busi_prime_button").click(()=>{
		$.post('http://Atlantiss/set_business', 
		JSON.stringify({
			type: 'prime', 
			rib: $("#busi_prime_rib").val(), 
			value: $(".player.selected").data("salary_name"), 
			amount: $("#busi_prime_input").val()
		}))
		activateLoading()
		$(this).blur()
	})
	$("#busi_rank_button").click(()=>{
		$.post('http://Atlantiss/set_business', 
		JSON.stringify({
			type: 'rank',
			name: $(".player.selected").data("salary_name"),
			uuid: $(".player.selected").data("salary_uuid"),
			actualRank: $(".player.selected").data("rank"),
			rank: $("#busi_rank_input").val(),
			job: $(".player.selected").data("salary_job"),
			actualJob: $(".player.selected").data("job_title"),
			orga: $(".player.selected").data("salary_orga")
		}))
		activateLoading()
		$(this).blur()
	})
	$("#busi_dismiss_button").click(()=>{
		$.post('http://Atlantiss/set_business', 
		JSON.stringify({
			type: 'dismiss',
			name: $(".player.selected").data("salary_name"),
			uuid: $(".player.selected").data("salary_uuid"),
			actualRank: $(".player.selected").data("rank"),
			job: $(".player.selected").data("salary_job"),
			actualJob: $(".player.selected").data("job_title"),
			orga: $(".player.selected").data("salary_orga")
		}))
		activateLoading()
		$(this).blur()
	})
	$("#busi_reset_prod_button").click(()=>{
		$.post('http://Atlantiss/set_business',
		JSON.stringify({
			type: 'reset_prod', 
			name: $(".player.selected").data("salary_name"),
			job: $(".player.selected").data("salary_job"),
			uuid: $(".player.selected").data("salary_uuid"),
			actualJob: $(".player.selected").data("job_title")
		}))
		activateLoading()
		$(this).blur()
	})
	$("#busi_treas_button").click(()=>{
		$.post('http://Atlantiss/set_business',
		JSON.stringify({type: 'getFromTreas', number: $("#busi_treas_input").val()}))
		activateLoading()
		$(this).blur()
	})
	$("#getbill").click(()=>{$.post('http://Atlantiss/updateBillGUI');activateLoading()})
	//$("#busi_change_leader_button").click(function() {$.post('http://Atlantiss/set_business', JSON.stringify({type: 'setPDG', value: $(".player.selected").data("salary_name")})); $(this).blur(); $("#close").trigger('click')})
	//$("#busi_offers_del_button").click(function() {$.post('http://Atlantiss/set_business', JSON.stringify({type: "remove_offer", param: selected_busi_job_offer})); activateLoading(); $(this).blur()})

	$("#jobselect_request_cancel").click(function() {$.post('http://Atlantiss/quick_job_search', JSON.stringify({type: "delete_request", param: selected_job_request})); activateLoading(); $(this).blur()})
	$("#validate_request_form").click(function() {$.post('http://Atlantiss/set_job_search', JSON.stringify({type: "create_request", param: $("#request_form_msg").val(), value : id_bp_offers_selected})); activateLoading(); $(this).blur()})
	$("#cancel_request_form").click(function() {closeRequestForm(); $(this).blur()})

	$("#getextrait").click(function() {$.post('http://Atlantiss/get_book_bills', JSON.stringify({
		type: book_select_type.options[book_select_type.selectedIndex].value, 
		tag: book_select_tag.options[book_select_tag.selectedIndex].value,
		date : $("#book_date_filter_begin").val(),
		date2 : $("#book_date_filter_end").val()})); activateLoading(); $(this).blur()})

	$('button').click(function() {$(this).blur()})
})