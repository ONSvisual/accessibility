 //Tooltip');

$(document).ready(function(){

	var pymChild = null;

	//landing page transition	

	 // $("#show").click(function(){
  //         $("#landing-screen").slideUp("slow");
  //     });
  //    $("#show").click(function(){
  //         $("#calculator").fadeIn("slow");
  //    });		

//check whether browser can cope with svg	
	if (Modernizr.svg) {
		
		//calls add listeners function	
		addListeners();

		// mutateDOM
		mutateDom()
		 //load config 
			d3.json("config.json", function(error, config) {
			dvc=config

		//load chart data
				d3.csv("data.csv", function(error, data) {
					graphic_data = data;
					

					names = d3.keys(/*data*/graphic_data[0]).filter(function(key) { return key !== "state"; });
	
						// addListeners();

						graphic = $('#graphic');

						//use pym to create iframed chart dependent on specified variables
						pymChild = new pym.Child({ renderCallback: drawGraphic});
					
				});
			});	
		
	function mutateDom () {
		d3.selectAll('.square').each(function() {
			var ctr = $(this)
			var labelText = ctr.find('.category').text().split('.')[0]
			ctr.find('.btn-minus').attr('aria-label', 'Click to decrease ' + labelText + ' hours')
			ctr.find('.btn-plus').attr('aria-label', 'Click to increase ' + labelText + ' hours')
		})
	}

	function drawGraphic(width) {
			
			
		   threshold_md = 788;
		   threshold_sm = dvc.optional.mobileBreakpoint; 

		   //set default variables for chart

		   defaulthours = 0.001;
		   defaultsalary = 10;

		  
		  	//set variables for chart dimensions dependent on width of #chart
		    if (graphic.width() < threshold_sm) {        	
		            var margin = {top: dvc.optional.margin_sm[0], right: dvc.optional.margin_sm[1], bottom: dvc.optional.margin_sm[2], left: dvc.optional.margin_sm[3]}; 
					var graphic_width = graphic.width() - margin.left - margin.right;
		            height = (dvc.essential.barHeight * graphic_data.length) + margin.top + margin.bottom;
		    } else if (graphic.width() < threshold_md){
		        	var margin = {top: dvc.optional.margin_md[0], right: dvc.optional.margin_md[1], bottom: dvc.optional.margin_md[2], left: dvc.optional.margin_md[3]}; 
					var graphic_width = graphic.width() - margin.left - margin.right;
		            height = (dvc.essential.barHeight * graphic_data.length) + margin.top + margin.bottom;
		  	} else {
		        	var margin = {top: dvc.optional.margin_lg[0], right: dvc.optional.margin_lg[1], bottom: dvc.optional.margin_lg[2], left: dvc.optional.margin_lg[3]}
					var graphic_width = graphic.width() - margin.left - margin.right;
				    height = (dvc.essential.barHeight * graphic_data.length) + margin.top + margin.bottom;
			}	

		    // clear out existing graphics
		    graphic.empty();
			
			//footer.text("*excluding overtime");
			
			x = d3.scale.linear()
		        .range([ 0, graphic_width]);

			y = d3.scale.ordinal()
				.rangeRoundBands([0, height], .1)
			
		    y.domain(graphic_data.map(function(d) {
					return d.category;
				}))

		    var yAxis = d3.svg.axis()
		        .scale(y)
		        .orient("left")
		    
		    xAxis = d3.svg.axis()
		        .scale(x)
		        .orient('bottom')
				.tickSize(height, 0, 0);
		    			    
			//specify number or ticks on x axis
			
			mobilefmt = d3.format("s");
			var numberfmt = d3.format(".2f");
			
				
			 if (graphic.width() <= threshold_sm) {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[0])
				xAxis.tickFormat(mobilefmt);
				
			 } else if (graphic.width() <= threshold_md){
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[1])
			 } else {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[2])
			 }
				
				
		    //gridlines
		    
		    var bar = d3.svg.line()
		        .y(function(d) { return y(d.category); })
		        .x(function(d) { 
					if(milesOrTank == "0") {
						return x(d.amt * (defaultmiles / (defaultMPG/4.5))); 
					} else {
						return x(d.amt * defaulttank); 
					}
				});	

		    // parse data into columns
		    bars = {};
		    for (var column in graphic_data[0]) {
		        if (column == 'name') continue;
		        bars[column] = graphic_data.map(function(d) {
		            return {
		                'name': d.category,
		                'amt': d[column]
		            };
		        });
		    }
			
		  	//set the x domain value

			   var xDomain = [
								0,
								d3.max(d3.entries(bars), function(c) {
										return d3.max(c.value, function(v) {
									
											var n = 5 * defaultsalary;
									
										return Math.ceil(n);
									});
								})
							 ]; 
				
		    x.domain(xDomain);
		    
			//create legend
			if(dvc.essential.legendLabels.length > 1){
			var legend = d3.select('#graphic').append('ul')
			                .attr('class', 'key')
			            .selectAll('g')
			                .data(dvc.essential.legendLabels)
			            .enter().append('li')

				    legend.append('b')
						 .attr("class",function(d,i){return "background" + i})
				    
					legend.append('label')
				         .html(function(d,i) { return dvc.essential.legendLabels[i]; });						
			}

			
		    //create svg for chart
		    var svg = d3.select('#graphic').append('svg')
				        .attr("width", graphic_width + margin.left + margin.right)
				        .attr("height", height + margin.top + margin.bottom +30)
				        .append("g")
				        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
				
					svg.append("rect")
						.attr("class","svgRect")
						.attr("width", graphic_width)
						.attr("height", height)
			    
				    svg.append('g').attr("id","xAxis")
				        .attr('class', 'x axis')
				        .call(xAxis).append("text")
						 .attr("y", -25)
						 .attr("x",graphic_width)
						 .attr("dy", ".71em")
						 .style("text-anchor", "end")
						 .text(dvc.essential.xAxisLabel);

				  /*  svg.append('g').attr("id","xgrid")
				        .attr('class', 'x grid')
				        .call(x_axis_grid()
				            .tickSize(height, 0, 0)
				            .tickFormat('')
				        );
					*/
					//create y axis, if x axis doesn't start at 0 drop x axis accordingly	
					svg.append('g')
				        .attr('class', 'y axis')
						.attr('id', 'yAxis')
				        .attr('transform', function(d){ 
				        			if(xDomain[0] != 0){
										return 'translate(' + ( - 30) + ',0)'
									} else {
										return 'translate(' + 0  + ', 0)'
									}
							})
				        .call(yAxis);


	svg.append('g').attr("class","bars").selectAll('rect')
					.data(graphic_data)
					.enter()
					.append('rect')
					.attr('id',function(d,i){return "bar" + i})
					.attr('class', "bar bar_pos")

					.attr("width", function(d) { return 0 + Math.abs(x(d.value * defaulthours)); })
					// .attr("width",0)
					.attr("x",x(0))
					.attr("y", function(d) { return y(d.category); })
					.attr("height", y.rangeBand())
					
					

							
			//create link to source				
			d3.select(".footer").append("p")
				.text("")
				.append("a")
				.attr("href", dvc.essential.sourceURL)
				.attr("target", "_blank")
				.html(dvc.essential.sourceText);
			
			totalYear = 0	
			addShare();
						
			//use pym to calculate chart dimensions	
		    if (pymChild) {
		        pymChild.sendHeight();
		    }
		}			

    $('[data-toggle="tooltip"]').tooltip({
		template: '<div class="tooltip" aria-hidden="true" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
	}); 
	
 


