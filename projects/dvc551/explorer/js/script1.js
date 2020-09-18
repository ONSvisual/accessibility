//namespace any global variables
var dvc = {}; 


if (Modernizr.inlinesvg)
{
	//remove preview image/message if browser suppports SVG
	d3.select("#altern").remove();
	pymChild = new pym.Child();
	pymChild.sendHeight();
	
	//Load main script/data
	$(document).ready(function()
	{	
		//main script
	
	var loadcsvname = "all";
	var first = 0;
	var filtergroupx = false;

	dataload(loadcsvname);
	
	function dataload(loadcsvname){
		
	loadcsvnm = loadcsvname;
		
	var filtergroupx = false;
	
	$("#gpg_pct").addClass("active").siblings().removeClass("active");
	
	loadcsv = "assets/data" + loadcsvname + ".csv";
	
		d3.json("assets/config.json", function(error, config) {
				dvc=config;
			
				//Load the data
				d3.csv(loadcsv, function(error, data) {	
					
					
					graphic_data = data;
					
					occopt();
					
					if(first == 0) {
						first = 1;
						checkUrl(); 
					}
					
					
					
					dvc.format1 = d3.format(",.0f");
					dvc.format2 = d3.format(",.1f");
					dvc.format3 = d3.format(",.2f");
					
					//Set up sorting
					d3.selectAll(".sort").on("click",function(){sortme(this.id);});
					
					d3.selectAll(".fullpart").on("click",function(){dataload(this.id);});
					
					
					
					function toggleDiv(){
					  if($(this).is(':checked')){
						$('#filtergrp').slideDown(1000);
					  } else {
						$('#filtergrp').slideUp(1000);
					  }
					}

					$('#filtercheck')
						.change(toggleDiv);


					
					
					$(".btn-group > .btn").click(function(){
						$(this).addClass("active").siblings().removeClass("active");
					});
					
					pymChild = new pym.Child({ renderCallback: drawGraphic});
					pymChild.sendHeight();


					if(first == 1) {					
						if(typeof filteredocc != 'undefined') {
				
							
							setTimeout(function(){filterfirst(filteredocc)},500);
							$("#occselect").val(filteredocc);
							
							$("#occselect").trigger("chosen:updated");
						
							
						}
					}
				});
		});
		
	}
	
	function checkUrl () {
		
				if(self!=top) {
				
					if(window.location != window.parent.location)
					{
						var url = document.referrer;
					} else {
						var url = document.location;
					}
					
				} else {
					url = window.location.href;
				}
						
	
		var occ_q = url.split("?")[1];
		
		if(typeof occ_q != 'undefined') {
			
			filteredocc = occ_q.slice(0,4);  
			setTimeout(function(){filterfirst(filteredocc)},500);
			$("#occselect").val(filteredocc);
			
			$("#occselect").trigger("chosen:updated");
		
		}
		
	}
	
	//Function to create drop down
	function occopt () {
	
	d3.select("#occupation").select("div").remove();
	d3.select("#occgroup").select("div").remove();
	//Create a chosen drop down to show the list of occupations 

		dvc.allOcc = [];
			
		//Create an array for each occupation title
		graphic_data.forEach(function(d,i){	
				dvc.allOcc.push(graphic_data[i].occupation);								
		});
		
		dvc.allCode = [];
	
		//Create an array for each occupation code
		graphic_data.forEach(function(d,i){	
				dvc.allCode.push(graphic_data[i].code);								
		});

		// Join occupation and codes together in an array
		var codeoccyzip = d3.zip(dvc.allOcc, dvc.allCode);
		
		//sort occupation list alphabetically	
		dvc.codeoccyzip = codeoccyzip.sort(function(b, a){ return d3.descending(a[0], b[0])});


		// Build option menu for occupations
		var optns = d3.select("#occupation").append("div").attr("id","sel").append("select")
				.attr("id","occselect")
				.attr("style","width:90%")
				.attr("class","chosen-select");
			
			//append message
			
			optns.append("option")
				.attr("value","first")
				.text("");
			
			optns.selectAll("p").data(dvc.codeoccyzip).enter().append("option")
				.attr("value", function(d){ return d[1]}) 
				.text(function(d){ return d[0]});


			// Little function to bring objects to the front
			d3.selection.prototype.moveToFront = function() { 
			  return this.each(function() { 
				this.parentNode.appendChild(this)
			  }); 
			}; 
			
			
			$('#occselect').chosen({width: "90%", allow_single_deselect: true, placeholder_text_single:"CHOOSE YOUR OCCUPATION"}).on('change',function(evt,params){
		
								if(typeof params != 'undefined') {
									
										d3.select("#selectedbar").attr("id","");

										if(typeof filteredoccs !== "undefined"){
											//d3.select("selectedbar").attr("id","#backrect" + filteredoccs);
										}
										filteredocc = params.selected;
										filterfirst(filteredocc);
										
										d3.select("#backrect" + filteredocc).attr("id","selectedbar");
								}
								else {
									
									d3.select("#selectedbar").attr("id","#backrect" + filteredocc);
									filteredocc = undefined;
									filterremove();
										
								}
								
			});
			
			
			
			
			
			// Occupation hierarchy
			groupno = [];
			
			dvc.essential.occgroup.forEach(function(d,i){groupno.push(i+1)});
			

		  	occgroups = d3.zip(dvc.essential.occgroup,groupno);
			
			var optns2 = d3.select("#occgroup").append("div").attr("id","sel").append("select")
				.attr("id","occgrpselect")
				.attr("style","width:90%")
				.attr("class","chosen-select");
			
			//append message
			
			optns2.append("option")
				.attr("value","first")
				.text("");
			
			optns2.selectAll("p").data(occgroups).enter().append("option")
				.attr("value", function(d){ return d[1]}) 
				.text(function(d){ return d[0]});

			
			
			$('#occgrpselect').chosen({width: "90%", allow_single_deselect: true, disable_search:true, placeholder_text_single:"CHOOSE OCCUPATION GROUP"}).on('change',function(evt,params){
		
								if(typeof params != 'undefined') {
									hier = params.selected;
									linesubsel = lines.filter(function(d,i) {return d.hierarchy == hier;});
									filtergroup(linesubsel);
								}
								else {
									linesubsel = lines;
									filtergroup(linesubsel);
								}
								
			});		
			
			

	} //End of make occupation


	function drawGraphic(width) {
		

		   var graphic = $('#graphic');
		   graphic.empty();
		   $('#static_graphic').empty();
		   graphicwidth = graphic.width()
		   threshold_md = 788;
		   threshold_sm = dvc.optional.mobileBreakpoint; // 510
		  

		  
		   var numobs = graphic_data.length;
		  
		  	//set variables for chart dimensions dependent on width of #graphic
		    if (graphicwidth < threshold_sm) {
					ball = 4;     	
		            margin = {top: dvc.optional.margin_sm[0], right: dvc.optional.margin_sm[1], bottom: dvc.optional.margin_sm[2], left: dvc.optional.margin_sm[3]}; 
					chart_width = graphic.width() - margin.left - margin.right;
		            height = (dvc.optional.lineheight[0]*numobs) - margin.top - margin.bottom;
					lineheight = dvc.optional.lineheight[0];
					tspanupper = -5;
					tspanlower =8;
					mobtabdesk = 0;
		    } else if (graphicwidth < threshold_md){ 
					ball = 6; 
		        	margin = {top: dvc.optional.margin_md[0], right: dvc.optional.margin_md[1], bottom: dvc.optional.margin_md[2], left: dvc.optional.margin_md[3]}; 
					chart_width = graphic.width() - margin.left - margin.right;
					chart_width2 = graphic.width()*0.2;
		            height = (dvc.optional.lineheight[1]*numobs) - margin.top - margin.bottom;
					lineheight = dvc.optional.lineheight[1];
					tspanupper = -6;
					tspanlower =9;
					mobtabdesk = 1;
		  	} else { ball = 6; 
		        	margin = {top: dvc.optional.margin_lg[0], right: dvc.optional.margin_lg[1], bottom: dvc.optional.margin_lg[2], left: dvc.optional.margin_lg[3]}
					chart_width = graphic.width() - margin.left - margin.right;
					chart_width2 = graphic.width()*0.2;
		            height = (dvc.optional.lineheight[2]*numobs) - margin.top - margin.bottom;
					lineheight = dvc.optional.lineheight[2];
					tspanupper = -6;
					tspanlower = 9;
					mobtabdesk = 2;
			}

		    // clear out existing graphics
		    graphic.empty();
			
			x = d3.scale.linear()
		        .range([ 0, chart_width]);

			y = d3.scale.ordinal()
			.rangePoints([0, height], .3);
				//.rangeRoundBands([0, height]);  // .1
		    

		    var yAxis = d3.svg.axis()
		        .scale(y)
		        .orient("left");
		    
		    var xAxis = d3.svg.axis()
		        .scale(x)
		        .orient('top')
				.tickSize(-height,0)
				.tickFormat(d3.format("s"));
		    			    
			//specify number or ticks on x axis
			if (graphic.width() <= threshold_sm) {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[0])
			 } else if (graphic.width() <= threshold_md){
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[1])
			 } else {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[2])
			 }
				

		     	lines = graphic_data.map(function(d,i) {
					if(+d.earningsm ==0 || +d.earningsf ==0 ){  //console.log(d + " " +i); 
						return {  
							'name': d.occupation,
							'code': d.code,   // might not need since we mappe it in y.domain earlier
							'mymin': +d.earningsm,   // + changes string to numeric.
							'mymax': +d.earningsf,
							'mymedian': +d.earningsa,
							'earnmann': +d.earningsannm,
							'earnfann': +d.earningsannf,
							'malejobs':+d.jobsm,
							'femalejobs':+d.jobsf,
							'diff': -999999,
							'diffper':-999999,
							'jobsplitm':0,
							'jobsplitf':0,
							'hierarchy': d.hierarchy
						} 
					} else if(+d.jobsm ==0 || +d.jobsf ==0 ){  //console.log(d + " " +i); 
						return {  
							'name': d.occupation,
							'code': d.code,   // might not need since we mappe it in y.domain earlier
							'mymin': +d.earningsm,   // + changes string to numeric.
							'mymax': +d.earningsf,
							'mymedian': +d.earningsa,
							'earnmann': +d.earningsannm,
							'earnfann': +d.earningsannf,
							'malejobs':+d.jobsm,
							'femalejobs':+d.jobsf,
							'diff': +d.earningsm - +d.earningsf,
							'diffper': ((+d.earningsm - +d.earningsf)/+d.earningsm)*100,
							'jobsplitm':0,
							'jobsplitf':0,
							'hierarchy': d.hierarchy
						} 
					} else {
						return {  
							'name': d.occupation,
							'code': d.code,   // might not need since we mappe it in y.domain earlier
							'mymin': +d.earningsm,   // + changes string to numeric.
							'mymax': +d.earningsf,
							'mymedian': +d.earningsa,
							'earnmann': +d.earningsannm,
							'earnfann': +d.earningsannf,
							'malejobs':+d.jobsm,
							'femalejobs':+d.jobsf,
							'diff': +d.earningsm - +d.earningsf,
							'diffper': ((+d.earningsm - +d.earningsf)/+d.earningsm)*100,
							'jobsplitm':+d.jobsm/(+d.jobsm + +d.jobsf),
							'jobsplitf':+d.jobsf/(+d.jobsm + +d.jobsf),
							'hierarchy': d.hierarchy
						}
					}
		        });
			
				//lines.sort(function(a,b) {return b.diff-a.diff});
				lines.sort(function(a,b) {return b.diffper-a.diffper});
				
								
				y.domain(lines.map(function(d) { return d.name; }));
				
				var memax = d3.max(lines, function(d){
													return d.mymax;
													});
				
				var memin = d3.min(lines, function(d){
													return d.mymin;
													});
			
				//x domain calculations	: zero to intelligent max choice, or intelligent min and max choice,  or interval chosen manually
					if (dvc.essential.xAxisScale == "auto_zero_max" ){
					var xDomain = [	0, Math.ceil(d3.max(lines, function(d){
															return d.mymax;
																		})
												/dvc.essential.xAxisScaleDivisor)*dvc.essential.xAxisScaleDivisor ];
					}
					else if (dvc.essential.xAxisScale == "auto_min_max" )
					{
					var xDomain = [ Math.floor(d3.min(lines, function(d){
															return d.mymin;
																		})
												/dvc.essential.xAxisScaleDivisor)*dvc.essential.xAxisScaleDivisor,
									Math.ceil(d3.max(lines, function(d){
															return d.mymax;
																		})
												/dvc.essential.xAxisScaleDivisor)*dvc.essential.xAxisScaleDivisor
												 ];
						
					} else {
						if(loadcsvnm == "all") {
								var xDomain = dvc.essential.xAxisScale[0];
							} else if (loadcsvnm == "full") {
								var xDomain = dvc.essential.xAxisScale[1];
							} else if (loadcsvnm == "part") {
								var xDomain = dvc.essential.xAxisScale[2];
							}
					  
					  var yDomain = dvc.essential.yAxisScale;
								
					}	
					
					

		    x.domain(xDomain);
			
			
		    //create svg for chart
		    var svg = d3.select('#graphic').append('svg')
				        .attr("width", graphic.width())
				        .attr("height", height + margin.top + margin.bottom +30)
				        .append("g")
				        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
				
					svg.append("rect")
						.attr("class","svgRect")
						.attr("width", chart_width)
						.attr("height", height);
			    
				    svg.append('g')
				        .attr('class', 'x axis')
				        .attr("transform", "translate(0, 0)")
				        .call(xAxis);
					
					d3.select("#graphic").select(".x").selectAll("text").attr("fill","none");
					
					//create y axis, if x axis doesn't start at 0 drop x axis accordingly	
					svg.append('g')
				        .attr('class', 'y axis')
				        .attr('transform', function(d){ 
				        			if(xDomain[0] != 0){
										return 'translate(' + ( -30) + ',0)'
									} else {
										return 'translate(' + 0  + ', 0)'
									}
							})
				        .call(yAxis)
						.selectAll("text")	
            			.style("text-anchor", "start");
					
				d3.selectAll(".y text")
						.each(insertLinebreaks);		
				
				tie_split = svg.append("g").attr("id","tiefight");
				
				
				// Build male / female split graph 
//				if (graphic.width() > threshold_sm) {
//				
//				
//				
//					var svgsplit = d3.select('#graphic').select('svg').append('g')
//				        .attr("width", chart_width2)
//				        .attr("height", height + margin.top + margin.bottom +30)
//				        .append("g")
//				        .attr("transform", "translate(" + (chart_width + margin.left + margin.right)+ "," + margin.top + ")");
//				
//					svgsplit.append("rect")
//						.attr("class","svgRect")
//						.attr("width", chart_width2)
//						.attr("height", height);
//					
//					
//				}
				
									
				// Create top graphic	
				height2 = 30;
				
				y2 = d3.scale.ordinal()
					.rangePoints([0, height2], .3);
						//.rangeRoundBands([0, height]);  // .1
		   		
				y2.domain(lines.filter(function(d) {return d.code == 1115}).map(function(d) { return d.name; }));
								
				var yAxis2 = d3.svg.axis()
					.scale(y2)
					.orient("left");
					
				//set y domain later?
				
					
				labels = d3.select('#static_graphic').append("div")
				        .attr('class', 'labelling');
						 
					labels.append("p")
						 .style("padding-top","7px")
						 .attr("display","inline-block")
						 .style("text-align", "left")
						 .style("width","40px")
						 .style("float","left")
						 .text("Job");
						 
					labels.append("p")
						 .style("padding-top","7px")
						 .style("width",(100 + margin.left -140) + "px")
						 .style("float","left")
						 .style("padding-left", (margin.left -140) + "px")
						 .style("text-align", "right")
						 .text("Pay gap (%)");


					if(dvc.essential.legendLabels.length > 1){
						var legend = labels.selectAll("div").data(dvc.essential.legendLabels)
									.enter().append("div").attr("display","inline-block").style("float","left").style("padding-left","20px");
									
									
			malefem =['M30.8,22.8c6.3,0,11.4-5.1,11.4-11.4C42.2,5.1,37.1,0,30.8,0c-6.3,0-11.4,5.1-11.4,11.4C19.4,17.7,24.5,22.8,30.8,22.8 M61.5,72.1l-6.3-32.2c-1.1-6.8-7.2-14.6-16.9-14.6H23.3c-9.7,0-15.8,7.8-16.9,14.6L0.1,72.1c-0.4,2.1,1.1,4.2,3.2,4.5c2.1,0.4,3.9-1.1,4.5-3.2l8.2-27c0.1-0.5,0.6-0.8,1.1-0.6c0.5,0.1,0.8,0.6,0.6,1.1l-10.4,45c-0.3,1.6,0.8,3,2.4,3l3,0c1.7,0,3.3,1.4,3.5,3l4.4,27.2c0.3,1.7,1.8,3,3.5,3h12.9c1.7,0,3.2-1.4,3.5-3l3.7-27.2c0.2-1.7,1.8-3,3.5-3l3,0c1.7,0,2.8-1.3,2.4-3l-9.4-45c-0.1-0.5,0.2-1,0.6-1.1c0.5-0.1,1,0.2,1.1,0.6l8.2,27c0.6,2.1,2.4,3.6,4.5,3.2C60.4,76.3,61.8,74.2,61.5,72.1','M26.3,22.8c6.3,0,11.4-5.1,11.4-11.4C37.7,5.1,32.6,0,26.3,0S14.9,5.1,14.9,11.4C14.9,17.7,20,22.8,26.3,22.8 M51.4,43.3c0.5-6.9-4.7-18-16.2-18H16.5C5,25.3-0.2,36.5,0.3,43.3L0,76c0.1,2.2,2,3.8,4.2,3.6c2.2-0.1,3.6-2,3.6-4.2l1.7-26.7c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9v76.1c0,1.7,1.4,3,3,3h5.3c1.7,0,2.9-1.2,3-3l1.9-42.3c0.1-1.1,0.1-1.9,1.1-1.9h0.1c1.1,0,1,0.7,1.1,1.9l1.9,42.3c0.1,1.9,1.4,3,3,3h5.3c1.7,0,3-1.4,3-3l0-76.1h0c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9l1.7,26.7c0.1,2.2,1.5,4,3.6,4.2c2.2,0.1,4-1.5,4.2-3.6L51.4,43.3z']
			
	
		backgrounds = ["#E36A32","#332288"] 
		  
								legend.append('svg')
									.attr("height","32px")
									.attr("width","24px")
									.style("margin-left","0px")
									.style("float","left")
									//.attr("preserveAspectRatio")
									.append('path')
									.attr('d', function(d,i){return malefem[i]})
									.attr("transform","scale(0.25)")
									.attr("fill",function(d,i){return backgrounds[i]});
									

								
								legend.append('label')
									 .attr("class","labelling")
									 .style("height","32px")
									 .style("text-align","center")
									 .style("vertical-align","middle")
									 .style("display","table-cell")
									 //.style("float","left")
									 .html(function(d,i) { return dvc.essential.legendLabels[i]; });						
					}



					labels.append("p")
						 .style("padding-top","5px")
						 .style("width","170px")
						 .style("float","right")
						 .style("padding-right", margin.right + "px")
						 .style("text-align", "right")
						 .html("Hourly earnings<br>(£'s)");				
				
				
				
				var svgtop = d3.select('#static_graphic').append('svg')
				        .attr("width", graphicwidth)
				        .attr("height", 20)
				        .append("g")
				        .attr("transform", "translate(" + margin.left + ",20)");
				
					svgtop.append("rect")
						.attr("class","svgRect")
						.attr("width", chart_width)
						.attr("height", height2);
			    
				    svgtop.append('g')
				        .attr('class', 'x axis')
				        .attr("transform", "translate(0, 0)")
				        .call(xAxis);

					//create y axis, if x axis doesn't start at 0 drop x axis accordingly	
					svgtop.append('g')
				        .attr('class', 'y2 axis')
				        .attr('transform', function(d){ 
				        			if(xDomain[0] != 0){
										return 'translate(' + ( -30) + ',0)'
									} else {
										return 'translate(' + 0  + ', 0)'
									}
							})
				        .call(yAxis2)
						.selectAll("text")
						.attr("x", -margin.left)
						.style("text-anchor", "start");
				
				d3.selectAll(".y2 text")
						.each(insertLinebreaks);		
											
				
				svgtop.append("g").attr("id","tiefighttop");
				tieFight(lines);
      
		//create centre line if required
					if (dvc.optional.centre_line == true){
							groups.append("line")
							.attr("id","centreline")
							.attr('y1',0)
							.attr('y2',height)
							.attr('x1',x(dvc.optional.centre_line_value))
							.attr('x2',x(dvc.optional.centre_line_value));
					
					} else if(xDomain[0] <0){
						//svg.append("line")
						groups.append("line")
							.attr("id","centreline")
							.attr('y1',0)
							.attr('y2',height)
							.attr('x1',x(0))
							.attr('x2',x(0));
					}  	
	
							
			//create link to source				
//			d3.select(".footer").append("p")
//				.text("Source: ")
//				.append("a")
//				.attr("href", dvc.essential.sourceURL)
//				.attr("target", "_blank")
//				.html(dvc.essential.sourceText);
						
			//use pym to calculate chart dimensions	
		    if (pymChild) {
		        pymChild.sendHeight();
		    }
	}
		
	function tieFight(linesfilt) {
			
			groups = d3.select("#tiefight").selectAll('g')
						.data(linesfilt, function(d) { return d.name; });
						//
							
			groupsa = groups.enter().append('g');
			
			groupsa.attr("transform",function(d,i){return "translate(0," + y(d.name) +")"});
						
			groups.transition().duration(2000).attr("transform",function(d,i){return "translate(0," + y(d.name) +")"});		
				
			groups.exit().remove();
			
			
			backrect1 = 	groupsa.append('rect')
						.attr("class","backrect1")
						.attr("width",function(d,i){return margin.left})
						.attr("height",lineheight)
						.attr("x",0-margin.left)
						.attr("y",-lineheight/2);
			
			backrect1.transition().duration(2000);
			
			backrect2 = 	groupsa.append('rect')
						.attr("class","backrect2")
						.attr("id",function(d,i){return "backrect" + d.code})
						.attr("width",function(d,i){return graphicwidth})
						.attr("height",lineheight)
						.attr("x",0)
						.attr("y",-lineheight/2)
						.on("mouseover",function(d,i){showTooltip(d, this); d3.select(this).attr("class","backrect2hover")})
						.on("mouseout",function(){removeTooltip(); d3.select(this).attr("class","backrect2")});
			
			
			$("#graphic").scroll(function(){removeTooltip()});
			
			backrect2.transition().duration(2000);
					
			
			linesx = groupsa.append('line')
					.attr('class', function(d, i) {
			                if ( d.mymin <0 ) { 
								return 'tiefighter line_neg'; 
							} else { 
								return 'tiefighter line_pos'; 
							}
			            })
					.style("stroke","#abc")
					.style("opacity", 0)
					.attr('x1', function(d) {return x(d.mymedian); })  //d.mymin
					.attr('x2', function(d) { return x(d.mymedian); });
					
					
			linesx.transition().duration(2000)
					.style("opacity", function(d,i){
						if(d.mymin==0 || d.mymax==0)
							 {return 0} 
						else {return 1}
					})
					.attr('x1', function(d,i) {return x(d.mymin); })  //d.mymin
					.attr('x2', function(d) { return x(d.mymax); });

			textper = groupsa.append('text')
					.attr("class","textper")
					//.style("opacity", function(d,i){
//						if(d.mymin == 0 || d.mymax == 0 )
//							 {return 0} 
//						else {return 1}
//					})				
					.attr('x',-9)
					.attr('y',4)
					.text(function(d,i){
						if(d.mymin == 0 || d.mymax == 0 )
							 {return "*"} 
						else {return dvc.format1(d.diffper) + "%";}
					});
					
			textper.transition().duration(2000).attr('x',function(d,i) { return -9; });

			circle1 = groupsa.append('circle')
					.attr("class","circle1")
					.attr('r', ball)
					.style("opacity", function(d,i){
						if(d.mymin == 0)
							 {return 0} 
						else {return 1}
					})				
					.attr('cx',function(d,i) { return x(d.mymedian); });

			circle1.transition().duration(2000).attr('cx',function(d,i) { return x(d.mymin); });

					
			circle2 = groupsa.append('circle')
					.attr("class","circle2") 
					.style("opacity", function(d,i){
						if(d.mymax==0)
							 {return 0} 
						else {return 1}
					})
					 // make it .circle2 for different end colour
					.attr('cx',function(d,i) { return x(d.mymedian); }) 
					//.attr('cy',function(d,i) {return y(d.name); }) 
					.attr('r', ball); // (1/lines.length)*40);
			
			
			circle2.transition().duration(2000).attr('cx',function(d,i) { return x(d.mymax); });	
	

			
			}
			
	function tieFightTop() {
		
			d3.select("#backrect" + filteredocc).attr("id","selectedbar");
		
			d3.select("#results").select("p").remove();
			d3.select("#results").style("opacity",0);
			d3.select("#results").transition().duration(1000).style("height","200px").style("opacity",1);
			
			d3.select("#share").selectAll("a").remove();
			d3.select("#share").style("opacity",0);
			d3.select("#share").transition().duration(1000).style("height","200px").style("opacity",1);
			
			// Work out text
				if(filteredsel[0].mymax > 0){
					var femearn = "<b> £" + dvc.format3(filteredsel[0].mymax)+ "</b> per hr";
				} 
				else {
					var femearn = " earnings unavailable"
				}
				
				if(filteredsel[0].mymin > 0){
					var maleearn = "<b> £" + dvc.format3(filteredsel[0].mymin)+ "</b> per hr";
				} 
				else {
					var maleearn = " earnings unavailable"
				}
				
	
				
				
				if(filteredsel[0].diffper != -999999){
					if(filteredsel[0].diffper >0) {moreorless = "less"}
					else if(filteredsel[0].diffper <0) {moreorless = "more"}
					else {moreorless = "the same"}
					
					if(moreorless != "the same"){
						var diffs = "<b>Women are paid </b><span class='spanper'>" + dvc.format2(Math.abs(filteredsel[0].diffper)) + "% </span><b> " + moreorless + " than men</b>";
					} else {
						var diffs = "<b>Women are paid " + moreorless + " as men</b>";
					}
				} 
				else {
					var diffs = "Pay gap unavailable"
				}
				
				if(filteredsel[0].earnfann > 0) {
					var annF = "  (£"+  dvc.format1(filteredsel[0].earnfann) +  " year)";
				} else {
					var annF = "";
				}
				
				if(filteredsel[0].earnmann > 0) {
					var annM = "  (£"+  dvc.format1(filteredsel[0].earnmann) +  " year)";
				} else {
					var annM = "";
				}
			
			
			
			
			d3.select("#results").append("p").style("padding-left","10px").html(function() {if(filteredsel[0].jobsplitf != 0){return diffs + 
			"<div style='font-size: 14px; padding-top:5px'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#E36A32' d='M30.8,22.8c6.3,0,11.4-5.1,11.4-11.4C42.2,5.1,37.1,0,30.8,0c-6.3,0-11.4,5.1-11.4,11.4C19.4,17.7,24.5,22.8,30.8,22.8 M61.5,72.1l-6.3-32.2c-1.1-6.8-7.2-14.6-16.9-14.6H23.3c-9.7,0-15.8,7.8-16.9,14.6L0.1,72.1c-0.4,2.1,1.1,4.2,3.2,4.5c2.1,0.4,3.9-1.1,4.5-3.2l8.2-27c0.1-0.5,0.6-0.8,1.1-0.6c0.5,0.1,0.8,0.6,0.6,1.1l-10.4,45c-0.3,1.6,0.8,3,2.4,3l3,0c1.7,0,3.3,1.4,3.5,3l4.4,27.2c0.3,1.7,1.8,3,3.5,3h12.9c1.7,0,3.2-1.4,3.5-3l3.7-27.2c0.2-1.7,1.8-3,3.5-3l3,0c1.7,0,2.8-1.3,2.4-3l-9.4-45c-0.1-0.5,0.2-1,0.6-1.1c0.5-0.1,1,0.2,1.1,0.6l8.2,27c0.6,2.1,2.4,3.6,4.5,3.2C60.4,76.3,61.8,74.2,61.5,72.1'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + femearn  + "</b>" + annF + "</p</div>" +
									 "<div style='font-size: 14px; padding-top: 5px; padding-bottom: 5px'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#332288' d= 'M26.3,22.8c6.3,0,11.4-5.1,11.4-11.4C37.7,5.1,32.6,0,26.3,0S14.9,5.1,14.9,11.4C14.9,17.7,20,22.8,26.3,22.8 M51.4,43.3c0.5-6.9-4.7-18-16.2-18H16.5C5,25.3-0.2,36.5,0.3,43.3L0,76c0.1,2.2,2,3.8,4.2,3.6c2.2-0.1,3.6-2,3.6-4.2l1.7-26.7c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9v76.1c0,1.7,1.4,3,3,3h5.3c1.7,0,2.9-1.2,3-3l1.9-42.3c0.1-1.1,0.1-1.9,1.1-1.9h0.1c1.1,0,1,0.7,1.1,1.9l1.9,42.3c0.1,1.9,1.4,3,3,3h5.3c1.7,0,3-1.4,3-3l0-76.1h0c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9l1.7,26.7c0.1,2.2,1.5,4,3.6,4.2c2.2,0.1,4-1.5,4.2-3.6L51.4,43.3z'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + maleearn  + "</b>" + annM + "</p></div>" + 
	"<div style='font-size: 14px;'>Women hold <b>" + dvc.format1(filteredsel[0].jobsplitf*100) + "%</b> of these jobs</div>" + 
	"<div><span style='display: table-cell; height:10px; width:" + (252*filteredsel[0].jobsplitf)+ "px; background-color:#E36A32;'></span><span style='display: table-cell; height:10px; width:" + (252*filteredsel[0].jobsplitm)+ "px; background-color:#332288;'></span></div>";
			} else {return diffs + 
			"<div style='font-size: 14px; padding-top:5px'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#E36A32' d='M30.8,22.8c6.3,0,11.4-5.1,11.4-11.4C42.2,5.1,37.1,0,30.8,0c-6.3,0-11.4,5.1-11.4,11.4C19.4,17.7,24.5,22.8,30.8,22.8 M61.5,72.1l-6.3-32.2c-1.1-6.8-7.2-14.6-16.9-14.6H23.3c-9.7,0-15.8,7.8-16.9,14.6L0.1,72.1c-0.4,2.1,1.1,4.2,3.2,4.5c2.1,0.4,3.9-1.1,4.5-3.2l8.2-27c0.1-0.5,0.6-0.8,1.1-0.6c0.5,0.1,0.8,0.6,0.6,1.1l-10.4,45c-0.3,1.6,0.8,3,2.4,3l3,0c1.7,0,3.3,1.4,3.5,3l4.4,27.2c0.3,1.7,1.8,3,3.5,3h12.9c1.7,0,3.2-1.4,3.5-3l3.7-27.2c0.2-1.7,1.8-3,3.5-3l3,0c1.7,0,2.8-1.3,2.4-3l-9.4-45c-0.1-0.5,0.2-1,0.6-1.1c0.5-0.1,1,0.2,1.1,0.6l8.2,27c0.6,2.1,2.4,3.6,4.5,3.2C60.4,76.3,61.8,74.2,61.5,72.1'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + femearn  + "</b>" + annF + "</p</div>" +
									 "<div style='font-size: 14px; padding-top: 5px; padding-bottom: 5px'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#332288' d= 'M26.3,22.8c6.3,0,11.4-5.1,11.4-11.4C37.7,5.1,32.6,0,26.3,0S14.9,5.1,14.9,11.4C14.9,17.7,20,22.8,26.3,22.8 M51.4,43.3c0.5-6.9-4.7-18-16.2-18H16.5C5,25.3-0.2,36.5,0.3,43.3L0,76c0.1,2.2,2,3.8,4.2,3.6c2.2-0.1,3.6-2,3.6-4.2l1.7-26.7c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9v76.1c0,1.7,1.4,3,3,3h5.3c1.7,0,2.9-1.2,3-3l1.9-42.3c0.1-1.1,0.1-1.9,1.1-1.9h0.1c1.1,0,1,0.7,1.1,1.9l1.9,42.3c0.1,1.9,1.4,3,3,3h5.3c1.7,0,3-1.4,3-3l0-76.1h0c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9l1.7,26.7c0.1,2.2,1.5,4,3.6,4.2c2.2,0.1,4-1.5,4.2-3.6L51.4,43.3z'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + maleearn  + "</b>" + annM + "</p></div>" +
"<div style='font-size: 14px;'>Employment split unavailable</div>";
			}
			});
			
			
			urlshare = document.referrer.split("?")[0];
			
			
			d3.select("#share").append("a")
				.attr("href","https://www.facebook.com/sharer/sharer.php?u=" + urlshare)
				.attr("target","_blank")
				.attr("class","share")
				.style("display","block")
				.style("height","25px")
				.style("width","25px")
				.style("background","#3B5998")
				.style("margin-top","5px")
				.style("margin-bottom","10px")
				.append("img")
				.style("padding-left","5px")
				.style("padding-top","5px")
				.attr("src","./images/facebook.svg");
				
			d3.select("#share").append("a")
				.attr("href",encodeURI("https://twitter.com/intent/tweet?text=The gender pay gap for my occupation is " + dvc.format1(filteredsel[0].diffper) + "%. What is yours? " + urlshare))
				.attr("target","_blank")
				.attr("class","share")
				.style("display","block")
				.style("height","25px")
				.style("width","25px")
				.style("background","#4099FF")
				.append("img")
				.style("height","22px")
				.style("width","22px")
				.style("padding-left","3px")
				.style("padding-top","3px")
				.attr("src","./images/twitter.svg");
				
				
		
						
			//Scroll to relevant	
			d3.select("#graphic").transition().duration(3000).delay(1000).tween("uniquetweenname", scrollTopTween((index*dvc.optional.lineheight[mobtabdesk])-200));
			
			
			setTimeout(function(){
			pymChild.sendHeight();
			},1001);
			
	}

	function scrollTopTween(scrollTop) {
	  return function() {
		var i = d3.interpolateNumber(this.scrollTop, scrollTop);
		return function(t) { this.scrollTop = i(t); };
	 };
	}
	
	
	function sortme(varsel){
		if(filtergroupx ==true){
			linesubsel = linesubsel;
		} else {
			linesubsel = lines;
		}
		
		d3.selectAll(".sort").classed("active");
		
		if(varsel =="gpg_pnd"){
			linesubsel.sort(function(a,b) {return b.diff-a.diff});
		}
		else if (varsel =="gpg_pct"){
			linesubsel.sort(function(a,b) {return b.diffper-a.diffper});
		}
		else if(varsel =="sal"){
			linesubsel.sort(function(a,b) {return b.mymedian-a.mymedian});
		};

			y.domain(linesubsel.map(function(d) { return d.name; }));
			
			yAxis = d3.svg.axis().scale(y).orient("left");
			
			d3.select(".y.axis").transition().duration(2000).call(yAxis).selectAll("text").attr("x", -margin.left).style("text-anchor", "start");
			
		d3.selectAll(".y text")
				.each(insertLinebreaks);	
					
			tieFight(linesubsel);

		    //d3.select("#graphic").transition().duration(3000).delay(3000).tween("uniquetweenname", scrollTopTween(2000));
			
	
	}
	
	function filterfirst(){
		
		d3.select('#static_graphic').transition().duration(2000).attr("height","120px");
		
		
		index = lines.map(function(d) { return d.code; }).indexOf(filteredocc)
		filteredsel = lines.filter(function(d,i) {return d.code == filteredocc;});
				
		tieFightTop();
		
	}
	function filterremove(){
				
		d3.select("#results").style("opacity",0);
		d3.select("#results").transition().duration(1000).style("height","0px").style("opacity",0);
			
		d3.select("#share").style("opacity",0);
		d3.select("#share").transition().duration(1000).style("height","0px").style("opacity",0);
			
	
	}
	
	
	function filtergroup(linesubsel){
		
		filtergroupx =true;
		
	
		y = d3.scale.ordinal()
			.rangePoints([0, height], .3);
		
		
		var numobs = linesubsel.length;

		    if (graphicwidth < threshold_sm) {
	            height = (dvc.optional.lineheight[0]*numobs) - margin.top - margin.bottom;
		    } else if (graphicwidth < threshold_md){ 
		        height = (dvc.optional.lineheight[1]*numobs) - margin.top - margin.bottom;
		  	} else { ball = 6; 
		        height = (dvc.optional.lineheight[2]*numobs) - margin.top - margin.bottom;
			}
			
		d3.select('#graphic').select('svg')
				        .attr("height", height + margin.top + margin.bottom +30)	
		
		y = d3.scale.ordinal()
			.rangePoints([0, height], .3);
		
		y.domain(linesubsel.map(function(d) { return d.name; }));
			
		yAxis = d3.svg.axis().scale(y).orient("left");
			
		d3.select(".y.axis").transition().duration(2000).call(yAxis).selectAll("text").attr("x", -margin.left).style("text-anchor", "start");
			
			
		d3.selectAll(".y text")
			.each(insertLinebreaks);	
		
		
		tieFight(linesubsel);
		
	}
	
	function showTooltip(d, sel) {
	
			var element = sel;
						
			if ( graphicwidth > dvc.optional.mobileBreakpoint ) {
				
				//work out content upfront
				
				if(d.mymax > 0){
					var femearn = "<b> £" + dvc.format3(d.mymax)+ "</b> per hr";
				} 
				else {
					var femearn = " earnings unavailable"
				}
				
				if(d.mymin > 0){
					var maleearn = "<b> £" + dvc.format3(d.mymin)+ "</b> per hr";
				} 
				else {
					var maleearn = " earnings unavailable"
				}
				
				if(d.diffper != -999999){
					var diffs = "Pay gap of <b>" + dvc.format2(d.diffper)+ "%</b>";
					
				} 
				else {
					var diffs = "Pay gap unavailable"
				}
				
				if(d.earnfann > 0) {
					var annF = "  (£"+  dvc.format1(d.earnfann) +  " year)";
				} else {
					var annF = "*";
				}
				
				if(d.earnmann > 0) {
					var annM = "  (£"+  dvc.format1(d.earnmann) +  " year)";
				} else {
					var annM = "*";
				}
				
			
					$(element).popover({
							title: function() {return  "<div style='font-size: 14px;'><b>" + d.name + "</b>"} ,
							placement: 'auto',
							container: '#graphic',
							id:"toolTip",
							trigger: 'manual',
							html : true,
							content: function() { 
							
							
							
								if(d.jobsplitf != 0){
									return "<div style='font-size: 14px;'>" + diffs + "</div><br>" +
									 "<div style='font-size: 14px;'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#E36A32' d='M30.8,22.8c6.3,0,11.4-5.1,11.4-11.4C42.2,5.1,37.1,0,30.8,0c-6.3,0-11.4,5.1-11.4,11.4C19.4,17.7,24.5,22.8,30.8,22.8 M61.5,72.1l-6.3-32.2c-1.1-6.8-7.2-14.6-16.9-14.6H23.3c-9.7,0-15.8,7.8-16.9,14.6L0.1,72.1c-0.4,2.1,1.1,4.2,3.2,4.5c2.1,0.4,3.9-1.1,4.5-3.2l8.2-27c0.1-0.5,0.6-0.8,1.1-0.6c0.5,0.1,0.8,0.6,0.6,1.1l-10.4,45c-0.3,1.6,0.8,3,2.4,3l3,0c1.7,0,3.3,1.4,3.5,3l4.4,27.2c0.3,1.7,1.8,3,3.5,3h12.9c1.7,0,3.2-1.4,3.5-3l3.7-27.2c0.2-1.7,1.8-3,3.5-3l3,0c1.7,0,2.8-1.3,2.4-3l-9.4-45c-0.1-0.5,0.2-1,0.6-1.1c0.5-0.1,1,0.2,1.1,0.6l8.2,27c0.6,2.1,2.4,3.6,4.5,3.2C60.4,76.3,61.8,74.2,61.5,72.1'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + femearn  + "</b>" + annF + "</p</div>" +
									 "<div style='font-size: 14px; padding-top: 5px; padding-bottom: 5px'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#332288' d= 'M26.3,22.8c6.3,0,11.4-5.1,11.4-11.4C37.7,5.1,32.6,0,26.3,0S14.9,5.1,14.9,11.4C14.9,17.7,20,22.8,26.3,22.8 M51.4,43.3c0.5-6.9-4.7-18-16.2-18H16.5C5,25.3-0.2,36.5,0.3,43.3L0,76c0.1,2.2,2,3.8,4.2,3.6c2.2-0.1,3.6-2,3.6-4.2l1.7-26.7c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9v76.1c0,1.7,1.4,3,3,3h5.3c1.7,0,2.9-1.2,3-3l1.9-42.3c0.1-1.1,0.1-1.9,1.1-1.9h0.1c1.1,0,1,0.7,1.1,1.9l1.9,42.3c0.1,1.9,1.4,3,3,3h5.3c1.7,0,3-1.4,3-3l0-76.1h0c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9l1.7,26.7c0.1,2.2,1.5,4,3.6,4.2c2.2,0.1,4-1.5,4.2-3.6L51.4,43.3z'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + maleearn  + "</b>" + annM + "</p></div>" +
									 "<div style='font-size: 14px;'>Women hold <b>" + dvc.format1(d.jobsplitf*100) + "%</b> of these jobs</div>" + 
									 "<div><span style='display: table-cell; height:10px; width:" + (252*d.jobsplitf)+ "px; background-color:#E36A32;'></span><span style='display: table-cell; height:10px; width:" + (252*d.jobsplitm)+ "px; background-color:#332288;'></span></div>";
								 } else {
									return "<div style='font-size: 14px;'>" + diffs + "</div><br>" +
									 "<div style='font-size: 14px;'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#E36A32' d='M30.8,22.8c6.3,0,11.4-5.1,11.4-11.4C42.2,5.1,37.1,0,30.8,0c-6.3,0-11.4,5.1-11.4,11.4C19.4,17.7,24.5,22.8,30.8,22.8 M61.5,72.1l-6.3-32.2c-1.1-6.8-7.2-14.6-16.9-14.6H23.3c-9.7,0-15.8,7.8-16.9,14.6L0.1,72.1c-0.4,2.1,1.1,4.2,3.2,4.5c2.1,0.4,3.9-1.1,4.5-3.2l8.2-27c0.1-0.5,0.6-0.8,1.1-0.6c0.5,0.1,0.8,0.6,0.6,1.1l-10.4,45c-0.3,1.6,0.8,3,2.4,3l3,0c1.7,0,3.3,1.4,3.5,3l4.4,27.2c0.3,1.7,1.8,3,3.5,3h12.9c1.7,0,3.2-1.4,3.5-3l3.7-27.2c0.2-1.7,1.8-3,3.5-3l3,0c1.7,0,2.8-1.3,2.4-3l-9.4-45c-0.1-0.5,0.2-1,0.6-1.1c0.5-0.1,1,0.2,1.1,0.6l8.2,27c0.6,2.1,2.4,3.6,4.5,3.2C60.4,76.3,61.8,74.2,61.5,72.1'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + femearn  + "</b>" + annF + "</p</div>" +
									 "<div style='font-size: 14px; padding-top: 5px; padding-bottom: 5px'><svg style='float:left' preserveAspectRatio height='32px' width='24px'><path transform='scale(0.25)' fill='#332288' d= 'M26.3,22.8c6.3,0,11.4-5.1,11.4-11.4C37.7,5.1,32.6,0,26.3,0S14.9,5.1,14.9,11.4C14.9,17.7,20,22.8,26.3,22.8 M51.4,43.3c0.5-6.9-4.7-18-16.2-18H16.5C5,25.3-0.2,36.5,0.3,43.3L0,76c0.1,2.2,2,3.8,4.2,3.6c2.2-0.1,3.6-2,3.6-4.2l1.7-26.7c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9v76.1c0,1.7,1.4,3,3,3h5.3c1.7,0,2.9-1.2,3-3l1.9-42.3c0.1-1.1,0.1-1.9,1.1-1.9h0.1c1.1,0,1,0.7,1.1,1.9l1.9,42.3c0.1,1.9,1.4,3,3,3h5.3c1.7,0,3-1.4,3-3l0-76.1h0c0-0.5,0.4-0.9,0.9-0.9c0.5,0,0.9,0.4,0.9,0.9l1.7,26.7c0.1,2.2,1.5,4,3.6,4.2c2.2,0.1,4-1.5,4.2-3.6L51.4,43.3z'/></svg><p style='height:32px; text-align:center; display: table-cell; vertical-align: middle'>" + maleearn  + "</b>" + annM + "</p></div>" + 
									 "<div style='font-size: 14px;'>Employment split unavailable</div>";
									
								 }
								 
								 
							}
						 
					});
					$(element).popover('show');
					
	
			}// end if ...
			
	
			
	}//end function showTooltip
	
	function removeTooltip() {
		
			$('.popover').each(function() { $(this).remove(); });

	}//function removeTooltip	
	
	function insertLinebreaks() {
								
		var str = $(this).text();
		

		if(str.length > 28){
			
			var middle = Math.floor(str.length / 2);
			var before = str.lastIndexOf(' ', middle);
			var after = str.indexOf(' ', middle + 1);
			
			if (middle - before < after - middle) {
				middle = before;
			} else {
				middle = after;
			}
			
			var s1 = str.substr(0, middle);
			var s2 = str.substr(middle + 1);
	
			d3.select(this).text("");
	
			d3.select(this).append('tspan').text(s1).attr("x",-margin.left).attr("y",tspanupper);//-7
			d3.select(this).append('tspan').text(s2).attr("x",-margin.left).attr("y",tspanlower);//8
		
		} else {
			
			d3.select(this).attr("x",-margin.left);
		}
	};
	


	}
	) 
}

