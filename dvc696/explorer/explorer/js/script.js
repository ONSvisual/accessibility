//namespace any global variables
var dvc = {};


if (Modernizr.inlinesvg)
{
	//remove preview image/message if browser suppports SVG
	d3.select("#altern").remove();
	pymChild = new pym.Child();

	//Load main script/data
	$(document).ready(function()
	{
		//main script

	d3.json("assets/config.json", function(error, config) {
			dvc=config;

			console.log(dvc);

			//Load the data
			d3.csv("assets/data.csv", function(error, data) {

				console.log(data);
				graphic_data = data;

				occopt();

				pymChild = new pym.Child({ renderCallback: drawGraphic});
				pymChild.sendHeight();
			});
	});



	//Function to create drop down
	function occopt () {
		console.log("I'm here")

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

		console.log(dvc.codeoccyzip);

		// Build option menu for occupations
		var optns = d3.select("#occupation").append("div").attr("id","sel").append("select")
				.attr("id","occselect")
				.attr("style","width:90%")
				.attr("class","chosen-select")


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


			$('#occselect').chosen({width: "90%", allow_single_deselect: true, placeholder_text_single:"Occupation"}).on('change',function(evt,params){

								if(typeof params != 'undefined') {
//										var firstno = params.selected.slice(0,1);
//										// If a selection has been made highlight the circle and use the earnings value from the circle and update the text
//										d3.select("#occ" + params.selected).classed("fill" + firstno, true).attr("r","7").each(function(d,i){makeChart([d.earningsm,d.earningsf]); dvc.currtext = d.occupation + "<br><span> £"+ dvc.nformat(d.earningsa) + "</span>"}).moveToFront();
//										d3.select("#occ").html(dvc.currtext);
//										d3.selectAll('.chartcircles').attr("pointer-events","none");
//										dvc.occupation = params.selected;
//										dvc.panel=0;
//										updateHash();
								}
								else {
										// Remove any selections
//
//										d3.selectAll(".chartcircles").attr("class","chartcircles").attr("r",5).attr("opacity","0.6").attr("pointer-events","all");
//										dvc.occupation = 0;
//										updateHash();
								}

			});

			console.log(d3.select("#sel").select(".chosen-single"))

			d3.select("#sel").select(".chosen-single").attr("tabindex","1")


	} //End of make occupation

		function drawGraphic(width) {
		   var graphic = $('#graphic');
		   var threshold_md = 788;
		   var threshold_sm = dvc.optional.mobileBreakpoint; // 510

		  	//set variables for chart dimensions dependent on width of #graphic
		    if (graphic.width() < threshold_sm) {  var ball = 6;
		            var margin = {top: dvc.optional.margin_sm[0], right: dvc.optional.margin_sm[1], bottom: dvc.optional.margin_sm[2], left: dvc.optional.margin_sm[3]};
					var chart_width = graphic.width() - margin.left - margin.right;
		            var height = Math.ceil((chart_width * dvc.optional.aspectRatio_sm[1]) / dvc.optional.aspectRatio_sm[0]) - margin.top - margin.bottom;
		    } else if (graphic.width() < threshold_md){  var ball = 8;
		        	var margin = {top: dvc.optional.margin_md[0], right: dvc.optional.margin_md[1], bottom: dvc.optional.margin_md[2], left: dvc.optional.margin_md[3]};
					var chart_width = graphic.width() - margin.left - margin.right;
		            var height = Math.ceil((chart_width * dvc.optional.aspectRatio_md[1]) / dvc.optional.aspectRatio_md[0]) - margin.top - margin.bottom;
		  	} else {  var ball = 8;
		        	var margin = {top: dvc.optional.margin_lg[0], right: dvc.optional.margin_lg[1], bottom: dvc.optional.margin_lg[2], left: dvc.optional.margin_lg[3]}
					var chart_width = graphic.width() - margin.left - margin.right;
		            var height = Math.ceil((chart_width * dvc.optional.aspectRatio_lg[1]) / dvc.optional.aspectRatio_lg[0]) - margin.top - margin.bottom;
			}

		    // clear out existing graphics
		    graphic.empty();
			//keypoints.empty();
			//footer.empty();

			var x = d3.scale.linear()
		        .range([ 0, chart_width]);

			var y = d3.scale.ordinal()
			.rangePoints([0, height], .3);
				//.rangeRoundBands([0, height]);  // .1


		    var yAxis = d3.svg.axis()
		        .scale(y)
		        .orient("left")

		    var xAxis = d3.svg.axis()
		        .scale(x)
		        .orient('bottom');

			//specify number or ticks on x axis
			if (graphic.width() <= threshold_sm) {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[0])
			 } else if (graphic.width() <= threshold_md){
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[1])
			 } else {
				xAxis.ticks(dvc.optional.x_num_ticks_sm_md_lg[2])
			 }

		    //gridlines
		    var x_axis_grid = function() { return xAxis; }

		   //helper classes for generating path data
		  /*var line = d3.svg.line()
		        		.y(function(d,i) { return y(d.name); })
		        		.x(function(d,i) { return x(d.mymax); });*/


		    // parse data into columns
		   /*  var bars = {};
		    for (var column in graphic_data[0]) {
		       // if (column == 'name') continue;

		        bars[column] = graphic_data.map(function(d,i) {  //console.log( d+ " " +i);
		            return {
		               // 'name': d.name,
		                'smal': d.imin,  //[column]
						'bigg': +d.imax,
						'amedian': +d.median
		            };
		        });
		   }*/

		          lines = graphic_data.map(function(d,i) {
					if(+d.earningsfullm ==0 || +d.earningsfullf ==0 ){  //console.log(d + " " +i);
						return {
							'name': d.occupation,   // might not need since we mappe it in y.domain earlier
							'mymin': +d.earningsfullm,   // + changes string to numeric.
							'mymax': +d.earningsfullf,
							'mymedian': +d.earningsfulla,
							'diff': -999999
						}
					}else {
						return {
							'name': d.occupation,   // might not need since we mappe it in y.domain earlier
							'mymin': +d.earningsfullm,   // + changes string to numeric.
							'mymax': +d.earningsfullf,
							'mymedian': +d.earningsfulla,
							'diff': +d.earningsfullm - +d.earningsfullf
						}
					}
		        });

				//lines.sort(function(a,b) {return b.diff-a.diff});
				lines.sort(function(a,b) {return b.mymedian-a.mymedian});

				y.domain(lines.map(function(d) { return d.name; }));

				console.log(lines);


				var memax = d3.max(lines, function(d){
													return d.mymax;
													});

				var memin = d3.min(lines, function(d){
													return d.mymin;
													});

				console.log("memin: "+memin+"  memax: "+memax);

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
					  var xDomain = dvc.essential.xAxisScale;
					  var yDomain = dvc.essential.yAxisScale;

					}


				console.log(xDomain);
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
				        .attr("width", chart_width + margin.left + margin.right)
				        .attr("height", height + margin.top + margin.bottom +30)
				        .append("g")
				        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

					svg.append("rect")
						.attr("class","svgRect")
						.attr("width", chart_width)
						.attr("height", height);

				    svg.append('g')
				        .attr('class', 'x axis')
				        .attr("transform", "translate(0, "+height+")")
				        .call(xAxis).append("text")
						 .attr("y", 25)
						 .attr("x",chart_width)
						 .attr("dy", ".71em")
						 .style("text-anchor", "end")
						 .text(dvc.essential.xAxisLabel);

				    svg.append('g')
				        .attr('class', 'x grid')
				        .call(x_axis_grid()
				            .tickSize(height, 0, 0)
				            .tickFormat('')
				        );

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
				        .call(yAxis);

		tieFight();

	function tieFight() {
			//console.log("ball "+ ball);

			console.log(lines);

//			groups = svg.selectAll('g')
//						.data(lines)
//						.append('g');

			svg.append('g').attr("class","line").selectAll('.line')
					.data(lines) //  ["value"]
					.enter()
					.append('line')
					.attr('class', function(d, i) {
			                if ( d.mymin <0 ) {
								return 'tiefighter line_neg';
							} else {
								return 'tiefighter line_pos';
							}
			            })
					.style("stroke","#abc")
					.style("opacity", function(d,i){
						if(d.mymin==0 || d.mymax==0)
							 {return 0}
						else {return 1}
					})
					.attr('y1', function(d,i) { //console.log("y1 "+i+" "+y(d.name));
												return y(d.name); })
					.attr('y2', function(d) { return y(d.name); })
					.attr('x1', function(d,i) {return x(d.mymin); })  //d.mymin
					.attr('x2', function(d) { return x(d.mymax); });

					//svg.selectAll('.tiefighter')//.append("svg")
					svg.append('g').selectAll('.circle')
					.data(lines)
					.enter()
					.append('circle')
					.style("opacity", function(d,i){
						if(d.mymin == 0)
							 {return 0}
						else {return 1}
					})
					.attr("class","circle1")
					.attr('cx',function(d,i) { return x(d.mymin); })
					.attr('cy',function(d,i) {return y(d.name); })
					.attr('r', ball);

					svg.append('g').selectAll('.circle')
					.data(lines)
					.enter()
					.append('circle')
					.style("opacity", function(d,i){
						if(d.mymax==0)
							 {return 0}
						else {return 1}
					})
					.attr("class","circle2")  // make it .circle2 for different end colour
					.attr('cx',function(d,i) { return x(d.mymax); })
					.attr('cy',function(d,i) {return y(d.name); })
					.attr('r', ball); // (1/lines.length)*40);


				columnH = d3.keys(graphic_data[0]).filter(function(key) { return key;});
				if (columnH[3] == "median")
				{
					svg.append('g').selectAll('.med')
					.data(lines)
					.enter()
					.append('circle')
					.attr("class","med")
					.attr('cx',function(d,i) { return x(d.mymedian); })
					.attr('cy',function(d,i) {return y(d.name); })
					.attr('r', ball*1.5);
					}

			}


					//create centre line if required
					if (dvc.optional.centre_line == true){
							svg.append("line")
							.attr("id","centreline")
							.attr('y1',0)
							.attr('y2',height)
							.attr('x1',x(dvc.optional.centre_line_value))
							.attr('x2',x(dvc.optional.centre_line_value));

					} else if(xDomain[0] <0){
						//svg.append("line")
						svg.append("line")
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


	}
	)
}
