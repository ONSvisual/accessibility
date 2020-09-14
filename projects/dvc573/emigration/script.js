 function drawGraphic(data){

	d3.select("#fallback").remove();

	var format = d3.f,
   //
		parseMyTime = d3.timeParse(dvc.essential.dateFormat), // date is in whole yr format
		formatMyTime = d3.timeFormat(dvc.essential.dateFormat); // date is in whole yr format

	var threshold_sm = dvc.optional.mobileBreakpoint[0],
		threshold_md = dvc.optional.mobileBreakpoint[1];

		var selection = d3.select('#graphic');

		if (parseInt(d3.select('#graphic').style("width")) <= threshold_sm) {
		 margin = {		top:+dvc.optional.margin_sm[0],
						right:+dvc.optional.margin_sm[1],
						bottom:+dvc.optional.margin_sm[2],
						left: +dvc.optional.margin_sm[3]
					};
		} else if (parseInt(d3.select('#graphic').style("width")) <= threshold_md){
		  margin = {	top:+dvc.optional.margin_md[0],
						right:+dvc.optional.margin_md[1],
						bottom:+dvc.optional.margin_md[2],
						left: +dvc.optional.margin_md[3]
					};
		} else {
		  margin = {	top:+dvc.optional.margin_lg[0],
						right:+dvc.optional.margin_lg[1],
						bottom:+dvc.optional.margin_lg[2],
						left: +dvc.optional.margin_lg[3]
					};
		}
		// Let's begin building

		chart_width = parseInt(d3.select('#graphic').style("width")) - margin.left - margin.right;
		if(chart_width + margin.left + margin.right > 600) chart_width = 600 - margin.left - margin.right;

		x = d3.scaleTime()
			.range([0, chart_width]);

		y = d3.scaleLinear();

		xAxis = d3.axisBottom(x).tickSize(7);
		yAxis = d3.axisRight(y).tickSize(-chart_width);


		//specify number or ticks on y axis
			if (parseInt(d3.select('#graphic').style("width")) <= threshold_sm+100) { //console.log("Mobile");
				xAxis.tickValues([new Date('June 1, 2012 00:00:00'), new Date('June 1, 2014 00:00:00'),new Date('June 1, 2016 00:00:00'),new Date('June 1, 2018 00:00:00')]);
				yAxis.ticks(dvc.optional.y_num_ticks_sm_md_lg[0]);

				var height = 300;
				rad = 5;
			 } else /*if (parseInt(d3.select('#graphic').style("width")) <= threshold_md)*/{ //console.log("Tablet");
				xAxis.tickValues([new Date('June 1, 2012 00:00:00'),new Date('June 1, 2013 00:00:00'),new Date('June 1, 2014 00:00:00'),new Date('June 1, 2015 00:00:00'),new Date('June 1, 2016 00:00:00'),new Date('June 1, 2017 00:00:00'),new Date('June 1, 2018 00:00:00')]);

				var height = 300;
				rad = 5;
			 }


		var svg = d3.select('#graphic').append('svg')
				.attr("width", chart_width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom + 25) // for x-axis drop + Safari won't draw outside svg container
				.append("g")
				.attr("cursor", "pointer")
				.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

		// This is used for the d3.drag to operate within - without it daint work
	 	svg.append('rect')
				.attr("width", chart_width )
				.attr("height", height )
				.attr("opacity",0)

		x.domain(d3.extent(data, function(d) { return d.year; }) );

		// var myMax = Math.ceil(mx),
		// 	myMin = Math.floor(mn);

		y.range([height, 0]).domain([dvc.essential.domMin, dvc.essential.domMax]);

		yAxis.tickFormat(function(d,i) {
                    var yfmt = d3.format(",." + dvc.essential.decimalPlaces + "f");  // var fomat = d3.format(",.1f");
                                d = yfmt(d);
                                return d;
                            });

		// ticks back to Q1 if using Quarters
		xAxis.tickSize(-height).tickFormat(function(d,i) {
            if (dvc.essential.period === "quarter") {
                var fmt = d3.timeFormat('%y');

				cond = formatMyTime(d).slice(0,3);
					//if(cond === "Jan") d = formatMyTime(d).replace("Jan", "Q1");
					if(cond === "Jan") d = "Q1 " + '\u2019' + fmt(d);
					if(cond === "Apr") d = "Q2 " + '\u2019' + fmt(d);
					if(cond === "Jul") d = "Q3 " + '\u2019' + fmt(d);
					if(cond === "Oct") d = "Q4 " + '\u2019' + fmt(d);

                return d;
            } else if (dvc.essential.period === "month") {
                 var fmt = d3.timeFormat('%y');
				cond = formatMyTime(d).slice(0,3); // !these may change
				cond2 = formatMyTime(d).slice(0,1);

					//if(cond === "Jan") d = formatMyTime(d).replace("Jan", "Q1");
					if(cond === "Jan") d = cond + ' \u2019' + fmt(d);
					if(cond === "Apr") d = cond + ' \u2019' + fmt(d);
					if(cond === "Jul") d = cond + ' \u2019' + fmt(d);
					if(cond === "Oct") d = cond + ' \u2019' + fmt(d);
                return d;
            } else {
				var fmt = d3.timeFormat(dvc.essential.dateFormat);
				d = fmt(d);
				return d;
			}
        });

      var fmt = d3.timeFormat("%b %y");
	  
	  
      xAxis.tickFormat(function(d,i){return "YE " + fmt(d); })

			//create x axis, if y axis doesn't start at 0 drop x axis accordingly
					svg.append('g')
				        .attr('class', 'x axis')
				        .attr('transform', function(d){
				        			if(y.domain()[0] != 0){
										return 'translate(0,' + (height + 25) + ')'
									} else {
										return 'translate(0,' + height  + ')'
									}
							})
				        .call(xAxis);

				svg.append("g")
					  	.attr("class", "y axis")
						.attr('transform', 'translate(' + (chart_width + 20) + ', 0 )' )
					  	.call(yAxis);

				d3.select('g.y.axis').select('path.domain').remove();
				d3.select('.y.axis').selectAll('line').attr('transform', 'translate(' + (-20) + ', 0)' );
        d3.select('.y.axis').selectAll('text').attr('transform', 'translate(' + (-10) + ', 0)' );
        d3.select('.x.axis').selectAll('text').attr('transform', 'translate(0, 10)' );


				svg.append("text")
					 .attr('class', 'unit')
					 .attr('transform',"translate(" + (margin.left + chart_width - 48) + ", -20)") //+margin.left
					 .text(function(d,i) { return dvc.essential.yAxisLabel});

		  // gridlines
			//var x_axis_grid = function() { console.log(xAxis); return xAxis; }
			//var x_axis_grid = svg.append("g").append("line").attr("id","gridline");
			// data.forEach(function(d,i) { if(i%4 == 0 || i == 0 || i == data.length-1 ){
			// 	svg.append("line")
			// 		.attr("class", "gridDash")
			// 		.attr("id", function(){ return "gridline"+i} )
			// 								.style("stroke", "#ccc")
			// 								.attr('y1',y(y.domain()[0]) )
			// 								.attr('y2',y(y.domain()[1]) )
			// 								.attr('x1', function() { // console.log(d.year);
			// 												return x(d.year);
			// 								})
			// 								.attr('x2',function() {
			// 												return x(d.year);
			// 								});
			// 		} // ends if
			// 	});
				// Delete first gridline to leave yaxis
				//d3.select("#gridline0").remove();



		var area = d3.area()
					 //.x(format('year', x))  // format = d3.f;
					 .x(function(d){ return  x(d.year)})
					 //.y0(format('debt', y))
					 .y0(function(d){ return  y(d.debt)})
					 //.y1(height);
					 .y1(function(d){ return  y(0)});

		var line = d3.line()
					 .x(format('year', x))
					 .y(format('debt', y));

									var cutOff = parseMyTime(dvc.essential.dateCutOff),
										finishChart = parseMyTime(dvc.essential.dateEnd), // dateStart - for reverse drawing
										endChart = parseMyTime(dvc.essential.dateCutOff),
										firstChart = parseMyTime(dvc.essential.dateStart),
										clipWidth = x(cutOff)  // x(finishChart) - x(endChart);
										//console.log("cutoff  finishChart  endChart  firstChart  clipWidth" );
										//console.log(x(cutOff),x(finishChart),x(endChart),x(firstChart),x(clipWidth) );

									var clipRect = svg.append('clipPath#clip')
													  .append('rect')
													  .attr('width', clipWidth) //x(cutOff)  end date - start date = area shown  === formatMyTime(cutOff)
													  .attr('height', height)
													 // .attr('transform',"translate(" + (x(cutOff)) + ", 0)");
													 // .attr('transform', 'translate(300,0)' );

									var correctSel = svg.append('g')
														.attr('clip-path', 'url(#clip)');
									// Now add line and area
									correctSel.append('path.area').attr('d', function(){ return area(data); });
									correctSel.append('path.line').attr('d', function(){ return line(data); });

									// Add your line -
									yourDataSel = svg.append('path.your-line');

		//create centre line if required
			if (dvc.optional.centre_line == true){
				svg.append("line")
					.attr("id","centreline")
					.attr('y1',y(dvc.optional.centre_line_value))
					.attr('y2',y(dvc.optional.centre_line_value))
					.attr('x1',0)
					.attr('x2',x.range()[1]);
			} else if(y.domain()[0] < 0) {
				svg.append("line")
					.attr("id","centreline")
					.attr('y1',y(0))
					.attr('y2',y(0))
					.attr('x1',0)
					.attr('x2',x.range()[1]);
			};

		theChaser();
		historicalVals();
		firstMarker();
		writeAnnotation();

		d3.select('#showMe').on('click', (function (e) { showMe(); }) );

		svg.append("g").attr("id", "currYValG")
			.attr("opacity",0)
			.append("text")
			.attr("id", "currYVal")
			.attr("y", -margin.top + 45)  /////////// DOUBLE CHECK THESE HARD VALUES
			.attr("x", chart_width + 13)
			.text("")



		var text = d3.select("#currYVal");
		var bbox = text.node().getBBox();
		var padding = 2;
//console.log(bbox.x, bbox.width, bbox.height);
				svg.select("g #currYValG").insert("rect","#currYVal") // insert before
					.attr("id","backgroundrect")
					.attr("x", bbox.x*2.5 - padding)
					.attr("y", bbox.y - padding)
					.attr("width", bbox.width*4 + (padding*2))
					.attr("height", bbox.height + (padding*2))
					.style("fill", "rgba(255,255,255,0.9)");


		// Add ƒ chaser
function theChaser(){

		var cutOff = parseMyTime(dvc.essential.dateCutOff),
					finishChart = parseMyTime(dvc.essential.dateEnd), // dateStart - should be
					endChart = parseMyTime(dvc.essential.dateCutOff),
					firstChart = parseMyTime(dvc.essential.dateStart),
					clipWidth = x(cutOff);  // x(finishChart) - x(endChart);
					minWidth = x(finishChart) - x(cutOff)
		//console.log(x(finishChart) - x(cutOff), x(cutOff));

				 svg.append("rect").attr("id", "chase")
					.attr("x", clipWidth)
					.attr("y", 0)
					.attr("width", minWidth)
					.attr("height", height)
					.style("fill", "rgba(245, 218, 201,0)");

	}

		// leave left or right margin to use finger to slide on mobile
		if ( parseInt(d3.select('#graphic').style("width") ) < threshold_sm) { //console.log("block me");

		   var blocker = svg.append("rect")
							.attr("id", "mobBlock")
							.attr("x", 0 )
							.attr("y", 0 )
							.attr("height", height )
							.attr("width", chart_width)
							.style("fill", "#003C57")
							.style("opacity", 0.5)
							.on("click", function(){
										d3.select("#mobBlock").remove();
										d3.select("#mobBlockT")/*.attr("visibility", "hidden"); */.remove();
										dragNet();
										});

			var blockerT = svg.append("text")
							.attr("id", "mobBlockT")
							.attr("y", height/2)
							.attr("x", chart_width/2)
							.attr('text-anchor', "middle")
							//.attr("cursor", "default")
							.text("Tap here to start drawing")
							.on("click", function(){ //console.log("removed?");
										d3.select("#mobBlock").remove();
										d3.select("#mobBlockT")/*.attr("visibility", "hidden"); */.remove();
										dragNet();
										});

					} else {
						dragNet();
					}// ends if


	function dragNet(){
		// populatey yourData
		yourData = data.map(function(d){
									return {
												year: d.year,
												debt: d.debt,
												defined: 0
											};
									})
					   				.filter(function(d){
										if (formatMyTime(d.year) === formatMyTime(cutOff) ) d.defined = true;

												return d.year >= cutOff; // so return the years that are <s>more</s> LESS than where you start to draw
											  })
			//	console.log(yourData);
		start = parseMyTime(dvc.essential.clampStart);
		end = parseMyTime(dvc.essential.clampEnd);


		 var drag = d3.drag()
				  .on('drag', function(){

					if(document.getElementsByClassName('animatedCircles') ) d3.select(".animatedCircles").remove();

					var pos = d3.mouse(this); //console.log("mouse pos:"+pos);

					var year = clampX(start, end, x.invert(pos[0])); // inverts, so pixel to domain - that's linear

          if(pos[0]<=(chart_width+2)){
              debt = clampY(dvc.essential.domMin, dvc.essential.domMax, y.invert(pos[1]));
          }
					//console.log("year:" + year + "  debt:" + debt, pos[0], pos[1]);

					var fomat = d3.format(",."+dvc.essential.decimalPlaces+"f");
					d3.select("#currYValG").transition()
											.duration(100)
											.attr('transform',"translate(0, " + y(debt) + ")")
											.attr("opacity",1);

					d3.select("#currYVal").text(fomat(debt));
					currVal = debt;
			//console.log(pos[0], pos[0] - margin.right, x(parseMyTime(dvc.essential.annotationXY[0][0])));


 if (pos[0] >= x(parseMyTime(dvc.essential.dateCutOff)) ) {
															 d3.select("#annotext").remove();
														   }

 		// console.log(pos[0], x(parseMyTime(dvc.essential.dateCutOff)), x(parseMyTime(dvc.essential.dateEnd)) );

						 if (pos[0] >= x(parseMyTime(dvc.essential.dateCutOff)) && x(finishChart) - pos[0] >=0 && x(finishChart) - pos[0] < minWidth) {

																		  d3.select("#chase")
																			.attr("x", pos[0] )
																			.attr("width", x(finishChart) - pos[0])
                                      .style("fill", "rgba(245, 218, 201,0.6)");
																			minWidth = x(finishChart) - pos[0];
																	 }

								yourData.forEach(function(d){ 					// var year = clampX(start, end, x.invert(pos[0]));
										  if (formatMyTime(d.year) === year){  // console.log(debt);// < 0.5){
														d.debt = debt;
														d.defined = true;
												  }
											})  // end yourData


						toDraw = [];
						 yourData.forEach(function(d){
													if (d.defined==true){
																		// push the figure into to Draw if approved - true
																		toDraw.push(d);
																		}
													})


				//	yourDataSel = svg.append('path.your-line');
					yourDataSel.attr("d", function() { //console.log(toDraw);
														return line(toDraw); // was yourData
													}); // this shows it all


					//if (!completed && d3.mean(yourData, format('defined')) == 1) // Or maybe ~0.9 for a little left out

										  // if all under format are true then mean will = 1;
//					if (yourData[0].defined === true ) // just the last for complete
//						{
//							pymChild.sendMessage('tracking', 'chart-interacted');
//							console.log("completed");
//						} //ends if completed


		}) // ends on drag

		svg.call(drag);


	} // ends dragNet


	function showMe(){
      if (typeof toDraw != "undefined") {
                  data_user_line = [];
                  var formatDate = d3.timeFormat("%d-%b-%Y")

                  toDraw.forEach(function(d, i){
                    data_user_line.push(formatDate(d.year)+": "+parseInt(d.debt));
                  })

                 dataLayer.push({
                    'event': 'collectedData',
                    'selected': data_user_line.toString()
                  })
      }

      // empty array to show answer when clicked without drawing
      toDraw=[];

			var fmat = d3.format(",."+dvc.essential.decimalPlaces+"f");
      var fmatcomma = d3.format(",."+dvc.essential.decimalPlaces+"f");

			d3.select('#graphic').style("pointer-events", "none");

			d3.select("#showMe").remove();

			d3.select("#chase").remove();

     		d3.select("#annotext").remove();

			d3.select("#currYValG").remove();

			clipRect.transition().duration(1000).attr('transform',"translate(0, 0)").attr('width', x(finishChart) );

			//d3.select(".btn").attr("opacity", 1);

		// last or second to last trues are good enough - think of better solution
      if (yourData[yourData.length-1].defined === true || yourData[yourData.length-2].defined === true ){  //  or  d3.mean(yourData, format('defined')) < 0.5 ie less than 50% achieved

	  //if (d3.mean(yourData, format('defined')) > 0.9 ){
       var myResult = fmat(currVal); /*}*/
			var result = fmat(data[data.length-1].debt);
			var diff = myResult - result;
console.log(Number(myResult),Number(fmat(data[data.length-1].debt)) );

        pymChild.sendMessage('tracking', 'button-clicked-after-interaction');
        dataLayer.push({
        	'event': 'buttonClicked',
        	'selected': 'button clicked after interaction'
        })

  /*Exact*/		if(Number(myResult) === Number(fmat(data[data.length-1].debt)) ){
  							d3.select("#textResponse").append("p").text(dvc.essential.feedback[0] + fmatcomma(myResult*1000) + dvc.essential.feedback[6]);
  							d3.select("#textResponse").append("p").html(dvc.essential.appendText);
        /*Too low*/		} else if (Number(myResult) <= Number(fmat(result - (dvc.essential.difference/2)))){
							d3.select("#textResponse").append("p").text(dvc.essential.feedback[2] + fmatcomma(myResult*1000) + dvc.essential.feedback[4]);
							d3.select("#textResponse").append("p").html(dvc.essential.appendText);
        /*Close*/   	} else if (Number(myResult) >= Number(fmat(result - (dvc.essential.difference/2))) && Number(myResult) <= Number(fmat(+result + (dvc.essential.difference/2)))){
						 	d3.select("#textResponse").append("p").text(dvc.essential.feedback[0] + fmatcomma(myResult*1000) + dvc.essential.feedback[1]);
							d3.select("#textResponse").append("p").html(dvc.essential.appendText);
        /*Too high*/	}else {
							d3.select("#textResponse").append("p").text(dvc.essential.feedback[2] + fmatcomma(myResult*1000) + dvc.essential.feedback[3]);
							d3.select("#textResponse").append("p").html(dvc.essential.appendText);
                 		}

      }else{
       	pymChild.sendMessage('tracking', 'button-clicked-before-interaction');
        dataLayer.push({
        	'event': 'buttonClicked',
        	'selected': 'button clicked before interaction'
        })
		  d3.select("#textResponse").select("p").text(dvc.essential.feedback[5]);
		  d3.select("#textResponse").append("p").html(dvc.essential.appendText);

      }

//console.log(dataLayer);
			//d3.select("#textResponse").select("p").text(dvc.essential.appendText);

				//use pym to calculate chart dimensions with appended text
				if (pymChild) { pymChild.sendHeight(); }

	} // ends showMe


	function clampY(a, b, c){
		return Math.max(a, Math.min(b, c))
	}

	function clampX(a, b, c){
		return formatMyTime(Math.max(a, Math.min(b, c)) )
	}


	function firstMarker(){

				var fmt2 = d3.format(",.0f");

				var drawMark = svg.append("g").attr("id", "drawMark");

					data.forEach(function(d) { //console.log(formatMyTime(d.year) === formatMyTime(cutOff));
												if(formatMyTime(d.year) === formatMyTime(cutOff)) {myY = d.debt;}
											});


					drawMark.append("circle")
							.attr("cx", x(parseMyTime(dvc.essential.dateCutOff)) )
							.attr("cy", y(myY))
							.attr("r", 8) // ration of height
							.attr("cursor", "pointer")
							.attr("fill", "#E65C00");

				pulse();

	}



  function pulse(){
              svg.append("g")
                  .attr("class", "animatedCircles")
                  .append("circle")
                  .attr("class", "marker")
                  .attr("r", 20)
                  .attr("cx", x(parseMyTime(dvc.essential.dateCutOff)) )
                  .attr("cy", y(myY) )
                  .attr("stroke-width", 1)
                  .attr("fill", "#E65C00")
                  .attr("opacity", 0)
        .style('pointer-events', 'none')
                .transition()
                  .duration(500)
                  .each(slide);
  }



	function slide() {
				  var circle = d3.select(this);

				  (function repeat() {

					circle = circle.transition()
						.duration(1000)
						.attr("r", 12)
						.attr("opacity", 0)
						.transition()
						.duration(1000)
						.attr("r", 12)
						.attr("opacity", 1)
						.on("end", repeat);
				  })();
		}


	function historicalVals(){
		// Adding Historical Max and Min

			var histMax	= svg.append("g").attr("class", "yr_mx_mn");

				 histMax.append("circle")
						.attr("cx", 0)
						.attr("cy", y(mx[1]))
						.attr("r", rad) // ration of height
						.attr("fill", "#D2376D");

				 histMax.append("text")
						.attr("x",  10)
						.attr("y", y(mx[1]) )
						.text(mx[0]);

			var histMin	= svg.append("g").attr("class", "yr_mx_mn");

				 histMin.append("circle")
						.attr("cx", 0)
						.attr("cy", y(mn[1]))
						.attr("r", rad) // ration of height
						.attr("fill", "#D2376D");

				 histMin.append("text")
						.attr("x",   10)
						.attr("y", y(mn[1]) + 10)
						.text(mn[0])
	} // ends historicalVals

	function writeAnnotation(){
							// draw annotation text based on content of var annotationArray ...
							svg.append("text")
								.attr("id","annotext"/* + i*/)
								.attr("text-anchor", dvc.essential.annotationAlign/*[i]*/)
								.attr('y',y(dvc.essential.annotationXY/*[i]*/[0][1]))
								.attr('x',x(parseMyTime(dvc.essential.annotationXY/*[i]*/[0][0])) )
								.style("font-weight", 600)
								.text(function(){ if( parseInt(d3.select('#graphic').style("width")) < threshold_sm){

																return dvc.essential.annotationChart/*[i]*/[1];
																} else
																{ return dvc.essential.annotationChart/*[i]*/[0];
																}
								})
								.attr("cursor", "default");

						//if( parseInt(d3.select('#graphic').style("width")) > threshold_sm){
							svg.append("text")
								//.attr("id","annotext"/* + i*/)
								.attr("text-anchor", dvc.essential.annotationAlign/*[i]*/)
								.attr('y',y(dvc.essential.annotationXY/*[i]*/[1][1]))
								.attr('x',x(parseMyTime(dvc.essential.annotationXY/*[i]*/[1][0])) )
								.style("font-weight", 600)
								// .text(dvc.essential.annotationChart/*[i]*/[2])
								.text(function(){ if( parseInt(d3.select('#graphic').style("width")) < threshold_sm){

																return dvc.essential.annotationChart/*[i]*/[3];
																} else
																{ return dvc.essential.annotationChart/*[i]*/[2];
																}
								})
								.attr("cursor", "default");
						//}

				return;

			}// end function writeAnnotation()
}//end of drawGraphic



		//then, onload, check to see if the web browser can handle 'inline svg'
			if (Modernizr)
			{

				// open and load configuration file.
				d3.json("config.json", function(error, json)
				{
					// strore read in json data from config file as as global dvc. variable ...
					dvc = json;
						readData();
				})

			} // end if ...
			else
			{
					 //use pym to create iframe containing fallback image (which is set as default)
					 pymChild = new pym.Child();
					if (pymChild) {
						pymChild.sendHeight();
					}
			}



	function readData(){

					graphic_data_url = dvc.essential.dataURL;
					var parseMyTime = d3.timeParse(dvc.essential.dateFormat);

					//load chart data
					d3.csv(graphic_data_url, function(error, data) {

							data.forEach(function(d) {
										if (dvc.essential.period == "quarter"){
												cond = d.year.slice(0,3);
													if(cond === "Q1") d.year = d.year.replace("Q1", "Jan");
													if(cond === "Q2") d.year = d.year.replace("Q2", "Apr");
													if(cond === "Q3") d.year = d.year.replace("Q3", "Jul");
													if(cond === "Q4") d.year = d.year.replace("Q4", "Oct");

													if(cond === "Q1") d.year = d.year.replace("Q1", "Jan");
													if(cond === "Q2") d.year = d.year.replace("Q2", "Apr");
													if(cond === "Q3") d.year = d.year.replace("Q3", "Jul");
													if(cond === "Q4") d.year = d.year.replace("Q4", "Oct");

													d.year = parseMyTime(d.year);

										}

										else if (dvc.essential.period == "month"){
											d.year = d.year.toLowerCase();
											d.year = d.year.replace(/\ [a-z]/g, function(x){return " "+x[1].toUpperCase();} );
											d.year = parseMyTime(d.year);

										} else {
												d.year = parseMyTime(d.year);
										}
									}); // end forEach

						dvc_data08 = data.filter(function(d){
						return d.year >= parseMyTime(dvc.essential.dateMxMn); })

						mx = dvc.essential.maximumCircle;
						mn = dvc.essential.minimumCircle;

						dvc_data = data.filter(function(d){
										return d.year >= parseMyTime(dvc.essential.dateStart); })

												pymChild = new pym.Child({renderCallback: drawGraphic(dvc_data)});
								})

	}// end function readData()