//plugin bootstrap minus and plus
		//http://jsfiddle.net/laelitenetwork/puJ6G/
		
		
		
	// Next steps
	
	// 1) Add listeners to the plus and minus buttons so that if these are clicked you get the values of each of the six input boxes. Also make it work that you get six values when any of the boxes are directly written into (using the "keyup" trigger). Look at the AddListeners function and broadly copy what is needed.
	// 2) Get the AddListeners function to trigger another function that retrieves the values from these inputs. Because we want to sort the order of these bars you're going to need to create an object (exactly the same as object that is created when we read in the data for the first time (it'll make it sortable, and retain the name & value combination).
	// 3) Then create an update chart function. It'll look reasonably similar to the Fuel updateChart function - except we'll be matching values based on the name of the bar (so we can sort it in order).


  	function addListeners() {
		
		 	d3.select("#housework").on("change", calcSalaries).on("keyup", calcSalaries);
		 	d3.select("#childcare").on("change", calcSalaries).on("keyup", calcSalaries);
		 	d3.select("#cooking").on("change", calcSalaries).on("keyup", calcSalaries);
		 	d3.select("#laundry").on("change", calcSalaries).on("keyup", calcSalaries);
		 	d3.select("#transport").on("change", calcSalaries).on("keyup", calcSalaries);
		 	d3.select("#adult-care").on("change", calcSalaries).on("keyup", calcSalaries);
		 	d3.select("#volunteering").on("change", calcSalaries).on("keyup", calcSalaries);
			
			d3.selectAll(".btn-plus").on("click", delayCall);
			d3.selectAll(".btn-minus").on("click", delayCall);
			
	}
	
	function delayCall() {
			setTimeout(function(){calcSalaries()},100)
		
	}
		
	function calcSalaries() {
			
		 	/*Get the current state of the different variables*/
		 	housework = $("#housework").val();
		 	childcare = $("#childcare").val();
		 	cooking = $("#cooking").val();
		 	laundry = $("#laundry").val();
		 	transport = $("#transport").val();
		 	adultcare = $("#adult-care").val();
		 	volunteering = $("#volunteering").val();
			hoursSpent = [housework, childcare, cooking, laundry, transport, adultcare, volunteering];
			updateChart();
			
	}
	
	function updateChart() {
			bars = [];
		    for (var column in graphic_data[0]) {
		        if (column == 'name') continue;
		        bars[column] = graphic_data.map(function(d,i) {

		            return {
		                'category': d.category,
		                'value': (d[column]*hoursSpent[i])
		            };
		        });
		    }
		    
		    xAxis = d3.svg.axis()
		        .scale(x)
		        .orient('bottom')
				.tickSize(height, 0, 0);
	
			 if (graphic.width() <= threshold_sm) {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[0])
				xAxis.tickFormat(mobilefmt);
				
			 } else if (graphic.width() <= threshold_md){
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[1])
			 } else {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[2])
			 }
			
			 var xDomain = [
								0,
								d3.max(d3.entries(bars), function(c) {
										return d3.max(c.value, function(v) {
									
											var n = v.value;
									
										return Math.ceil(n);
									});
								})
							 ];
							  
			xdomain2=[0,d3.max([50,xDomain[1]])];	
		    x.domain(xdomain2);
	
				d3.select("#xAxis").transition().duration(1000).call(xAxis);
				
				
				sortedBars=bars.value.sort(function(a, b) {
					
    			return b.value - a.value;
				});
				
				//reorder y axis//
				
				y.domain(sortedBars.map(function(d) {
					return d.category;
				}))


		    var yAxis = d3.svg.axis()
		        .scale(y)
		        .orient("left")
				
				d3.select("#yAxis")
				.transition().duration(1000).call(yAxis);
				
				
				
				//bars transition//
				
				d3.selectAll(".bar")
				.data(sortedBars,function(d){return d.category;})
				.transition().duration(1000)
				.attr("width", function(d) { return 0 + Math.abs(x(d.value)); })
				.attr("y", function(d) { return y(d.category); })
				
				
				//monthly and annual totals//

				
 				var dataTotalValue = d3.nest()
 				.rollup(function(d) { 
   				return d3.sum(d, function(g) {return g.value; });
  				}).entries(sortedBars);
  				totalYear = dataTotalValue * 52;
				
				
				//Odometer settings
				
				window.odometerOptions = {
				  format: '(,ddd)', 
				  duration: 1000, // Change how long the javascript expects the CSS animation to take
				};
				
				Odometer.init();
				
  				//number formatting for display//

  				mynumbformat = d3.format(",.2f");
  				d3.select("#totalWeekValue").text(dataTotalValue);

  				
  				//d3.select("#totalAnnualValue").text("£"+ mynumbformat(totalYear));
				d3.select("#totalAnnualValue").text(totalYear);
				// annouceUpdate
				d3.select('#accessibilityInfo').text([
					'Total per week: ', dataTotalValue.toFixed(2), ' pounds. ',
					'Total per year: ', totalYear.toFixed(2), ' pounds.',
				].join(''))
				addShare();
  				
	}


		$('.btn-number').click(function(e){
		    e.preventDefault();
		    
		    fieldName = $(this).attr('data-field');
		    type      = $(this).attr('data-type');
		    var input = $("input[name='"+fieldName+"']");
		    var currentVal = parseInt(input.val());
		    if (!isNaN(currentVal)) {
		        if(type == 'minus') {
		            
		            if(currentVal > input.attr('min')) {
		                input.val(currentVal - 1).change();
		            } 
		            if(parseInt(input.val()) == input.attr('min')) {
		                $(this).attr('disabled', true);
		            }

		        } else if(type == 'plus') {

		            if(currentVal < input.attr('max')) {
		                input.val(currentVal + 1).change();
		            }
		            if(parseInt(input.val()) == input.attr('max')) {
		                $(this).attr('disabled', true);
		            }

		        }
		    } else {
		        input.val(0);
		    }
		});
		$('.input-number').focusin(function(){
		   $(this).data('oldValue', $(this).val());
		});
		$('.input-number').change(function() {
		    
		    minValue =  parseInt($(this).attr('min'));
		    maxValue =  parseInt($(this).attr('max'));
		    valueCurrent = parseInt($(this).val());
		    
		    name = $(this).attr('name');
		    if(valueCurrent >= minValue) {
		        $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
		    } else {
		        //alert('Sorry, the minimum value was reached');
		        $(this).val($(this).data('oldValue'));
		    }
		    if(valueCurrent <= maxValue) {
		        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
		    } else {
		        //alert('Sorry, the maximum value was reached');
		        $(this).val($(this).data('oldValue'));
		    }
		    
		    
		});
		$(".input-number").keydown(function (e) {
		        // Allow: backspace, delete, tab, escape, enter and .
		        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
		             // Allow: Ctrl+A
		            (e.keyCode == 65 && e.ctrlKey === true) || 
		             // Allow: home, end, left, right
		            (e.keyCode >= 35 && e.keyCode <= 39)) {
		                 // let it happen, don't do anything
		                 return;
		        }
		        // Ensure that it is a number and stop the keypress
		        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
		            e.preventDefault();
		        }
		    });

		} else {
			 //use pym to create iframe containing fallback image (which is set as default)
			 pymChild = new pym.Child();
			if (pymChild) {
		        pymChild.sendHeight();
		    }
		}



