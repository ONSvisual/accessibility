

var dvc = {};
var pymChild = null;

//create structure- rows and columns
function createStructure() {

    if (typeof xhr != 'undefined') {
        xhr.abort();
        //console.log("I've aborted");
    }

    //console.log("I'm firing")

    d3.selectAll(".title_div").selectAll("*").remove();
    d3.selectAll(".container-fluid").selectAll("*").remove();
    d3.selectAll(".explainer").remove();

    var nested_data = d3.nest()
        .key(function (d) { return d.topic_code; })
        .entries(dvc.config);


    dvc.topics = [];
    dvc.measures = [];
    dvc.ons_urls = [];
    dvc.data_start = [];
    dvc.period = [];
    dvc.colour = [];
    dvc.filter = [];
    dvc.change = []

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
        dvc.colour.push(d.colour);
    });

    dvc.config.forEach(function (d, i) {
        dvc.filter.push(d.filter);
    });

    dvc.config.forEach(function (d, i) {
        dvc.change.push(d.change);
    });


    topic_row = d3.select(".container-fluid")
        .selectAll("div")
        .data(nested_data)
        .enter()
        .append("div")
        .attr("class", function (d) { return "row topic " + d.key; })


    summary = topic_row.append("div")
        .attr("class", "summary")



    summary.append("div")
        .attr("class", "topic_title")
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
                .append("section")
                .attr("class", function (d) {
                    return "col-xs-12 col-sm-6 col-md-4 col-lg-4 " + d.change;
                })
                .attr("id", function (d) {
                    return d.measure_code;
                })
                .append("div")
                .attr("class", "indicatorPanel panel panel-default")
                .append("div")


        })



    d3.selectAll(".panel").append("div")
        .append("a")
        .style("text-decoration", "none")
        .style("color", "#181818")
        .attr("class", "card")

        .append("div")
        .attr("class", "measure_title row")
        .append("div")
        .attr("class", "title_div")

    d3.selectAll(".card")
        .style("border-top-color",
            function (d) {
                return d.color;
            }
        )
        .append("div")
        .attr("class", "status")
        .append("text")
        .attr("class", "latest")
        .attr("id", function (d, i) { return "change_" + i })



    d3.selectAll(".measure_title")
        .append("div")
        .attr("class", "data")
        .attr("aria-hidden", "true")
        .append("div")


    d3.selectAll(".data")
        .append("div")
        .attr("class", "indicator")
        .append("text")

        .html(function (d) {
            if (d.change == "m_up_f_nochange") {
                return '<img class = "arrow" src="images/m_up_f_nochange.svg" aria-hidden="true" alt="arrow icon" />';
            } else if (d.change == "up") {
                return '<img class = "arrow" src="images/positive.svg" aria-hidden="true" alt="arrow icon" />';
            } else if (d.change == "down") {
                return '<img class = "arrow" src="images/negative.svg" aria-hidden="true" alt="arrow icon" />';
            } else if (d.change == "no") {
                return '<img class = "arrow" src="images/nochange.svg" aria-hidden="true" alt="arrow icon" />';
            } else {
                return '<img class = "arrow" src="images/null.svg" aria-hidden="true" alt="arrow icon" />';
            }

        })

    d3.selectAll(".card")
        .append("div")
        .attr("class", "graphic")

    d3.selectAll(".card")
        .append("div")
        .attr("class", "description")

    d3.selectAll(".card")
        .append("div")
        .attr("class", "go_to")


    d3.selectAll(".card")
        .append("div")
        .attr("class", "explainer")
        .append("text")
        .attr("class", "updatedDate")
        .html(function (d) {
            return "Updated: " + d.updated;
        })


    j = 0;

    parseStartTime = d3.timeParse("%Y, %m, %d");

    loadData();


} //end of createStructure()

