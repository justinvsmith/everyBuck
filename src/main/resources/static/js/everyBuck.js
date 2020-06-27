$(document).ready(function(){
	
	
	  $(function () {
		    var tabContainers = $('div.tabs > div');
		    
		    $('.navLinks a').click(function () {
		        tabContainers.hide().filter(this.hash).show();
		        
		        $('.navLinks a').removeClass('selected');
		        $(this).addClass('selected');
		        
		    
		        return false;
		    }).filter(':first').click();
		});
	
	$('.outside').addClass("hidden");

	$('.outside').dblclick(function() {
		var $this = $(this);

		if ($this.hasClass("hidden")) {
			$(this).removeClass("hidden").addClass("visible");

		} else {
			$(this).removeClass("visible").addClass("hidden");
		}
	});
	
	$(".itemName a").click(function(){
		var j = $(this).html();
		$(".transactions").toggleClass("hide");
		$(".container").toggleClass("hide");
		$("."+j).toggleClass("hide");
		
	});
	
	$(".items").click(function(){
		var title = $(this).find(".itemName a").html();
		var th = $(this).find(".amtSpent").html();
		$(".inserts").html(title + "<br>" + th);
	});
	
	
//	$("a[href^='#pl']").click(function(){
//		var j = $(".circleMessage").find('.month').html()
//		$(".detailInserts").html("hi"+j);
//	});
	
	
})