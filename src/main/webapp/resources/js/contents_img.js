function con_img(maxlength) { 
	$('.con_img img').each(function() { 
		var maxWidth = maxlength; // Max width for the image 
		var ratio = 0; // Used for aspect ratio 
		var width = $(this).width(); // Current image width 
		var height = $(this).height(); // Current image height 
		
		// Check if the current width is larger than the max 
		
		if(width > maxWidth){
			ratio = maxWidth / width; // get ratio for scaling image 
			$(this).css("width", maxWidth); // Set new width 
			$(this).css("height", height * ratio); // Scale height based on ratio 
			height = height * ratio; // Reset height to match scaled image 
		} 
		
	});
}
