$(document).ready(function(){
	//Truncate
	$(".nottrunc").css('display','none');
	$(".read-more").click(function() {
	  	$(".trunc").css('display','none');
	  	$(".nottrunc").css('display','block');
	});

	$(".read-less").click(function() {
	  	$(".trunc").css('display','block');
	  	$(".nottrunc").css('display','none');
	});


	//Ajax Sign Up
	$("form#target").on("submit", function(event) {
		event.preventDefault();
		console.log($(this).serialize());
		console.log($(this).attr("method"));
		console.log($(this).attr("action"));
		

		$.ajax({
		  type: $(this).attr("method"),
		  url: $(this).attr("action"),
		  data: $(this).serialize(),  
		  dataType: "json",

		  success: function(values) {
		  	if(values["errors"]) {
		  		$("#errors").html(values["errors"])
		  	}
		  	else
		  	{
		  		//$("#error").html("")
		  		window.location.replace("/read");
		  	}
		  },
		});
	});

	//Ajax Login
	$("form#login").on("submit", function(event) {
		event.preventDefault();
		console.log($(this).serialize());
		console.log($(this).attr("method"));
		console.log($(this).attr("action"));
		

		$.ajax({
		  type: $(this).attr("method"),
		  url: $(this).attr("action"),
		  data: $(this).serialize(),  
		  dataType: "json",

		  success: function(values) {
		  	if(values["errors"]) {
		  		$("#errors-login").html(values["errors"])
		  	}
		  	else
		  	{
		  		//$("#error").html("")
		  		window.location.replace("/read");
		  	}
		  },
		});
	});
});