function addShare() {
		
			// Capture and set dynamic URL
			d3.select("#footer").selectAll("*").remove();
			
			urlshare = document.referrer;
				
			addButtons();
	}
	
	function addButtons () {	
			
			mynumbformat = d3.format(",.2f");
			
			//Code to create share buttons, embed code etc
			d3.select("#footer")
				.append("div")
				.attr("id", "share");
				
			d3.select("#share")
				.append("p")
				.style("padding-top","8px")
				.style("color","#333")
				.style("font-size","18px")
				.style("padding-bottom","8px")
				.style("margin","0px auto")
				.style("text-align","center")
				.style("font-weight","400")
				.text("Share the value of your unpaid work")

			//appending the buttons
			d3.select("#share").append("a")
				.attr('class', 'social-button social-button--facebook')
				.attr("id","facebookShare")
				.attr("href","https://www.facebook.com/sharer/sharer.php?u=" + urlshare)
				.attr("target","_blank")
				.attr("title","Facebook")
				.append("img")
				.attr("src","./img/facebook-icon.svg")
				.attr("alt", "facebook icon");
			
			d3.select("#share").append("a")
				.attr('class', 'social-button social-button--twitter')
				.attr("id","twitterShare")
				.attr("href","https://twitter.com/intent/tweet?text=The value of my unpaid work is £" + mynumbformat(totalYear) + " a year " + urlshare)
				.attr("target","_blank")
				
				.attr("title","Twitter")
				.append("img")
				.attr("src","./img/twitter-icon.svg")
				.attr("alt", "twitter icon");

			//on mouseover
			d3.select("#facebookShare").on("mouseover", function() {
				d3.select("#facebookShare").style("opacity","0.7");
			});
			d3.select("#twitterShare").on("mouseover", function() {
				d3.select("#twitterShare").style("opacity","0.7");
			});
			
			
			//on mouseout
			d3.select("#facebookShare").on("mouseout", function() {
				d3.select("#facebookShare").style("opacity","1.0");
			});
			d3.select("#twitterShare").on("mouseout", function() {
				d3.select("#twitterShare").style("opacity","1.0");
			});


	
}


});	


