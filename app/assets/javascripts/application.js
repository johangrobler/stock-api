// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery 
//= require jquery_ujs
//= require turbolinks
//= require_tree .
var locations =[];
var map;
var marker;
$( document ).ready(function() {

	console.log('doc ready');
 
	var stock_takes=[];
	var pusher = new Pusher('62217549218f218bf085', {
	  cluster: 'eu',
	  encrypted: true
	});


	console.log('pusher');

	var channel = pusher.subscribe('mezzanine-stocktake');

	channel.bind('stocktake_event_1', function(data) {
	  console.log(JSON.stringify(data));
	  stock_takes.push(data.stock_take);
	  buildStock();
	  checkReplenishAlert(data.stock_take);
	});
	function checkReplenishAlert(stock_take){
		if(stock_take.quantity  <= stock_take.replenish_quantity){
			console.log('move map center : '+stock_take.latitude +' : '+stock_take.longitude);
			
			map.setZoom(14);

			map.panTo({lat: stock_take.latitude, lng:  stock_take.longitude });

			 marker = new google.maps.Marker({
          		position: {lat: stock_take.latitude, lng:  stock_take.longitude },
          		map: map
        	});

		}
	}
	function buildStock(){
		if(stock_takes.length > 0 ){
		    var limit = 5;
		    var table = '<h5>Realtime stock takes</h5><br><table class="table">';
		    for(var i= stock_takes.length; i > 0 && limit > 0 ; i--){
		 
		      table += '<tr>';
		      table += '<td>'+stock_takes[i-1].clinic +'</td>';
		      table += '<td>'+stock_takes[i-1].product +'</td>';
		      table += '<td>'+stock_takes[i-1].quantity +'</td>';  
		      table += '<td>'+stock_takes[i-1].created_at  +'</td>';   
		      if ( stock_takes[i-1].quantity > stock_takes[i-1].replenish_quantity){
		          table += '<td><div class="hasstock"> OK </div></td>' 
		      } else {
		          table += '<td><div class="replenish"> REPLENISH!  </div></td>' 
		      } 
		      
		      table += '</tr>';
		      limit--;
		    }
		    table += '</table><p>Showing last 5</p>';
		    if( $('#log').length ){
		    	 $('#log').html(table);
		    	// console.log(table); 
		    }
		    
		}
	}

	$(document).on("turbolinks:load", function(){
		console.log('page loaded');
		buildStock();
		if( $('#map').length ){
			initMap();
		}
	});
 

	// map scripts

	 function initMap() {

        map = new google.maps.Map(document.getElementById('map'), {
        	navigationControl: false,
    		mapTypeControl: false,
    		scaleControl: false    ,       // Set the zoom level manually
			//zoomControl: false,
			streetViewControl:false,
			scaleControl: false,
			scrollwheel: false,
        	zoom: 9,
        	center: {lat: -33.9379044, lng: 18.8619449}
        });

        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.

        var image = 'https://mezzanine-stock.herokuapp.com/pin.png';
  
        var markers = locations.map(function(location, i) {
          return new google.maps.Marker({
            position: location, 
            icon: image
          });
        });

        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
     


      /*
 		var locations = [ 
        <% Clinic.all.each do |clinic| %>
        {lat: <%= clinic.latitude%>,lng: <%= clinic.longitude %> },
        <% end %>
      ]
      */




});