let JobItems = []
let OrgaItems = []
let job = ""
let orga = ""
let count = 0

const Fix = img => img.src = "../ui/assets/img/items/default.png"

const Buy = (item, price) => $.post('http://Ora/WholeSalerBuy', JSON.stringify({item: item, count: count, price: price}))

const SetCount = value => count = Math.round(parseInt(value))

function ToggleMenu(open) {
  const div = document.getElementById('wholesalerDiv')

  if (!open || div.style.display == "block") {
    div.style.display = "none"
    $('#wholesalerDiv #job').empty()
    $('.jobTitle').css("display", "none")
    $('#wholesalerDiv #orga').empty()
    $('.orgaTitle').css("display", "none")
  } else {
    $('.jobTitle').html(job)
    $('.orgaTitle').html(orga)

    for (const item in JobItems) {
      $('.jobTitle').css("display", "block")
      $('#wholesalerDiv #job').append(
        `<div class="card">
          <image class="card-img-top" src="../ui/assets/img/items/${item}.png" onerror="Fix(this)" />
          <div class="name">${JobItems[item][0]}</div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item"><input class="BuyInput" type="number" min="0" oninput="SetCount(this.value)" oninput="event.target.value = event.target.value.replace(/[^0-9]*/g, '')" placeholder="combien?" /></li>
            <li class="list-group-item"><button class="BuyBtn" onclick="Buy('${item}', ${JobItems[item][1]})">Acheter ($${JobItems[item][1]}/u)</button></li>
          </ul>
        </div>`
      )
    }

    for (const item in OrgaItems) {
      $('.orgaTitle').css("display", "block")
      $('#wholesalerDiv #orga').append(
        `<div class="card">
          <image class="card-img-top" src="../ui/assets/img/items/${item}.png" onerror="Fix(this)" />
          <div class="name">${OrgaItems[item][0]}</div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item"><input class="BuyInput" type="number" min="0" oninput="SetCount(this.value)" oninput="event.target.value = event.target.value.replace(/[^0-9]*/g, '')" placeholder="combien?" /></li>
            <li class="list-group-item"><button class="BuyBtn" onclick="Buy('${item}', ${OrgaItems[item][1]})">Acheter ($${OrgaItems[item][1]}/u)</button></li>
          </ul>
        </div>`
      )
    }

    div.style.display = "block"
  }
}


function SortObject(data) {
//   return Object.keys(object).sort().reduce((result, key) => (result[key] = object[key], result), {});
// }
  
  let objectToarray = Object.entries(data)
  //sort by name
  objectToarray.sort(function(a, b) {
    var nameA = a[1][0].toUpperCase(); // ignore upper and lowercase
    var nameB = b[1][0].toUpperCase(); // ignore upper and lowercase
    if (nameA < nameB) {
      return -1;
    } 
    if (nameA > nameB) {
      return 1;
    }
    // names must be equal
    return 0;
  });

  let objSorted = {}
  objectToarray.forEach(function(item){
      objSorted[item[0]]=item[1]
  })
  return objSorted
}

// Event listeners

window.addEventListener('message', event => {
  if (event.data.eventName == "openWholesalerMenu") {
    // convert to an array
    console.log(event.data)
    if (event.data.JobItems != null) {
      JobItems = SortObject(event.data.JobItems)
    }
    if (event.data.OrgaItems != null) {
      OrgaItems = SortObject(event.data.OrgaItems)
    }
    job = event.data.Job
    orga = event.data.Orga
    ToggleMenu(true)
  } else if (event.data.eventName == "closeWholesalerMenu") {
    JobItems = []
    OrgaItems = []
    ToggleMenu(false)
  }
})

window.addEventListener('keydown', e => {
  if (e.key == "Escape" && document.getElementById('wholesalerDiv').style.display == "block") {
    $.post('http://Ora/WholesalerCloseUI', {})
  }
})

$('#app').on('click', () => {
  if ($("#wholesalerDiv").css('display') == "block") {
    $.post('http://Ora/WholesalerCloseUI', {})
  }
})
