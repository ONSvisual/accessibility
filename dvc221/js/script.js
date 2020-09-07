

			var dvc = {};

			dvc.initialYear = 1951; // initial data year in life/QX tables provided by Julie Mills
			dvc.finalYear = 2205;// final data year in life/QX tables provided by Julie Mills
			dvc.maxAgetoConsider = 125; // maximum life age to consider when extracting QX values and estimating life expectancy

			dvc.boolHasError = false; // boolean variable to denote if input age has been founf to be incorrect format.
			var regExp = /[0-9]{1,3}/; // regular expression to check current age input value against for validation

			dvc.selectedGender = ""; // initialsation of string variable to

			var $graphic = $( "#chart6" ); // initialising variable to contain reference to chart6 div in longevity.html
			var bodyElement = $('body'); // initialising variable to contain reference to body div in longevity.html
			var $picto = $("#picto" ); // initialising variable to contain reference to picto div in longevity.html
			var graphic = $('#chart'); // variable to contain reference to chart div in longevity.html

			var graphicDivWidth = $picto.width(); // initialising variable to store returned value for width of picto div
			var graphicDivHeight = $picto.height(); // initialising variable to store returned value for height of picto div
			var bodyWidth = bodyElement.width(); // // initialising variable to store returned value for width of body div

			var margin = { top : 35, bottom : 65, left : 40, right : 25 }; // initialise all four margins
			var graphic_aspect_width = 16; // initialise graphic_aspect_width
			var graphic_aspect_height = 16; // initialise graphic_aspect_width
			var mobile_threshold = 600; // initialise graphic_aspect_width


			// defining what life table data  columsis actually plotted on interactive graph
			/*
				dvc.QX_LEprobArray = []		dvc.arrayToUse = 1;	Column C, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
				dvc.LX_LEprobArray = []		dvc.arrayToUse = 2;	Column D, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
				dvc.LXL0_LEprobArray = []	dvc.arrayToUse = 3;	Column E, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
				dvc.DX_LEprobArray = []		dvc.arrayToUse = 4;	Column F, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
				dvc.EX_LEprobArray = []		dvc.arrayToUse = 5;	Column G, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
			*/
			//dvc.arrayToUseIndex = 3;


			// window resize function
			$( window ).resize(function()
			{


				// retrieve and update new height and width of picto div
				graphicDivWidth = $picto.width();
				graphicDivHeight = $picto.height();
				bodyWidth = bodyElement.width();


				// recalculate the graph width using new picto div dimensions
				var width = $picto.width() - margin.left - margin.right;


			  	// clauses to action depending on width of screen
				if ( width < 768 ) {


					// modify aspect ratio dimensions as appropriate
					var graphic_aspect_width = 16;
					var graphic_aspect_height = 16;


					//	recalculate graphic height accordingly, with new aspect ration
					var height = (Math.ceil((width * graphic_aspect_height) / graphic_aspect_width) - margin.top - margin.bottom + 40);


				}// end if ...


				else {


					// modify aspect ratio dimensions as appropriate
					var graphic_aspect_width = 16;
					var graphic_aspect_height = 16;


					//	recalculate graphic height accordingly, with new aspect ration
					var height = Math.ceil((width * graphic_aspect_height) / graphic_aspect_width) - margin.top - margin.bottom + 40;


				}// end if ...


				// errrr, dunno ...
				d3.select("#picto");


			}); // end window.resize function


			// function called when a gender button is selected
			d3.selectAll(".genderbuttons")
				.on('click', function(){

					d3.selectAll(".genderbuttons").classed("selected",false);
					d3.select(this).classed("selected",true);

					// if 'male' is selected
					if ( $(this).find('input').attr('id') == "option1" )
					{

						d3.selectAll(".genderbuttons").property("checked","false");
						d3.select("#option1").property("checked","true");

						// update global gender selection variable; modify button group CSS attribution accordingly
						dvc.selectedGender = "male";
//						d3.select("#btn-primary1").style("color" , "white" ).style("background-color" , "#274796" );
//						d3.select("#btn-primary2").style("color"  , "black" ).style("background-color" , "#e7e7e7" ).style("border-color" , "#cccccc" );

					}// end if ...


					else {


						// update global gender selection variable; modify button group CSS attribution accordingly
						dvc.selectedGender = "female";

						d3.selectAll(".form-group-icon").property("checked","false");
						d3.select("#option2").property("checked","true");
//						d3.select("#btn-primary2").style("color" , "white" ).style("background-color" , "#274796" );
//						d3.select("#btn-primary1").style("color"  , "black" ).style("background-color" , "#e7e7e7" ).style("border-color" , "#cccccc" );

					}// end else ...



					// if a correctly formatted age has been entered and a gender button selected, enable submission button
					if ( dvc.selectedGender != "" && regExp.test($("#currentAge").val()) == true ) {
						d3.select("#compareBtn").attr("class","btn-primary large");
						d3.select("#submitButton").attr("cursor","default")
					}


				}); // end gender button function


			// initisation function for onload situations
			if (Modernizr.inlinesvg)
			{


				$(document).ready(function()
				{


						//call function to load underlying QX data
						loadchartData();


						// function called when user presses "Calculate your life expectancy" button
						onSubmit();


						// modify button group CSS accordingly
//						d3.select("#btn-primary1").style("color"  , "black" ).style("background-color" , "#e7e7e7" ).style("border-color" , "#cccccc" );
//						d3.select("#btn-primary2").style("color"  , "black" ).style("background-color" , "#e7e7e7" ).style("border-color" , "#cccccc" );


						dvc.firstYear = 1951; // first year represented in QX tables
						dvc.lastYear = 2205; // last year represented in QX tables
						dvc.currentYear = 2020; // this very current years. Needs to be updated accordingly to maintain currency of interative


						// initialise and call Pym to resize view ...
						pymChild = new pym.Child();
						pymChild.sendHeight();


						//Change the currentage

						currentAgeChange();

						function currentAgeChange(){
								d3.select("#plus")
									.on("click", function(){
										currentValue = d3.select("#currentAge").node().value;
										if(currentValue<110) {
											d3.select("#currentAge").property("value",eval((currentValue*1)+1));
										}
									})

								d3.select("#minus")
									.on("click", function(){
										currentValue = d3.select("#currentAge").node().value;
										if(currentValue>0) {
											d3.select("#currentAge").property("value",eval((currentValue*1)-1));
										}
									})

						}



						/*
							NAME: 			loadchartData
							DESCRIPTION: 	called to read in daat for both males and females.
							CALLED FROM:	$(document).ready
							CALLS: 			onblurYourAge
											getValues
							REQUIRES: 		n/a
							RETURNS: 		n/a
						*/
						function loadchartData()
						{

							// read in male and female LE tables
							d3.csv("./lib/table1_male.csv", function(error, data) { dvc.data1 = data; });
							d3.csv("./lib/table1_female.csv", function(error, data) { dvc.data2 = data; });


							// read in male and female QX tables
							d3.csv("./lib/table2_male_QX.csv", function(error, data) { dvc.data3 = data; });
							d3.csv("./lib/table2_female_QX.csv", function(error, data) { dvc.data4 = data; });


						}// end function loadchartData



						/*
							NAME: 			onSubmit
							DESCRIPTION: 	actioned when user presses "Calculate your life expectancy" button
							CALLED FROM:	$(document).ready
							CALLS: 			onblurYourAge
											getValues
							REQUIRES: 		n/a
							RETURNS: 		n/a
						*/
						function onSubmit()
						{

							//d3.select("#fromnow").remove();


							$("#longevityCalculator").submit(function(event)
							{



								event.preventDefault(); //  the default action of the event will not be triggered.
								event.stopPropagation(); //Prevents the event from bubbling up the DOM tree, preventing any parent handlers from being notified of the event.


								// call function to handle input and interaction with current age text bo input
								onblurYourAge();


								// retrieve and store current age entered by user
								dvc.myCurrentAge = $("#currentAge").val();


								// call function to use age value to retrieve data from stored arrays
								getValues();

								dataLayer.push({
									'event': 'calculateLE',
									'age': dvc.myCurrentAge,
									'sex': dvc.selectedGender,
									'sex_age': dvc.selectedGender.substr(0, 1) + "_" + dvc.myCurrentAge
								})



								return;


							});// end $("#longevityCalculator").submit(function(event)


						}// end function onSubmit()



						/*
							NAME: 			getValues
							DESCRIPTION: 	function that sets up gender specific information based on user input.
							CALLED FROM:	onSubmit
							CALLS: 			calculateEXProbs
							REQUIRES: 		n/a
							RETURNS: 		n/a
						*/
						function getValues()
						{

							// display div space to display highlevel statstics on graph and graph itself
							d3.select("#quizContent").style("display" , "inline");


							// display necessary divs
							$("#LE").show();
							$("#picto").show();
							$("#pictoText").show();
							$("#introLine1").show();
							$("#introLine2").show();
							$("#introLine4").show();
							$("#introLine5").show();
							$("#introLine3a").show();
							$(".breakReturn").show();
							$("#yearsFromNow").show();
							$("#yearsFromNow2").show();


							// calculate year of birth from current age provided
							dvc.YearOfBirth = dvc.currentYear - dvc.myCurrentAge;


							// array giving proxy values for gender specific SPA values based on year of birth.
							// This is a simplification of information given in spa-timetable.pdf
							// extends back 125 years from 2015 (first year interactive was built for).
							// With each annual revision, this array will need to be extended by one year to accommodat teh new 'current year'
							var yourSPAArray = {
											"features": [
															{ "properties": { "birthYear" : "1890" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1891" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1892" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1893" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1894" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1895" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1896" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1897" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1898" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1899" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1900" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1901" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1902" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1903" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1904" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1905" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1906" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1907" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1908" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1909" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1910" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1911" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1912" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1913" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1914" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1915" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1916" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1917" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1918" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1919" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1920" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1921" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1922" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1923" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1924" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1925" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1926" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1927" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1928" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1929" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1930" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1931" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1932" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1933" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1934" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1935" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1936" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1937" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1938" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1939" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1940" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1941" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1942" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1943" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1944" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1945" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1946" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1947" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1948" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1949" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1950" , "male" : "65" , "female" : "60" } } ,
															{ "properties": { "birthYear" : "1951" , "male" : "65" , "female" : "61" } } ,
															{ "properties": { "birthYear" : "1952" , "male" : "65" , "female" : "62" } } ,
															{ "properties": { "birthYear" : "1953" , "male" : "65" , "female" : "64" } } ,
															{ "properties": { "birthYear" : "1954" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1955" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1956" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1957" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1958" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1959" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1960" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1961" , "male" : "66" , "female" : "66" } } ,
															{ "properties": { "birthYear" : "1962" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1963" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1964" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1965" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1966" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1967" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1968" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1969" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1970" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1971" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1972" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1973" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1974" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1975" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1976" , "male" : "67" , "female" : "67" } } ,
															{ "properties": { "birthYear" : "1977" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1978" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1979" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1980" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1981" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1982" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1983" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1984" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1985" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1986" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1987" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1988" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1989" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1990" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1991" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1992" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1993" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1994" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1995" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1996" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1997" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1998" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "1999" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2000" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2001" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2002" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2003" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2004" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2005" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2006" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2007" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2008" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2009" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2010" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2011" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2012" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2013" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2014" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2015" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2016" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2017" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2018" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2019" , "male" : "68" , "female" : "68" } } ,
															{ "properties": { "birthYear" : "2020" , "male" : "68" , "female" : "68" } }
											]
							};


							// set up variables and data arrays based on selected gender
							if ( dvc.selectedGender == "male" )
							{


								// extract gender specific year data
								dvc.yearData = dvc.data1.filter(function(d) { return d.year == dvc.YearOfBirth; });


								// extract gender specific QX data
								dvc.QXData = dvc.data3;


								// determine gender specific SPA based on current age provided.
								dvc.SPAtoUse = yourSPAArray.features[dvc.YearOfBirth - 1890].properties.male;


								// modify graph fill colour based on gender
								dvc.plineColor = "#121212";


							} // end if ...
							else
							{


								// extract gender specific year data
								dvc.yearData = dvc.data2.filter(function(d) { return d.year == dvc.YearOfBirth; });


								// extract gender specific QX data
								dvc.QXData = dvc.data4;


								// determine gender specific SPA based on current age provided.
								dvc.SPAtoUse = yourSPAArray.features[dvc.YearOfBirth - 1890].properties.female;


								// modify graph fill colour based on gender
								dvc.plineColor = "#121212";


							} // end else ...


							// calculate gender and current age specific Life Table probabilities ...
							calculateEXProbs();


							return;


						} // end function getValues()



						/*
							NAME: 			calculateEXProbs
							DESCRIPTION: 	function that calcuates correct LE statistics for age and gender provided by user
							CALLED FROM:	getValues
							CALLS:
							REQUIRES: 		n/a
							RETURNS: 		n/a
						*/
						function calculateEXProbs()
						{


							// initiialise arrays to contain gender specific data
							var genderSpecificQX;


							// temporary array used to store portion of original data.
							var tempArray;


							// initialise and clear all relevant arrays
							dvc.timeArray = [];
							dvc.ageArray = [];
							dvc.QX_LEprobArray = []; 	// dvc.arrayToUse = 1;
							dvc.LX_LEprobArray = []; 	// dvc.arrayToUse = 2;
							dvc.LXL0_LEprobArray = []; 	// dvc.arrayToUse = 3;
							dvc.DX_LEprobArray = []; 	// dvc.arrayToUse = 4;
							dvc.EX_LEprobArray = []; 	// dvc.arrayToUse = 5;
							dvc.EX_LEprobArray1in2 = [];
							dvc.EX_LEprobArray1in4 = [];
							dvc.EX_LEprobArray1in10 = [];


							// calculate index for birth year index for accessinfg data in relevant gender specific QX table
							dvc.birthYearIndex = dvc.YearOfBirth - dvc.initialYear;


							// for every age to consider, from current age to 125 ...
							for ( var i=dvc.myCurrentAge;  i<=dvc.maxAgetoConsider; i++ )
							{

								// set up internal increment
								j = i - dvc.myCurrentAge;


								// determine index of year to consider
								var yearIndex = parseInt(parseInt(i)+parseInt(dvc.YearOfBirth))-dvc.initialYear;


								// extract gender-specific QX value from gender-specific QX table
								var QXstr = "genderSpecificQX = dvc.QXData[" + (yearIndex) + "].Y" + i;
								eval(QXstr);


								// calculate QX for current age, i, from Life Expectancies (LE) table (COLUMN C)
								dvc.QX_LEprobArray[j] = (parseFloat(genderSpecificQX))/100000;


								// special case for first year (i.e. age = 0). LE table sets the relevant values to fixed values/default starting points.
								if ( i == dvc.myCurrentAge )
								{


									// calculate LX for current age, i, from Life Expectancies (LE) table (COLUMN D)
									dvc.LX_LEprobArray[j] = 100000;


									// calculate LX/L0 for current age, i, from Life Expectancies (LE) table (COLUMN E)
									dvc.LXL0_LEprobArray[j] = 100.00;


									// calculate DX for current age, i, from Life Expectancies (LE) table (COLUMN F)
									dvc.DX_LEprobArray[j] = dvc.QX_LEprobArray[j] * dvc.LX_LEprobArray[j];


								} // end if ...


								// calculate LX, LX/L0 and DX for every other year, i.e. i>0
								else
								{

									dvc.LX_LEprobArray[j] = (((1 - dvc.QX_LEprobArray[j-1])*dvc.LX_LEprobArray[j-1])).toFixed(0);
									dvc.LXL0_LEprobArray[j] = (( dvc.LX_LEprobArray[j] / dvc.LX_LEprobArray[0] ) * 100.00).toFixed(1);
									dvc.DX_LEprobArray[j] = (dvc.QX_LEprobArray[j] * dvc.LX_LEprobArray[j]).toFixed(0);


								} // end else ...


								// populate arrays with all years (for x-axis labels) and all ages ...
								dvc.timeArray[j] = parseInt(dvc.initialYear + yearIndex);
								dvc.ageArray[j] = parseInt(j) +parseInt(dvc.myCurrentAge);


							} // end for ...


							// for every age to consider, from current age to 125 ...
							for ( var i=dvc.myCurrentAge; i<=dvc.maxAgetoConsider; i++ )
							{

								// set up internal increment
								j = i - dvc.myCurrentAge;


								// create new temporary array of LX values ranging from current age considered to oldest age considered (remains fixed)
								tempArray = dvc.LX_LEprobArray.slice(j,(dvc.LX_LEprobArray.length));


								// sum contents of temporary array created in previous step
								var sumOfArray = ( d3.sum(tempArray) );


								// calculate EX for current age.
								dvc.EX_LEprobArray[j] = ( sumOfArray / dvc.LX_LEprobArray[j] ) - 0.5;


							} // end for ...


							// create inverted versions of all arrays after making exact replicae of each array
							// copy and invert time array ... ...
							dvc.timeArrayINVERTED = dvc.timeArray.slice();
							dvc.timeArrayINVERTED.reverse();


							// copy and invert age  array ... ...
							dvc.ageArrayINVERTED = dvc.ageArray.slice();
							dvc.ageArrayINVERTED.reverse();


							// copy and invert QX array ... ... (Column C, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
							dvc.QX_LEprobArrayINVERTED = dvc.QX_LEprobArray.slice();
							dvc.QX_LEprobArrayINVERTED.reverse();


							// copy and invert LX array ... ... (Column D, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
							dvc.LX_LEprobArrayINVERTED = dvc.LX_LEprobArray.slice();
							dvc.LX_LEprobArrayINVERTED.reverse();


							// copy and invert LXL0 array ... ... (Column E, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
							dvc.LXL0_LEprobArrayINVERTED = dvc.LXL0_LEprobArray.slice();
							dvc.LXL0_LEprobArrayINVERTED.reverse();


							// copy and invert DX array ... ... (Column F, Sheet 'UK to 125', in 'LT Templae UK2012 Cab Off.xlsm'
							dvc.DX_LEprobArrayINVERTED = dvc.DX_LEprobArray.slice();
							dvc.DX_LEprobArrayINVERTED.reverse();


							// merge age and LX/L0 arrays ..
							var Age_LXL0_DataArray = d3.zip( dvc.LXL0_LEprobArray , dvc.ageArray );
							dvc.hundredYearProb = Age_LXL0_DataArray[100-dvc.myCurrentAge];


							// store current age and personal SPA values as local INTEGER variables to allow comparison...
							var myAge = parseInt(dvc.myCurrentAge);
							var mySPAAge = parseInt(dvc.SPAtoUse);


							// check if current age is less than or equal to SPA. If it is, store the associated probablitiy of reaching SPA for plotting dot on graph
							if ( parseInt(myAge) <= parseInt(mySPAAge) ) { dvc.SPAProb = Age_LXL0_DataArray[dvc.SPAtoUse-dvc.myCurrentAge]; }


							// merge inverted age and LX arrays ..
							var Age_LX_DataArray = d3.zip( dvc.LX_LEprobArrayINVERTED , dvc.ageArrayINVERTED );


							// merge age, QX and LX arrays ..
							var Age_QX_LX_DataArray = d3.zip( dvc.ageArray , dvc.QX_LEprobArray , dvc.LX_LEprobArray );


							// set up and initialise smalla rray to store 1 in 2, 1 in 4 and 1 in 10 levels of reaching ...
							dvc.probArray = [ 50000 , 25000 , 10000 ];
							dvc.mySpecificProbArray = [];


							// global variables to allow storing and display of values to different precisions
							dvc.val1;
							dvc.val2;


							// for each value held in array dvc.probArray ...
							for ( var p=0; p<dvc.probArray.length; p++ )
							{


								// initialise sub array to store calculated values ...
								dvc.mySpecificProbArray[p] = [ [] , [] ];


						  		// for each value held in array Age_LX_DataArray ...
								for ( var i=0; i<Age_LX_DataArray.length; i++ )
								{


									// check to see if LX value for current age value is less than relevant fixed value in array dvc.probArray
									if ( parseInt(Age_LX_DataArray[i][0]) < dvc.probArray[p] )
									{


										// if so, calculate components of the life tables vlook-up calculations
										dvc.val1 = parseInt(Age_LX_DataArray[i][1]);
										dvc.val8 = Age_LX_DataArray[i][1]-1;


									}// end if ...
									else
									{


										continue;


									}// end else ...


								} // end for ...


								// for each value in array Age_QX_LX_DataArray ....
								for ( var i=0; i<Age_QX_LX_DataArray.length; i++ )
								{


									// if so, calculate components of the life tables vlook-up calculations
									if ( parseInt(Age_QX_LX_DataArray[i][0]) < dvc.val1 ) { dvc.val2 =  Age_QX_LX_DataArray[i][2]; }
									else if ( parseInt(Age_QX_LX_DataArray[i][0]) == dvc.val1 ) { dvc.val7 =  Age_QX_LX_DataArray[i][2]; }
									else { continue; }


								}// end for ...


								// calculate various components of probability level vlook-ups LE estimate
								dvc.val3 = dvc.val2 - dvc.probArray[p];
								dvc.val4 = dvc.val1;
								dvc.val5 = dvc.val2;
								dvc.val6 = dvc.val1;


								// final calculation ... calculate full final value for 'One in X' LE
								dvc.val9 = ( dvc.val3 / (dvc.val5 - dvc.val7) ) + dvc.val8;


								// store final calculation value and adjusted for current age value in 2-D array
								dvc.mySpecificProbArray[p][0] = dvc.val9;
								dvc.mySpecificProbArray[p][1] = (parseFloat(dvc.myCurrentAge) + parseFloat(dvc.val9));


							} // end for loop 'p' ...


							// determine LE at current age
							dvc.LE = parseFloat( parseFloat(dvc.EX_LEprobArray[0]) + parseFloat(dvc.myCurrentAge) ).toFixed(0);	/* change this to ... .toFixed(0); for QA */


							// calculate 'years past sex-specific SPA) ...
							// NOT USED IN FINAL INTERACTIVE
							dvc.YrsPastSPA = (parseFloat(dvc.LE) - parseFloat(dvc.SPAtoUse));


							// calculate 1 in 2 (50 prob) of reaching age X ...
							// NOT USED IN FINAL INTERACTIVE
							dvc.pc50 = parseFloat(dvc.mySpecificProbArray[0][0]).toFixed(2);
							dvc.pc50YrsPastSPA = (parseFloat(dvc.pc50) - parseFloat(dvc.SPAtoUse)).toFixed(2);


							// calculate 1 in 4 (25% prob) of reaching age X ...
							// USED IN INTERACTIVE
							dvc.pc25 = parseFloat(dvc.mySpecificProbArray[1][0]).toFixed(2);
							dvc.pc25YrsPastSPA = (parseFloat(dvc.pc25) - parseFloat(dvc.SPAtoUse)).toFixed(2);


							// calculate 1 in 10 (10% prob) of reaching age X ...
							// USED IN INTERACTIVE
							dvc.pc10 = parseFloat(dvc.mySpecificProbArray[2][0]).toFixed(2);
							dvc.pc10YrsPastSPA = (parseFloat(dvc.pc10) - parseFloat(dvc.SPAtoUse)).toFixed(2);


							// calculate how many years LE is from current age..
							// USED IN INTERACTIVE
							dvc.yearsFromNow = Math.round(dvc.LE - dvc.myCurrentAge);


							// store as global variables to 0dp the 1 in 4 and 1 in 10 probabilities
							dvc.var1 = parseFloat(dvc.mySpecificProbArray[1][0]).toFixed(0);						/* change this to ... .toFixed(0); for QA */
							dvc.var2 = parseFloat(dvc.mySpecificProbArray[2][0]).toFixed(0);						/* change this to ... .toFixed(0); for QA */


							// update HTML components on graph
							d3.select("#LE").html( dvc.LE + " years");
							//d3.select("#yearsFromNow").html( "This is <span id='YFN'>" +  + "</span> years from now" ).style("color" , "#007298");

							//d3.select("#fromnow").remove();

							//d3.select("#LEDiv").append('p').attr("id","fromnow").style("padding-bottom","10px").html("<span id='peryear'>(that's </span><span id='peryear' style='font-weight:bold'>" + dvc.yearsFromNow + "</span><span id='peryear'> years from now)</span>")

							// store as local INTEGER variables your current age and your SPA values
							var myAge = parseInt(dvc.myCurrentAge);
							var mySPAAge = parseInt(dvc.SPAtoUse);


							// logical check to action if current age is less or equal to SPA
							if ( parseInt(myAge) <= 100 )
							{


								// show panel amd value displaying chance of reaching 100 years
/*
								d3.select("#actualDiv").attr("class" , "labels col-sm-4p col-xs-12p show");
								d3.select("#actualDiv2").attr("class" , "labels col-sm-4p col-xs-12p show");
								d3.select("#natDiv").attr("class" , "labels col-sm-4p col-xs-12p show");
								d3.select("#natDiv2").attr("class" , "labels col-sm-4p col-xs-12p show");
								d3.select("#guessDiv").attr("class" , "labels col-sm-4p col-xs-12p show");
								d3.select("#guessDiv2").attr("class" , "labels col-sm-4p col-xs-12p show");
*/
								d3.select("#actualDiv").attr("class" , "labels col-sm-4 col-xs-6 show");
								d3.select("#actualDiv2").attr("class" , "labels col-sm-4 col-xs-4 show");
								d3.select("#natDiv").attr("class" , "labels col-sm-4 col-xs-6 show");
								d3.select("#natDiv2").attr("class" , "labels col-sm-4 col-xs-4 show");
								d3.select("#guessDiv").attr("class" , "labels col-sm-4 col-xs-6 hidden-xs");
								d3.select("#guessDiv2").attr("class" , "labels col-sm-4 col-xs-4 hidden-xs");
								d3.select("#pictoGuessValue").html(dvc.hundredYearProb[0] + "% chance");


							}// end if ...
							else {


								// modify bootstrap panel sizing accordingly if current age is > SPA
								d3.select("#actualDiv").attr("class" , "labels col-sm-6p col-xs-12p");
								d3.select("#actualDiv2").attr("class" , "labels col-sm-6p col-xs-12p");
								d3.select("#natDiv").attr("class" , "labels col-sm-6p col-xs-12p");
								d3.select("#natDiv2").attr("class" , "labels col-sm-6p col-xs-12p");
								d3.select("#guessDiv").attr("class" , "labels col-sm-4p col-xs-12p hide");
								d3.select("#guessDiv2").attr("class" , "labels col-sm-4p col-xs-12p hide");


							}// end else ...


							// display bootstrap components for 1 in 4 and 1 in 10 chances probabilities
							d3.select("#pictoActualValue").html(dvc.var1 + "<span class='spanClass'> years</span>");
							d3.select("#pictoNatValue").html(dvc.var2 + "<span class='spanClass'> years</span>");


							// update graph sizing accordingly to resizing
							pymChild = new pym.Child({ renderCallback: makeChart });
							pymChild.sendHeight();


							return;


						}// end function calculateEXProbs(array)


					})// END MODERNZR


				}  // end if ...


				else  // from modernizer
				{


					// update graph sizing accordingly to resizing
					pymChild = new pym.Child();
					if (pymChild) { pymChild.sendHeight(); }
					$("#ieMsg").fadeIn(1000);


				} // end else ...



				/*
					NAME: 			makeChart
					DESCRIPTION: 	function to draw graph based on values calculated in function calculateEXProbs
					CALLED FROM:	calculateEXProbs
					CALLS:
					REQUIRES: 		n/a
					RETURNS: 		n/a
				*/
				function makeChart()
				{


					// clear graph congtainer divs
					graphic.empty();
				    $picto.empty();


					// display bottom most row containing alternate tweet and fb buttons for use on Visual.ONS
					d3.select("#tweetSub").attr("class","col-sm-12 col-xs-12 show");


					// determine new width after resizing
					var width = $picto.width() - margin.left - margin.right;


					//	logical check to action depending on screen size. Set to align with bootstrap break point.
					// modify aspect ratio and graph height accordingly
					if ( width + margin.left + margin.right < 768 )
					{

						var graphic_aspect_width = 16;
						var graphic_aspect_height = 16;
						var height = 160/*(Math.ceil((width * graphic_aspect_height) / graphic_aspect_width) - margin.top - margin.bottom + 40)*/;


					}// end if ...
					else {


						var graphic_aspect_width = 16;
						var graphic_aspect_height = 9;
						var height = Math.ceil((width * graphic_aspect_height) / graphic_aspect_width) - margin.top - margin.bottom + 40;

					}// end else ...


					//initialise number of x-axis ticks displayed. modofiy if in mobile size.
					var num_ticks = 10;
					if (width < mobile_threshold ) { num_ticks = 5; }


					// initial x-axis range variable ...
					var x = d3.scale.linear().range([0, width]);


					// initial y-axis range variable ...
					var y = d3.scale.linear().range([height, 0]);


					// initial x-axis scale, orientationand tick formatting
					var xAxis = d3.svg.axis()
						.scale(x)
						.orient("bottom")
						.tickFormat(d3.format(",.0f"))
						.tickPadding(10)
						.ticks(num_ticks);


					// initial y-axis scale, orientationand tick formatting
					var yAxis = d3.svg.axis()
						.scale(y)
						.orient("left")
						.ticks(num_ticks)
						.tickPadding(10)
						.tickValues([25, 50, 75 ,100])
						.tickSize(-width);


					// set up line object
					var line = d3.svg.line()
						.x(function(d) { return x(d.date); })
						.y(function(d) { return y(d.close); });


					// set up svg object to attach to picto div
					var svgDocP = d3.select("#picto").append("svg").attr("id","svgpicto")
						.attr("width", width + margin.left + margin.right)
						.attr("height", height + margin.top + margin.bottom)
						.style("background-color","#fff")
					  .append("g")
						.attr("transform", "translate(" + margin.left + "," + margin.top + ")");


					// define clipping area boundaing box for graph
					svgDocP.append("defs")
						.append("clipPath")
						.attr("id", "clip")
						.append("rect")
						.attr("width", width)
						.attr("height", height);


					// join data from age array and LXL0 array into local temporary array to plot curve.
					var arrData = d3.zip( dvc.ageArray , dvc.LXL0_LEprobArray );


					// check to ensure no values are attemmpted to be plotted with NaN values
					arrData.forEach(function(d,i) { if( isNaN(arrData[i][1]) == true ) { arrData[i][1] = 0.0; } });


					// create a new array that follows the format
					var data = arrData.map(function(d) {


						return {
						  date: d[0],
						  close: d[1]
						};


					});	// end data array creation function


					// update axis domains according to current age. Fixed upper limits to eacha xis.
					y.domain( [ 0 ,  100 ] );
					x.domain( [ dvc.myCurrentAge ,125 ] );


					// append x axis and title to svg panel
					svgDocP.append("g")
						.attr("class", "x axis")
						.attr("id", "xAxis")
						.attr("transform", "translate(0," + height + ")")
						.call(xAxis)
					.append("text")
						.attr("class" , "graphText")
						.attr("is" , "xAxisTitle")
						.attr("transform", "rotate(0)")
						.attr("transform", "translate(" + (width - 0) + ", 30)")
						.attr("y", 6)
						.attr("dy", ".71em")
						.style("text-anchor", "end")
						.attr("id" , "xAxisTitle")
						.text("Age");


					// append y axis and title to svg panel
					svgDocP.append("g")
						.attr("class", "y axis")
						.attr("id", "yAxis")
						.call(yAxis)
					  .append("text")
						.attr("class" , "graphText")
						.attr("id" , "yAxisTitle")
						.attr("transform", "rotate(0)")
						.attr("transform", "translate(-30, -30)")
						.attr("y", 0)
						.attr("dy", ".71em")
						.style("text-anchor", "start")
						.text("Chance of reaching age (%)");


					// define and attach y-axis horizontal grid lines
					var yticks = svgDocP.selectAll('#yAxis').selectAll('.tick');
					yticks.append('svg:line')
						.attr( 'class' , "tick" )
						.attr( 'y0' , 0 )
						.attr( 'y1' , 0 )
						.attr( 'x1' , -5 )
						.attr( 'x2',  width/2 );


					// define area object for area under the probability curve
					var area = d3.svg.area()
						.x(function(d) { return x(d.date); })
						.y0(height)
						.y1(function(d) { return y(d.close); });


					// attach area under graph
					svgDocP.append("path")
						.datum(data)
						.attr("class", "area")
						.style("fill" , dvc.plineColor)
						.style("opacity" , 0.1)
						.attr("d", area);


					// gender-specific probability line ...
					svgDocP.append("path")
						.datum(data)
						.attr("stroke" , dvc.plineColor)
						.attr("class", "line")
						.attr("id", "probabilityLine")
						//.attr("clip-path", "url(#clip)")
						.attr("d", line);


					// attach outer circle for 1 in 4 prob of reaching age ... .
					svgDocP.append("circle")
						.attr("id", "circle25pc")
						.attr("class", "circlesBtns")
						.attr("cx" , x(dvc.pc25) )
						.attr("cy" , y(25) )
						.attr("r" , 12 )
						.style("fill",  "white" )
						.style("fill-opacity" , 0.0)
						.style("stroke",  "#008080" )
						.style("stroke-width", "2px" )
						.style("display",  "none" )
						.style("stroke-dasharray", "5,5");


					// attach inner circle for 1 in 4 prob of reaching age ... .
					svgDocP.append("circle")
						.attr("id", "innerCircle25pc")
						.attr("class", "circlesBtns")
						.attr("cx" , x(dvc.pc25) )
						.attr("cy" , y(25) )
						.attr("r" , 7 )
						.style("fill",  "#159191" )
						.style("stroke",  "#159191" )
						.style("stroke-width", "4px" );


					// attach 1 in 4 prob of reaching age text... .
					svgDocP.append("text")
						.attr("id", "OneInFourLabel")
						.attr("x" , x(dvc.pc25)+7 )
						.attr("y" , y(25)-7 )
						.style("fill",  "#159191" )
						.style("stroke",  "#159191" )
						.style("stroke-width", "0px" )
						.style("font-weight","bold")
						.text(dvc.var1 + " years");


					// attach outer circle for 1 in 10 prob of reaching age ... .
					svgDocP.append("circle")
						.attr("id", "circle10pc")
						.attr("class", "circlesBtns")
						.attr("cx" , x(dvc.pc10) )
						.attr("cy" , y(10) )
						.attr("r" , 12 )
						.style("fill",  "#095674" )
						.style("fill-opacity" , 0.0)
						.style("stroke",  "#095674" )
						.style("display",  "none" )
						.style("stroke-width", "2px" )
						.style("stroke-dasharray", "5,5");


					// attach inner circle for 1 in 10 prob of reaching age ... .
					svgDocP.append("circle")
						.attr("id", "innerCircle10pc")
						.attr("class", "circlesBtns")
						.attr("cx" , x(dvc.pc10) )
						.attr("cy" , y(10) )
						.attr("r" , 7 )
						.style("fill",  "#095674" )
						.style("stroke",  "#095674" )
						.style("stroke-width", "4px" );


					// attach 1 in 10 prob of reaching age text... .
					svgDocP.append("text")
						.attr("id", "OneInTenLabel")
						.attr("x" , x(dvc.pc10)+7 )
						.attr("y" , y(10)-7 )
						.style("fill",  "#095674")
						.style("stroke",  "#095674")
						.style("stroke-width", "0px")
						.style("font-weight","bold")
						.text(dvc.var2 + " years");


					// store INTEGER values of current age and PSA as loval variables
					var myAge = parseInt(dvc.myCurrentAge);
					var mySPAAge = parseInt(dvc.SPAtoUse);


					// logical check for if current age is less than or equal to SPA. If so , draw asociated dot and text
					if ( parseInt(myAge) <= parseInt(mySPAAge) )
					{


						// draw outer circles for SPA prob ...
						svgDocP.append("circle")
							.attr("id", "circleSPA")
							.attr("class", "circlesBtns")
							.attr("cx" , x(dvc.SPAtoUse) )
							.attr("cy" , y(dvc.SPAProb[0]) )
							.attr("r" , 12 )
							.style("fill",  "white" )
							.style("fill-opacity" , 0.0)
							.style("stroke",  "rgb(5, 48, 73)" )
							.style("display",  "none" )
							.style("stroke-width", "2px" )
							.style("stroke-dasharray", "5,5");


						// draw inner circles for SPA prob ...
						svgDocP.append("circle")
							.attr("id", "innercircleSPA")
							.attr("class", "circlesBtns")
							.attr("cx" , x(dvc.SPAtoUse) )
							.attr("cy" , y(dvc.SPAProb[0]) )
							.attr("r" , 7 )
							.style("fill",  "rgb(255,255, 255)" )
							.style("stroke",  "rgb(0, 0, 0)" )
							.style("stroke-width", "4px" );


						// attach SPA prob of reaching age text... .
//						svgDocP.append("text")
//							.attr("class","graphSubText legendHide")
//							.attr("id", "idYourSPA" )
//							.attr("x" , x(dvc.SPAtoUse)-10 )
//							.attr("y" , y(dvc.SPAProb[0])+10 )
//							.style( "text-anchor" , "end" )
//							.text("State pension age");
//

						svgDocP.append('text').attr("class","graphSubText1 legendHide")
							.attr("id", "idYourSPA" )
							.attr("x" , x(dvc.SPAtoUse) )
							.attr("y" , y(dvc.SPAProb[0]) + 33)
							.style( "text-anchor" , "middle" )
							.tspans([dvc.SPAtoUse + " years",'State pension', 'age'], 20);

						d3.select("#idYourSPA").selectAll("tspan").attr("x",x(dvc.SPAtoUse)).attr("font-weight",function(d,i){if(i<1){
							return 700;
						} else {return 400}
					})

					}// end if ...


					// Draw y=0 centreline
					svgDocP.append("line")
						.attr("id","centreline")
						.attr('y1',y(0))
						.attr('y2',y(0))
						.attr('x1',-5)
						.attr('x2',width);


//					// attach Your Age Now" label below x-axis
//					svgDocP.append("text")
//						.attr("class","graphSubText1 legendHide")
//						.attr("id", "idYourAge" )
//						.attr("x" , x(dvc.myCurrentAge) )
//						.attr("y" , height+50 )
//						.style( "text-anchor" , "start" )
//						.text("Your age");
//
//
//					// draw vertical "Your Age Now" line ...
//					svgDocP.append("line")
//						.attr("class","vertLines")
//						.attr("id","myAgeLine")
//						.attr('y1', height+35 )
//						.attr('y2', height )
//						.style("display" , "inline")
//						.attr('x1', x(dvc.myCurrentAge) )
//						.attr('x2', x(dvc.myCurrentAge) )
//						.style("pointer-events" , "none");

					if(bodyWidth <= 400) {
					// draw vertical LE line ...
					svgDocP.append("line")
						.attr("class","vertLines")
						.attr("id","LELine")
						.attr('y1', y(0) )
						.attr('y2', y(100))
						.attr('x1', x(dvc.LE) )
						.attr('x2', x(dvc.LE) )
						.style("pointer-events" , "none");
					} else {

					svgDocP.append("line")
						.attr("class","vertLines")
						.attr("id","LELine")
						.attr('y1', y(0) )
						.attr('y2', y(100))
						.attr('x1', x(dvc.LE) )
						.attr('x2', x(dvc.LE) )
						.style("pointer-events" , "none");
					}


					// draw LE text ...
//					svgDocP.append("text")
//						.attr("class","graphSubText legendHide")
//						.attr("id", "idYourLE" )
//						.attr("x" , x(dvc.LE) )
//						.attr("y" , -5 )
//						.style( "text-anchor" , "middle" )
//						.html("Your life expectancy");

					svgDocP.append('text').attr("class","graphSubText legendHide")
						.attr("id", "idYourLE" )
						.attr("x" , (x(dvc.LE) + 7) )
						.attr("y" , 15 )
						.style( "text-anchor" , "left" )
						.attr("fill", "#236092")
						.tspans([dvc.LE + " years",'Your life', 'expectancy'], 20);

					d3.select("#idYourLE").selectAll("tspan").attr("x",x(dvc.LE)+ 7).attr("font-weight",function(d,i){if(i<1){
						return 700;
					} else {return 400}
				})


					//redraw/resize graph space
					pymChild.sendHeight();


					return;


				} // end function makeChart()



				/*
					NAME: 			onblurYourAge
					DESCRIPTION: 	function to draw graph based on values calculated in function calculateEXProbs
					CALLED FROM:	interacting with current age text box in longevity.html
					CALLS:
					REQUIRES: 		n/a
					RETURNS: 		n/a
				*/
				function onblurYourAge()
				{


					// set up regular expressions to check  input against.
					var regExp = /[0-9]{1,3}/;
					var regExp2 = /[ ]+/;


					// store as local variable value entered into currentAge text field
					var valueToCheck = document.getElementById("currentAge").value;


					// update boolean variable to false prior to checking text field input
					dvc.boolHasError = false;
					// d3.select("#byear").attr("class","form-group");


					// if text field input is valid ...
					if ( ( regExp.test(valueToCheck) == true && valueToCheck.length < 4 && valueToCheck >= 0 ) || valueToCheck == '' )
					{


						// activate submission button, and gender buttons
						// d3.select("#compareBtn").attr("class","btn-primary large");
						d3.select("#submitButton").attr("cursor","default");
				//		d3.select( "#btn-primary1" ).attr( "class" , "btn btn-default" );
				//		d3.select( "#btn-primary2" ).attr( "class" , "btn btn-default" );

//						d3.select("#compareBtn").attr("class","btn btn-default active");
//						d3.select( "#btn-primary1" ).attr( "class" , "btn btn-default active" );
//						d3.select( "#btn-primary2" ).attr( "class" , "btn btn-default active" );


					} // end if ...


					// else error ...
					else
					{


						// de-activate submission button, and gender buttons
						// d3.select("#byear").attr("class","form-group has-error");
						dvc.boolHasError = true;
				//		d3.select( "#btn-primary1" ).attr( "class" , "btn btn-default disabled" );
				//		d3.select( "#btn-primary2" ).attr( "class" , "btn btn-default disabled" );


					} // end else ...


					return;


				}// end function onblurBirthYear()