function loadData() {
    chartData = {};
    json = {};
    //console.log(dvc.ons_urls[j])
    if (dvc.ons_urls[j] == "none") {
        filepth = 'data/' + dvc.measures[j].toLowerCase() + ".json";
    } else if (dvc.ons_urls[j] == "bigNo") {
        filepth = 'data/' + dvc.measures[j].toLowerCase() + ".json";
    } else if (dvc.ons_urls[j] == "hbar" || dvc.ons_urls[j] == "vbar") {
        filepth = 'data/' + dvc.measures[j].toLowerCase() + ".json";
    } else {
        filepth = dvc.ons_urls[j];
    }


    xhr = d3.json(filepth)
        .on("load", function (json) {
            //console.log("I've loaded")
        })
        .get(function (error, data) {

            //console.log(data)
            ready(error, data);
        });

}//end loaddata()


function ready(error, json) {
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

        })
    } else if (dvc.ons_urls[j] == "bigNo") {

    } else if (dvc.ons_urls[j] == "hbar" || dvc.ons_urls[j] == "vbar") {

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
            //console.log(chartData)

        })


    }


    getDimensions();

    if (dvc.config[j].graphic == "line") {
        drawLineChart();
    } else if (dvc.config[j].graphic == "bigNo") {
        drawBigNo();
    } else if (dvc.config[j].graphic == "vbar") {
        drawVerticalBarChart();
    } else if (dvc.config[j].graphic == "hbar") {
        drawHorizontalBarChart();
    }

}



function getDimensions() {
    margin = { top: +dvc.config[j].margin_t, right: +dvc.config[j].margin_r, bottom: +dvc.config[j].margin_b, left: +dvc.config[j].margin_l };
    chart_width = parseInt(d3.select('.graphic').style("width")) - margin.left - margin.right;

    aspectRatio = [5, 4];

    if (chart_width < 200) {
        height = 140//Math.ceil((chart_width * aspectRatio[1]) / aspectRatio[0]) - margin.top - margin.bottom;
    } else if (chart_width < 150) {
        height = 200
    } else {
        height = 100
    }

}


