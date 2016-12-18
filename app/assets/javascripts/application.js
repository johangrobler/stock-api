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
	});

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
		    	 console.log(table); 
		    }
		    
		}
	}

	$(document).on("turbolinks:load", function(){
		console.log('page loaded');
		buildStock();
	});
 
});