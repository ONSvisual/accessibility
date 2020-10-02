var dvc = {};
var pymChild = null;
//	var dateFormat = "%Y";

//specify colours for each topic
//var wb_colours = ["#5454C9", "#AA74CC", "#AD3C39", "#D95F99", "#D1B900", "#A0B844", "#00B3AB", "#E28600", "#3584B8", "#298C45"]

//create structure- rows and columns
function createStructure() {

    //d3.selectAll(".title_div").selectAll("*").remove();
    d3.selectAll(".container-fluid").selectAll("*").remove();
    //d3.selectAll(".explainer").remove();

    var nested_data = d3.nest()
        .key(function (d) { return d.topic_code; })
        .entries(dvc.config);




    dvc.topics = [];
    dvc.measures = [];
    dvc.ons_urls = [];
    dvc.data_start = [];
    dvc.period = [];
    dvc.colour = [];
    dvc.text = [];

    nested_data.forEach(function (d, i) {
        dvc.topics.push(d.key);
    });

    dvc.config.forEach(function (d, i) {
        dvc.measures.push(d.measure_code);
    });

    dvc.config.forEach(function (d, i) {
        dvc.ons_urls.push(d.url);
    });

    dvc.config.forEach(function (d, i) {
        dvc.data_start.push(d.data_start);
    });

    dvc.config.forEach(function (d, i) {
        dvc.period.push(d.period);
    });

    dvc.config.forEach(function (d, i) {
        dvc.colour.push(d.color);
    });

    dvc.config.forEach(function (d, i) {
        dvc.text.push(d.text);
    });


    topic_row = d3.select(".container-fluid")
        .selectAll("div")
        .data(nested_data)
        .enter()
        .append("section")
        .attr("class", function (d) { return "row topic " + d.key; })

    summary = topic_row.append("header")
        .attr("class", "summary")


    var topic_div = summary.append("div")
        topic_div.attr("class", "topic_title")
        .attr('role', 'heading')
        .attr('aria-level', '2')
        .style("color", function (d) {
            return d.values[0].color
        })
        .html(function (d) { return d.values[0].topic; })

    summary.append("div")
        .attr("class", "topic_text")
        .html(function (d) { return d.values[0].topic_text; })



    topic_row.append("div")
        .attr("class", "measures")
        .each(function (d, i) {

            d3.select(this).selectAll("div")
                .data(d.values)
                .enter()
                .append("div")
                .attr("class", function (d) {
                    return "col-md-4 col-sm-6 col-xs-12 measure"
                })
                .attr("id", function (d) {
                    return d.measure_code;
                })
                .append("article")
                .attr("class", "panel panel-default")
                .append("h3")
                .attr("class", "panel-heading title_div")
                .style("background", function (d) {
                    return d.color
                })


        })
    //d3.selectAll(".panel-body").remove();

    d3.selectAll(".panel").append("div")
        .attr("class", "panel-body")
        .append("div")
        .attr("class", "measure_title")

    d3.selectAll(".panel-body")
        .append("div")
        .attr("class", "graphic")

    d3.selectAll(".panel-body")
        .append("div")
        .attr("class", "explainer")
        .append("text")
        .html(function (d) {

            return d.text;
        })


    j = 0;

    parseStartTime = d3.timeParse("%Y, %m, %d");

    loadData();

    function loadData() {


        if (dvc.ons_urls[j] == "none") {
            filepth = 'data/' + dvc.measures[j].toLowerCase() + ".json";
        } else if (dvc.ons_urls[j] == "bigNo") {

        } else {
            filepth = dvc.ons_urls[j];
        }

        d3.json(filepth, function (json) {
            chartData = json;

            if (dvc.ons_urls[j] == "none") {
                startDate = parseStartTime(dvc.config[j].data_start);


                chartData[dvc.period[j]].catLabels.forEach(function (d, i) {
                    if (dvc.period[j] == "days") {
                        parseTime = d3.timeParse("%d-%b-%Y")
                    } else if (dvc.period[j] == "months") {
                        parseTime = d3.timeParse("%Y %b")
                    } else if (dvc.period[j] == "years") {
                        parseTime = d3.timeParse("%Y")
                    } else if (dvc.period[j] == "quarters") {
                        parseTime = d3.timeParse("%Y %b")
                    }

                    date = parseTime(d);
                    chartData[dvc.period[j]].catLabels[i] = parseTime(d);
                    //if(d.combo != "null") {d.combo =parseFloat(d.combo)} else {d.combo=null};
                    //if(d.diphtheria != "null") {d.diphtheria = parseFloat(d.diphtheria)} else {d.diphtheria=null};


                })
            } else if (dvc.ons_urls[j] == "bigNo") {

            } else {

                startDate = parseStartTime(dvc.config[j].data_start);

                chartData[dvc.period[j]].catLabels = [];
                chartData[dvc.period[j]].dataValues = [];

                chartData[dvc.period[j]].forEach(function (d, i) {

                    if (dvc.period[j] == "days") {
                        parseTime = d3.timeParse("%d-%b-%Y")
                    } else if (dvc.period[j] == "months") {
                        parseTime = d3.timeParse("%Y %b")
                    } else if (dvc.period[j] == "years") {
                        parseTime = d3.timeParse("%Y")
                    } else if (dvc.period[j] == "quarters") {
                        parseTime = d3.timeParse("%Y %b")
                        d.date = d.date.replace("Q1", "JAN")
                        d.date = d.date.replace("Q2", "APR")
                        d.date = d.date.replace("Q3", "JUL")
                        d.date = d.date.replace("Q4", "OCT")
                    }

                    d.date = parseTime(d.date);



                    if (d.date >= startDate) {

                        chartData[dvc.period[j]].catLabels.push(d.date)
                        chartData[dvc.period[j]].dataValues.push(+d.value)

                    }

                })


            }


            getDimensions();

            if (dvc.config[j].graphic == "line") {
                drawLineChart();
            } else if (dvc.config[j].graphic == "bigNo") {
                drawBigNo();
            } else if (dvc.config[j].graphic == "bar") {
                drawBarChart();
            }

            j++;
            if (j < dvc.config.length) { loadData(); }


        });//end json load

    }//end loadData()
} //end of createStructure()