function drawLineChart() {
    //console.log(d3.select(".indicatorPanel").select(".panel").select(".card").select(".measure_title"))

    d3.select('#' + dvc.measures[j]).selectAll(".panel")
        .selectAll(".card")
        .selectAll(".graphic")

    d3.select('#' + dvc.measures[j]).selectAll(".panel")
        .selectAll(".description")
        .insert("p")
        .html(dvc.config[j].text)

    d3.select('#' + dvc.measures[j])
        .select(".title_div")
        .append("h3")
        .attr("class", "measure_caption")
        .style("color", dvc.config[j].color)
        .html(dvc.config[j].measure);



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

    if (minyVal != 0) {
        y = d3.scaleLinear()
            .range([(height - 15), 0])
            .domain([minyVal, maxyVal]);
    } else {
        y = d3.scaleLinear()
            .range([height, 0])
            .domain([minyVal, maxyVal]);
    }

    var svg = d3.select('#' + dvc.measures[j]).select(".graphic").append('svg')
        .attr("width", chart_width + margin.left + margin.right)
        .attr("height", height + (margin.top + 10) + margin.bottom)
        .attr('aria-hidden', true)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + (margin.top + 10) + ")");


    xAxis = d3.axisBottom(x).ticks(d3.timeMonth.every(+(dvc.config[j].tickNo))).tickFormat(d3.timeFormat("%b %Y"))



    //	console.log(chartData)

    dates = [chartData[dvc.period[j]].catLabels[0], chartData[dvc.period[j]].catLabels[chartData[dvc.period[j]].catLabels.length - 1]]

    xAxis.tickValues(dates)


    // ticks back to Q1 if using Quarters

    xAxis.tickFormat(function (d, i) {
        if (i == 0) {
            d = dvc.config[j].start_label;
        } else {
            d = dvc.config[j].end_label;
        }

        return d;
    });


    if (minyVal != 0) {
        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + (height/* +15*/) + ")")
            .call(xAxis);
    } else {
        svg.append("g")
            .attr("class", "x axis")
            .attr("transform", "translate(0," + height + ")")
            .call(xAxis);
    }


    svg.append("g")
        .attr("class", "y axis")
        .call(d3.axisLeft(y).ticks(dvc.config[j].tickNo).tickSize(-chart_width));


    if (dvc.config[j].two_series == "no") {
        line = d3.line()
            .defined(function (d, i) { return chartData[dvc.period[j]].dataValues[i] != null; })
            .x(function (d, i) {
                return x(chartData[dvc.period[j]].catLabels[i]);
            })
            .y(function (d, i) {
                return y(chartData[dvc.period[j]].dataValues[i]);
            })
            .curve(d3.curveCardinal);

        console.log(chartData)
        if (dvc.config[j].centreline == "yes") {
            svg.append("line")
                .attr("id", "centreline")
                .attr('y1', function () {
                    if (minyVal <= 0) {
                        return y(0)
                    } else {
                        return y(minyVal) + 15
                    }
                })
                .attr('y2', function () {
                    if (minyVal <= 0) {
                        return y(0)
                    } else {
                        return y(minyVal) + 15
                    }
                })
                .attr('x1', 0)
                .attr('x2', chart_width);
        }
        //	 if(dvc.config[j].rolling == "none"){
        svg.append("path")
            .style("stroke", function (d, i) {
                return d.color
                //return "#3B7A9E"
            })
            .style("stroke-width", "2px")
            .style("fill", "none")
            .attr("d", line(chartData[dvc.period[j]].dataValues))

    } else {

        line1 = d3.line()
            .defined(function (d, i) { return chartData[dvc.period[j]].dataValues[i][0] != null; })
            .x(function (d, i) {
                return x(chartData[dvc.period[j]].catLabels[i]);
            })
            .y(function (d, i) {
                return y(chartData[dvc.period[j]].dataValues[i][0]);
            });

        line2 = d3.line()
            .defined(function (d, i) { return chartData[dvc.period[j]].dataValues[i][1] != null; })
            .x(function (d, i) {
                return x(chartData[dvc.period[j]].catLabels[i]);
            })
            .y(function (d, i) {
                return y(chartData[dvc.period[j]].dataValues[i][1]);
            });


        if (dvc.config[j].centreline == "yes") {
            svg.append("line")
                .attr("id", "centreline")
                .attr('y1', function () {
                    if (minyVal <= 0) {
                        return y(0)
                    } else {
                        return y(minyVal) + 15
                    }
                })
                .attr('y2', function () {
                    if (minyVal <= 0) {
                        return y(0)
                    } else {
                        return y(minyVal) + 15
                    }
                })
                .attr('x1', 0)
                .attr('x2', chart_width);
        }


        svg.append("path")
            .style("stroke", function (d, i) {
                return d.color
            })
            .style("stroke-width", "2px")
            .style("fill", "none")
            .attr("d", line1(chartData[dvc.period[j]].dataValues))

        svg.append("path")
            .style("stroke", function (d, i) {
                return d.color
            })
            .style("stroke-width", "2px")
            .style("stroke-dasharray", 5)
            .style("fill", "none")
            .attr("d", line2(chartData[dvc.period[j]].dataValues))

        if (chartData.code == "safedk") {
            svg.append("text")
                .attr("class", "line_label")
                .attr("x", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return x(chartData[dvc.period[j]].catLabels[last]);
                })
                .attr("y", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return y(chartData[dvc.period[j]].dataValues[last][0]) - 3;
                })
                .text(chartData.description.labels[0])

            svg.append("text")
                .attr("class", "line_label")
                .attr("x", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return x(chartData[dvc.period[j]].catLabels[last]);
                })
                .attr("y", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return y(chartData[dvc.period[j]].dataValues[last][1]) - 3;
                }).text("women")
        } else {
            svg.append("text")
                .attr("class", "line_label")
                .attr("x", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return x(chartData[dvc.period[j]].catLabels[last]);
                })
                .attr("y", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return y(chartData[dvc.period[j]].dataValues[last][0]) + 10;
                })
                .text(chartData.description.labels[0])

            svg.append("text")
                .attr("class", "line_label")
                .attr("x", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return x(chartData[dvc.period[j]].catLabels[last]);
                })
                .attr("y", function (d, i) {
                    last = chartData[dvc.period[j]].dataValues.length - 1
                    return y(chartData[dvc.period[j]].dataValues[last][1]) - 10;
                }).text("women")

        }
    }


    if (dvc.config[j].markers == "yes") {
        svg.append('g')
            .selectAll("circle")
            .data(chartData[dvc.period[j]].dataValues)
            .enter()
            .append("circle")
            .style("stroke", function (d, i) { return dvc.config[j].color; })
            .style("stroke-width", "2px")
            .style("fill", "white")
            .attr("class", "circles1")
            .attr("cx", function (d, i) {
                return x(chartData[dvc.period[j]].catLabels[i]);
            })
            .attr("cy", function (d, i) { return y(d); })
            .attr("r", function (d) { return d == null ? 0 : 3 })
    }

    svg.append("g")
        .attr("transform", "translate(-15,-10)")
        .append("text")
        .attr("class", "chartUnits")
        .html("" + chartData.description.unit)


    num_format = d3.format(",.0f")
    num_format2 = d3.format(",.1f")

    d3.select("#change_" + j)
        .append("a")
        .attr("href", dvc.config[j].link_to)
        .attr("target", "_blank")
        .attr("aria-label", "Follow link to read full report")
        .html(chartData.description.title)

    j++;

    if (j < dvc.config.length) {
        chartData = {};
        loadData();
    } else {
        if (pymChild) {
            pymChild.sendHeight();
        }
    }

} //end drawLineChart()

