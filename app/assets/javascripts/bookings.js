// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// $(document).ready(function(){
// 	$('#booking_num_guests').change(function(){
// 		$('.totalprice').html('<div><%=  @listing.price * params[:booking][:num_guests].to_i %></div>');
// 	});
// });
$(document).ready(function(){
	$('#booking_num_guests').change(function(){
		var listingPrice = $('li#listing-price').data('listing-price');
		var totalPrice = listingPrice * $('#booking_num_guests').val();
		$('.totalprice').html('<div>' + totalPrice + '</div>');
	});
});