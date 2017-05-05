
var autocomplete;
function initialize() {
  var input = document.getElementById('autocomplete');
  autocomplete = new google.maps.places.Autocomplete(/** @type {!HTMLInputElement} */(document.getElementById('autocomplete'))
            );
  autocomplete.addListener('place_changed', fillInCoordinates);
}

google.maps.event.addDomListener(window, 'load', initialize);

function fillInCoordinates() {

  var place = autocomplete.getPlace();
  var latfield = document.getElementById('latitude');
  var longfield = document.getElementById('longitude');
  var location = document.getElementById('location');

  latfield.value = place.geometry.location.lat();
  longfield.value = place.geometry.location.lng();
  location.value = place.address_components[0]["long_name"] + ", " + place.address_components[2]["short_name"];
}