function getDimensions() {
    margin = {
        top: +dvc.config[j].margin_t,
        right: +dvc.config[j].margin_r,
        bottom: +dvc.config[j].margin_b,
        left: +dvc.config[j].margin_l
    };
    chart_width = parseInt(d3.select('.graphic').style("width")) - margin.left - margin.right;
    if (chart_width > 200) {
        aspectRatio = [5, 5];
    } else {
        aspectRatio = [5, 7];
    }
    height = Math.ceil((chart_width * aspectRatio[1]) / aspectRatio[0]) - margin.top - margin.bottom;
}

function drawLineChart() {
    //d3.select('#'+dvc.measures[j]).select(".title_div").select("h2").remove()
    //d3.select('#'+dvc.measures[j]).select(".measure_title").selectAll("*").remove();

    d3.select('#' + dvc.measures[j]).select(".title_div").append("span")
        .attr("class", "measure_caption")
        .text(dvc.config[j].measure);
    d3.select('#' + dvc.measures[j]).select(".measure_title")
        //.append("p")
        .append("a")
        .attr("href", function () {
            url = dvc.config[j].url
            if (url == "none") {
                return chartData.filepth
            } else {
                return url.replace("data", "")
            }
        })
        .attr("target", "_blank")
        .html(chartData.description.title)

    d3.select('#' + dvc.measures[j])
        .select(".measure_title")
        .append("text")
        .html(function () {
            if (dvc.config[j].rolling != "none") {
                return ", " + dvc.config[j].rolling
            }
        });



    console.log(new Date(chartData.description.releaseDate))
    formatDate = d3.timeFormat("%d %B %Y")


    d3.select('#' + dvc.measures[j]).select(".explainer")
        .append("text")
        .append("p")
        .attr("class", "updatedDate")
        .html("Updated: " + formatDate(new Date(chartData.description.releaseDate)))

    //		x = d3.scalePoint()
    //			.range([0,chart_width])
    //			//.domain([50,70])
    //			.domain(chartData.catLabels)

    if (dvc.config[j].ymin == "auto") {
        minyVal = d3.min(chartData[dvc.period[j]].dataValues)
    } else {
        minyVal = +dvc.config[j].ymin
    }


    if (dvc.config[j].ymax == "auto") {
        maxyVal = d3.max(chartData[dvc.period[j]].dataValues)
    } else {
        maxyVal = +dvc.config[j].ymax
    }

    x = d3.scaleTime()
        .range([0, chart_width])
        .domain(d3.extent(chartData[dvc.period[j]].catLabels, function (d) { return d; }));


    y = d3.scaleLinear()
        .range([height, 0])
        .domain([minyVal, maxyVal]);


    var svg = d3.select('#' + dvc.measures[j]).select(".graphic")
        .attr('aria-hidden', true)
        .append('svg')
            .attr("width", chart_width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
        .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");



    if (dvc.config[j].period == "years" || d3.timeYear.count(x.domain()[0], x.domain()[1]) > 2) {
        xAxis = d3.axisBottom(x).ticks(d3.timeYear.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%Y"))
    } else {
        xAxis = d3.axisBottom(x).ticks(d3.timeMonth.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%b %Y"))
    }


    if (parseInt(d3.select("svg").style("width")) > 200) {
        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);
    }
    svg.append("g")
        .attr("class", "y axis")
        .call(d3.axisLeft(y).ticks(4).tickSize(-chart_width));


    //		if( chartData.discontinuity != "no" ){
    //
    //			svg.append("g").append("path")
    //				.attr("class", "discontinuity")
    //				.attr("d", function (){
    //						return ("M"+	x(chartData.discontinuity)	+","+ 	y(0)+ "L"+	x(chartData.discontinuity)	+","+	0)
    //				})
    //
    //			svg.append("g")
    //				.attr("class","disconText")
    //				.append("text")
    //				.text(chartData.footnote)
    //				.attr("transform", "translate("+(+x(chartData.discontinuity))+","+75+")");
    //		}

    line = d3.line()
        .defined(function (d) { return d != null; })
        .x(function (d, i) {
            return x(chartData[dvc.period[j]].catLabels[i]);
        })
        .y(function (d, i) {
            return y(chartData[dvc.period[j]].dataValues[i]);
        });

    if (dvc.config[j].centreline == "yes") {
        svg.append("line")
            .attr("class", "centreline")
            .attr('y1', y(0))
            .attr('y2', y(0))
            .attr('x1', 0)
            .attr('x2', chart_width);
    }
    ;
    if (dvc.config[j].rolling == "none") {

        svg.append("path")
            .style("stroke", function (d) { return d.color; })
            .style("stroke-width", "2px")
            .style("fill", "none")
            .attr("d", line(chartData[dvc.period[j]].dataValues))

    } else if (dvc.config[j].rolling == "3 month on 3 month rolling average") {
        var parseTime = d3.timeParse("%b %d, %Y");

        new_range = [parseTime("Jan 01, 2008"), d3.extent(chartData[dvc.period[j]].catLabels)[1]]


        x = d3.scaleTime()
            .range([0, chart_width])
            .domain(new_range, function (d) { return d; });


        if (dvc.config[j].period == "years" || d3.timeYear.count(x.domain()[0], x.domain()[1]) > 2) {
            xAxis = d3.axisBottom(x).ticks(d3.timeYear.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%Y"))
        } else {
            xAxis = d3.axisBottom(x).ticks(d3.timeMonth.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%b %Y"))
        }


        d3.select("#" + dvc.config[j].measure_code).select(".x").call(xAxis)

        var movingAverageLine = d3.line()
            .defined(function (d, i) { return i >= 6; })
            .x(function (d, i) { return x(chartData[dvc.period[j]].catLabels[i]); })
            .y(function (d, i) {
                if (i >= 6) {
                    firstthree = (chartData[dvc.period[j]].dataValues[i - 3] + chartData[dvc.period[j]].dataValues[i - 4] + chartData[dvc.period[j]].dataValues[i - 5]) / 3
                    lastthree = (chartData[dvc.period[j]].dataValues[i] + chartData[dvc.period[j]].dataValues[i - 1] + chartData[dvc.period[j]].dataValues[i - 2]) / 3
                    //console.log((100*(lastthree/firstthree))-100)
                    return y((100 * (lastthree / firstthree)) - 100);

                } else {
                    return null;
                }
            })

        //.interpolate("basis");

        // Draw the moving average version of the data, as a line.

        svg.append("path")
            .style("stroke", function (d, i) {
                return d.color
            })
            .style("stroke-width", "2px")
            .style("fill", "none")
            .attr("class", "average")
            .attr("d", movingAverageLine(chartData[dvc.period[j]].dataValues));




    } else if (dvc.config[j].rolling == "month on previous year") {

        var parseTime = d3.timeParse("%b %d, %Y");

        new_range = [parseTime("Jan 01, 2008"), d3.extent(chartData[dvc.period[j]].catLabels)[1]]


        x = d3.scaleTime()
            .range([0, chart_width])
            .domain(new_range, function (d) { return d; });


        if (dvc.config[j].period == "years" || d3.timeYear.count(x.domain()[0], x.domain()[1]) > 2) {
            xAxis = d3.axisBottom(x).ticks(d3.timeYear.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%Y"))
        } else {
            xAxis = d3.axisBottom(x).ticks(d3.timeMonth.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%b %Y"))
        }


        d3.select("#" + dvc.config[j].measure_code).select(".x").call(xAxis)
        var month = 0;
        var year_ago = 0;

        var monthOnYearLine = d3.line()
            .defined(function (d, i) { return i >= 12; })
            .x(function (d, i) { return x(chartData[dvc.period[j]].catLabels[i]); })
            .y(function (d, i) {
                if (i >= 12) {
                    month = chartData[dvc.period[j]].dataValues[i]
                    year_ago = chartData[dvc.period[j]].dataValues[i - 11]
                    //  console.log(i+"  "+month+"  ___  "+year_ago+"   "+((100*(month/year_ago))-100 ))
                    return y((100 * (month / year_ago)) - 100);
                } else {
                    //  console.log(i+"  "+month+"  ___  "+year_ago)
                    return null;
                }
            })


        svg.append("path")
            .style("stroke", function (d, i) {
                return d.color
            })
            .style("stroke-width", "2px")
            .style("fill", "none")
            .attr("class", "monthonyear")
            .attr("d", monthOnYearLine(chartData[dvc.period[j]].dataValues));



    }



    //		if(chartData.data_markers == "yes"){
    //			svg.append('g')
    //				.selectAll("circle")
    //				.data(chartData.dataValues)
    //				.enter()
    //				.append("circle")
    //				.attr("class", "circles1")
    //				.attr("cx", function(d,i){ return x(chartData.catLabels[i]);})
    //				.attr("cy",function(d) { return y(d); })
    //				.attr("r",function(d){ return d ==null ? 0 : 3})
    //		}

    svg.append("g")
        .attr("transform", "translate(-20,-10)")
        .append("text")
        .attr("class", "chartUnits")
        .text(function () {
            if (dvc.config[j].rolling == "none") {
                return chartData.description.unit
            }
        })

    //use pym to calculate chart dimensions
    if (pymChild) {
        pymChild.sendHeight();
    }

} //end drawLineChart()

function drawBigNo() {

    d3.select('#' + dvc.measures[j]).select(".title_div").append("h2")
        .attr("class", "measure_caption")
        .text(dvc.config[j].measure);
    d3.select('#' + dvc.measures[j]).select(".measure_title").append("text")
        .text(chartData.description.title);


    d3.select('#' + dvc.measures[j])
        .select(".graphic").append("img")
        .attr("class", "img-responsive")
        .attr("src", function (d) {
            return dvc.config[j].svg;
        });
}

function drawBarChart() {

    d3.select('#' + dvc.measures[j]).select(".title_div").append("h2").attr("class", "measure_caption").text(dvc.config[j].measure);
    d3.select('#' + dvc.measures[j]).select(".measure_title").append("text").text(chartData.description.title);

    x = d3.scaleBand()
        .range([0, chart_width])
        .padding(0.1)
        //.domain([50,70])
        .domain(chartData[dvc.period[j]].catLabels)


    maxyVal = d3.max(chartData[dvc.period[j]].dataValues)

    y = d3.scaleLinear()
        .range([height, 0])
        .domain([0, maxyVal]);


    var svg = d3.select('#' + dvc.measures[j]).select(".graphic").append('svg')
        .attr("width", chart_width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");



    xAxis = d3.axisBottom(x).tickFormat(d3.timeFormat("%Y"))



    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);


    svg.append("g")
        .attr("class", "y axis")
        .call(d3.axisLeft(y).tickSize(-chart_width));


    svg.append("g").selectAll(".bar")
        .data(chartData[dvc.period[j]].dataValues)
        .enter()
        .append("rect")
        .attr("class", "bar")
        .attr("x", function (d, i) { return x(chartData[dvc.period[j]].catLabels[i]); })
        .attr("width", x.bandwidth())
        .attr("y", function (d) { return y(d); })
        .attr("height", function (d, i) { return height - y(d); });

    svg.append("g").append("text")
        .attr("class", "chartUnits")
        .text(chartData.description.unit)

    //use pym to calculate chart dimensions
    if (pymChild) {
        pymChild.sendHeight();
    }
}


//check to see if the web browser can handle 'inline svg'
if (Modernizr) {

    // open and load configuration file.
    d3.csv("config.csv", function (error, csv) {
        // store csv data from config file as as global dvc.config variable ...
        dvc.config = csv;
        //use pym to create iframed chart dependent on specified variables
        pymChild = new pym.Child({ renderCallback: createStructure });

    })



} // end if ... error
else {
    //use pym to create iframe containing fallback image (which is set as default)
    pymChild = new pym.Child();
    if (pymChild) { pymChild.sendHeight(); }

}// end else ...