function drawHorizontalBarChart() {

    d3.select('#' + dvc.measures[j]).selectAll(".panel")
        .selectAll(".card")
        .selectAll(".graphic")


    d3.select('#' + dvc.measures[j])
        .select(".title_div")
        .append("h2")
        .attr("class", "measure_caption")
        .style("color", dvc.config[j].color)
        .html(dvc.config[j].measure);

    y = d3.scaleBand()
        .range([0, height])
        .padding(0.1)
        .domain(chartData[dvc.period[j]].catLabels)


    maxyVal = d3.max(chartData[dvc.period[j]].dataValues)

    x = d3.scaleLinear()
        .range([0, chart_width])
        .domain([0, maxyVal]);


    var svg = d3.select('#' + dvc.measures[j]).select(".graphic").append('svg')
        .attr("width", chart_width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");



    yAxis = d3.axisLeft(y)



    svg.append("g")
        .attr("class", "y axis")
        .attr("transform", "translate(" + 0 + ", 0)")
        .call(yAxis);


    svg.append("g")
        .attr("class", "x axis")
        .call(d3.axisTop(x).tickSize(-height));


    svg.append("g").selectAll(".bar")
        .data(chartData[dvc.period[j]].dataValues)
        .enter()
        .append("rect")
        .attr("class", "bar")
        .style("fill", function (d, i) { return dvc.config[j].color; })
        .attr("y", function (d, i) { return y(chartData[dvc.period[j]].catLabels[i]); })
        .attr("height", y.bandwidth())
        .attr("x", function (d) { return x(0); })
        .attr("width", function (d, i) { return x(d); });

    svg.append("g").append("text")
        .attr("class", "chartUnits")
        .attr("transform", "translate(100, -20)")
        .text(chartData.description.unit)

    d3.select("#change_" + j)
        .append("a")
        .attr("href", dvc.config[j].link_to)
        .attr("target", "_blank")
        .html(chartData.description.title + "<br>")

    j++;

    if (j < dvc.config.length) {
        chartData = {};
        loadData();
    } else {
        if (pymChild) {
            pymChild.sendHeight();
        }
    }
}

function drawVerticalBarChart() {
    //console.log("verticalbarchart")
    d3.select('#' + dvc.measures[j]).selectAll(".panel")
        .selectAll(".card")
        .selectAll(".graphic")


    d3.select('#' + dvc.measures[j])
        .select(".title_div")
        .append("h2")
        .attr("class", "measure_caption")
        .style("color", dvc.config[j].color)
        .html(dvc.config[j].measure);

    x = d3.scaleBand()
        .range([0, chart_width])
        .padding(0.1)
        .domain(chartData[dvc.period[j]].catLabels)


    if (dvc.config[j].ymax == "auto") {
        maxyVal = d3.max(chartData[dvc.period[j]].dataValues)
    } else {
        maxyVal = +dvc.config[j].ymax
    }


    y = d3.scaleLinear()
        .range([height, 0])
        .domain([0, maxyVal]);


    var svg = d3.select('#' + dvc.measures[j]).select(".graphic").append('svg')
        .attr("width", chart_width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
        .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


    xAxis = d3.axisBottom(x)


    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);


    svg.append("g")
        .attr("class", "y axis")
        .call(d3.axisLeft(y).tickSize(-chart_width).ticks(5));


    svg.append("g").selectAll(".bar")
        .data(chartData[dvc.period[j]].dataValues)
        .enter()
        .append("rect")
        .attr("class", "bar")
        .style("fill", function (d, i) { return dvc.config[j].color; })
        .attr("x", function (d, i) { return x(chartData[dvc.period[j]].catLabels[i]); })
        .attr("width", x.bandwidth())
        .attr("y", function (d) { return y(d); })
        .attr("height", function (d, i) { return height - y(d); });


    svg.append("g").append("text")
        .attr("class", "chartUnits")
        .attr("transform", "translate(-10, -10)")
        .text(chartData.description.unit)

    d3.select("#change_" + j)
        .append("a")
        .attr("href", dvc.config[j].link_to)
        .attr("target", "_blank")
        .html(chartData.description.title + "<br>")


    j++;

    if (j < dvc.config.length) {
        chartData = {};
        loadData();
    } else {
        if (pymChild) {
            pymChild.sendHeight();
        }
    }
} //end of drawVerticalBarChart()



//FILTERING

d3.selectAll('.measures-filter').selectAll('li')
    .select("a")
    .on('click', function () {
        d3.selectAll(".indicators-filter").selectAll("a").style("opacity", 0.9).classed("highlighted", false)
        d3.selectAll(".allIndicators").style("opacity", 1).classed("highlighted", true)
        d3.selectAll(".measures-filter").selectAll("a").style("opacity", 0.9).classed("highlighted", false)
        d3.select(this).style("opacity", 1).classed("highlighted", true)

        d3.selectAll(".topic").style("display", "none")
        filtered = d3.select(this).attr("data-filter")
        if (filtered == ".topic") {
            d3.selectAll(".measures-filter").selectAll("a").style("opacity", 1)
            d3.select(".allMeasures").classed("highlighted", true)
        }
        d3.selectAll(filtered).style("display", "block")
        d3.selectAll(".indicatorPanel").style("display", "block")


    })

d3.selectAll('.indicators-filter').selectAll('li')
    .select("a")
    .on('click', function () {

        d3.selectAll(".measures-filter").selectAll("a").style("opacity", 0.9).classed("highlighted", false)
        d3.select(".allMeasures").style("opacity", 1).classed("highlighted", true)
        d3.selectAll(".indicators-filter").selectAll("a").style("opacity", 0.9).classed("highlighted", false)
        d3.select(this).style("opacity", 1).classed("highlighted", true)

        d3.selectAll(".indicatorPanel").style("display", "none")
        filtered = d3.select(this).attr("data-filter")
        if (filtered == ".indicatorPanel") {
            d3.selectAll(".measures-filter").selectAll("a").style("opacity", 1)
            d3.select(".allIndicators").classed("highlighted", true)
        }
        d3.selectAll(filtered).style("display", "block")
        d3.selectAll(".topic").style("display", "block")

        filter = d3.select(this).attr("data-filter").replace(".", "")

        if (filter == "indicatorPanel") {
            d3.selectAll(".topic").style("display", "block")
        } else {
            d3.selectAll(".topic").style("display", "block")
            d3.selectAll(".topic").each(function (d) {
                matching_classes = 0;

                d3.select(this).select(".measures")
                    .selectAll(".indicatorPanel")
                    .each(function (d, j) {
                        if (d.change == filter) {
                            matching_classes++
                        }
                        //console.log(matching_classes, d.change, j);
                    })

                if (matching_classes == 0) {
                    d3.select(this).style("display", "none")
                }
            })
        }
    })


$(window).resize(function () {
    if ($(window).width() != window_width) {
        if (pymChild) {
            pymChild.sendHeight();
        }
        //location.reload();
    }
})


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
