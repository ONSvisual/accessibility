var pymChild = new pym.Child;
var graphic_2 = d3.select('#chart2')
var graphic_1 = d3.select('#chart1');
var keypoints = d3.select('#keypoints');
var footer = d3.select(".footer");
var keywidth;
var clickedlink;
var ParentURL;

// hide the results page
d3.select('#results').style('display', 'none')

function init() {
  // click to get postcode and submit to api call
  $("#submitPost").click(function(event) {

    event.preventDefault();
    event.stopPropagation();

    myValue = $("#pcText").val();

    getCodes(myValue);
  });

  function drawGraphic(code, name) {




    // show the results page
    d3.select('#results').style('display', 'block')

    var ukSeries1 = 0.58;

    var yourSeries1 = data1.filter(function(d) {
      return d['Area code'] === code;
    });

    var ukFinal = 0.58;
    var yourFinal1 = +yourSeries1[0][2019];

    if (yourFinal1 >= ukFinal) {
      d3.select('#bar1').style('width', '100%')
      var otherBar = ukFinal / yourFinal1 * 100;
      d3.select("#bar2").style('width', otherBar + '%')
    } else {
      d3.select('#bar2').style('width', '100%')
      var otherBar = yourFinal1 / ukFinal * 100;
      d3.select("#bar1").style('width', otherBar + '%')
    }

    var difference1 = Math.abs(+ukFinal - (+yourFinal1));

    if (difference1 <= 0.01) {
      document.getElementById('sentence-difference').style.display = 'none';
      document.getElementById('sentence-around').style.display = 'inline';
    } else if (difference1 > 0.01) {
      if (ukFinal < yourFinal1) {
        document.getElementById('sentence-around').style.display = 'none';
        document.getElementById('sentence-difference').style.display = 'inline';
        var highLow = "higher";
      } else if (ukFinal > yourFinal1) {
        document.getElementById('sentence-around').style.display = 'none';
        document.getElementById('sentence-difference').style.display = 'inline';
        var highLow = "lower";
      };
    };

    // First line chart
    var yourSeries2 = data2.filter(function(d) {
      return d['Area code'] === code;
    });

    var yourFirst2 = +yourSeries2[0][2001];
    var yourFinal2 = +yourSeries2[0][2019];

    var difference2 = Math.abs(+yourFirst2 - (+yourFinal2));

    var numberFormat = d3.format(",.1f");
    var numberFormat2 = d3.format(",.0f");

    if (difference2===0) {
      document.getElementById('pub-normal').style.display = 'none';
      document.getElementById('pub-same').style.display = 'inline';
    } else {
      if (yourFirst2 < yourFinal2) {
        document.getElementById('pub-normal').style.display = 'inline';
        document.getElementById('pub-same').style.display = 'none';
        var highLow2 = "more";
      } else if (yourFirst2 > yourFinal2) {
        document.getElementById('pub-normal').style.display = 'inline';
        document.getElementById('pub-same').style.display = 'none';
        var highLow2 = "fewer";
      };
    }

    // Second line chart
    var yourSeries3 = data3.filter(function(d) {
      return d['Area code'] === code;
    });

    var numJobs2019 = +yourSeries3[0][2019];
    var numJobs2001 = +yourSeries3[0][2001];

    if (numJobs2001 === numJobs2019) {
      document.getElementById('job-normal').style.display = 'none';
      document.getElementById('job-same').style.display = 'inline';
    } else if (numJobs2001 < numJobs2019) {
      document.getElementById('job-normal').style.display = 'inline';
      document.getElementById('job-same').style.display = 'none';
      var highLow3 = "higher";
      var percentJob = Math.abs(numJobs2019 - numJobs2001) / numJobs2001 * 100;
    } else if (+yourFirst2 > +yourFinal2) {
      document.getElementById('job-normal').style.display = 'inline';
      document.getElementById('job-same').style.display = 'none';
      var highLow3 = "lower";
      var percentJob = Math.abs(numJobs2019 - numJobs2001) / numJobs2001 * 100;
    };

    // fill the first paragraph with text
    document.getElementById('pubs-person').innerHTML = numberFormat(yourFinal1 * 10);
    document.getElementsByClassName('area-name')[0].innerHTML = name;
    document.getElementById('difference-average').innerHTML = ukFinal * 10;
    document.getElementById('higher-lower').innerHTML = highLow;

    // fill the second paragraph with text
    document.getElementById('num-pubs').innerHTML = numberFormat2(difference2);
    document.getElementById('more-less').innerHTML = highLow2;
    document.getElementsByClassName('area-name')[1].innerHTML = name;
    document.getElementsByClassName('area-name')[2].innerHTML = name;

    // fill the third paragraph with text
    document.getElementsByClassName('area-name')[3].innerHTML = name;
    document.getElementsByClassName('area-name')[4].innerHTML = name;
    document.getElementById('num-jobs').innerHTML = numberFormat2(numJobs2019);
    document.getElementById('change-jobs').innerHTML = numberFormat(percentJob) + '%';
    document.getElementById('hilo-jobs').innerHTML = highLow3;

    // update tweet text
    if (difference2===0) {
      // change text for twitter
      var tweet = d3.select('#pub-same').nodes().map(function(d) { return d.outerText });
      d3.select("#twitterShare").attr("href","https://twitter.com/intent/tweet?text=" + tweet + " Look at pubs in your area with this interactive tool. " + ParentURL)

    } else {
      var tweet = d3.select('#pub-normal').nodes().map(function(d) { return d.outerText });
      d3.select("#twitterShare").attr("href","https://twitter.com/intent/tweet?text=" + tweet + " Look at pubs in your area with this interactive tool. " + ParentURL)
    }

    // chart1
    var graphicData1 = [];

    // for(i = 0; i < yourSeries1.length; i++){
    yourSeries2.forEach(function(d) {
      for (var key in d) {
        var obj = {};
        if (key !== "Area name" && key !== "Area code") {
          obj.year = key;
          obj.yourarea = yourSeries2[0][key]
          graphicData1.push(obj)
        }
      }
    });

    graphicData1.forEach(function(d) {
      d.year = d3.timeParse('%Y')(d.year);
    });

    var width = document.getElementById('chart1').clientWidth;

    var line1;
    var line1;
    var firstDot1;
    var lastDot1;
    var dot1First;
    var dot1FirstText;
    var dot2First;
    var dot2FirstText;
    var firstDot2;
    var lastDot2;
    var dot1Second;
    var dot1SecondText;
    var dot2Second;
    var dot2SecondText;
    var firstRect1;
    var firstRect2;
    var secondRect1;
    var secondRect2;

    var margin_1 = {
      top: 20,
      right: 85,
      bottom: 20,
      left: 85
    };

    var chart_width_1 = parseInt(width) - margin_1.left - margin_1.right;
    var height_1 = 50;

    var x_1 = d3.scaleTime()
      .range([0, chart_width_1]);

    var y_1 = d3.scaleLinear()
      .range([height_1, 0]);

    x_1.domain(d3.extent(graphicData1, function(d) {
      return d.year;
    }));

    var xAxis_1 = d3.axisBottom(x_1)
      .ticks(0)

    var yAxis_1 = d3.axisLeft(y_1)
      .ticks(0);

    var line_1 = d3.line()
      .curve(d3.curveLinear)
      .x(function(d) {
        return x_1(d.date);
      })
      .y(function(d) {
        return y_1(d.amt);
      });

    // parse data into columns
    var lines_1 = {};
    for (var column in graphicData1[0]) {
      if (column === 'year' || column === 'area' || column === 'area_code') continue;
      lines_1[column] = graphicData1.map(function(d) {
        return {
          'date': d.year,
          'amt': +d[column]
        };
      });
    }

    var lineMax = d3.max(lines_1.yourarea, function(d) {
      return d.amt
    });
    var lineMin = d3.min(lines_1.yourarea, function(d) {
      return d.amt
    })

    var yDomain_1 = [lineMin - 5, lineMax + 5];

    y_1.domain(yDomain_1);

    var graphicData2 = [];

    yourSeries3.forEach(function(d) {
      for (var key in d) {
        var obj = {};
        if (key !== "Area name" && key !== "Area code") {
          obj.year = key;
          obj.value = +d[key];
          obj.area = d['Area name'];
          obj.area_code = d['Area code'];
          graphicData2.push(obj)
        }
      }
    });

    graphicData2.forEach(function(d) {
      d.year = d3.timeParse('%Y')(d.year);

    });

    var x_2 = d3.scaleTime()
      .range([0, chart_width_1]);

    var y_2 = d3.scaleLinear()
      .range([height_1, 0]);

    x_2.domain(d3.extent(graphicData2, function(d) {
      return d.year;
    }));

    var xAxis_2 = d3.axisBottom(x_2)
      .ticks(0);

    var yAxis_2 = d3.axisLeft(y_2)
      .ticks(0);
    var line_2 = d3.line()
      .curve(d3.curveLinear)
      .x(function(d) {
        return x_2(d.date);
      })
      .y(function(d) {
        return y_2(d.amt);
      });

    // parse data into columns
    var lines_2 = {};
    for (var column in graphicData2[0]) {
      if (column === 'year' || column === 'area' || column === 'area_code') continue;
      lines_2[column] = graphicData2.map(function(d) {
        return {
          'date': d.year,
          'amt': +d.value
        };
      });
    };

    var lineMax2 = d3.max(lines_2.value, function(d) {
      return d.amt
    });
    var lineMin2 = d3.min(lines_2.value, function(d) {
      return d.amt
    })

    var yDomain_2 = [lineMin2 - 5, lineMax2 - 5];

    y_2.domain(yDomain_2);

    if (document.getElementsByTagName('svg').length) {

      line1 = d3.select('.g-container').selectAll('.line1')
        .data(d3.entries(lines_1));

      line1
        .enter()
        .merge(line1)
        .transition()
        .duration(1000)
        .attr('d', function(d) {
          return line_1(d.value)
        });

      // reset stroke-dasharray to get correct length
      line1.attr('stroke-dasharray', '0,0');

      // update the dots and text

      firstDot1 = lines_1.yourarea[0];
      lastDot1 = lines_1.yourarea[lines_1.yourarea.length - 1];

      // first dot
      dot1First = d3.select('.g-container').selectAll('.dot1First')
        .data([firstDot1]);

      dot1First
        .enter()
        .merge(dot1First)
        .transition()
        .duration(1000)
        .attr("cx", function(d, i) {
          return x_1(d.date)
        })
        .attr('cy', function(d, i) {
          return y_1(d.amt)
        });

      // first dot text
      d3.selectAll('text').remove();
      d3.select('.dot1First-g').remove();
      d3.select('.dot2First-g').remove();
      d3.select('.dot1Second-g').remove();
      d3.select('.dot2Second-g').remove();

      dot1FirstText = d3.select('.g-container').selectAll('dot1First-g')
        .data([firstDot1])
        .enter()
        .append('g').attr('class', 'dot1First-g')

      // last dot
      dot2First = d3.select('.g-container').selectAll('.dot2First')
        .data([lastDot1])

      dot2First
        .enter()
        .merge(dot2First)
        .transition()
        .duration(1000)
        .attr("cx", function(d, i) {
          return x_1(d.date)
        })
        .attr('cy', function(d, i) {
          return y_1(d.amt)
        });

      dot2FirstText = d3.select('.g-container').selectAll('dot2First-g')
        .data([lastDot1])
        .enter()
        .append('g').attr('class', 'dot2First-g')


      // second chart update

      line2 = d3.select('.g-container-2').selectAll('.line2')
        .data(d3.entries(lines_2));

      line2
        .enter()
        .merge(line2)
        .transition()
        .duration(1000)
        .attr('d', function(d) {
          return line_2(d.value)
        });

      // reset stroke-dasharray to get correct length
      line2.attr('stroke-dasharray', '0,0');

      // add dot markers and text to lines
      firstDot2 = lines_2.value[0];
      lastDot2 = lines_2.value[lines_2.value.length - 1];

      // first dot
      dot1Second = d3.select('.g-container-2').selectAll('.dot1Second')
        .data([firstDot2]);

      dot1Second
        .enter()
        .merge(dot1Second)
        .transition()
        .duration(1000)
        .attr("cx", function(d, i) {
          return x_2(d.date)
        })
        .attr('cy', function(d, i) {
          return y_2(d.amt)
        });

      dot1SecondText = d3.select('.g-container-2').selectAll('.dot1Second-g')
        .data([firstDot2])
        .enter()
        .append('g').attr('class', 'dot1Second-g')

      // last dot
      dot2Second = d3.select('.g-container-2').selectAll('.dot2Second')
        .data([lastDot2])

      dot2Second
        .enter()
        .merge(dot2Second)
        .transition()
        .duration(1000)
        .attr("class", "dot2Second")
        .attr("cx", function(d, i) {
          return x_2(d.date)
        })
        .attr('cy', function(d, i) {
          return y_2(d.amt)
        });

      dot2SecondText = d3.select('.g-container-2').selectAll('.dot2Second-g')
        .data([lastDot2])
        .enter()
        .append('g').attr('class', 'dot2Second-g');

      drawText()
    } else {
      // chart 1
      var svg_1 = d3.select('#chart1')
        .append('svg')

      svg_1
        .attr("id", "chart-2")
        .style("background-color", "#fff")
        .attr("width", chart_width_1 + margin_1.left + margin_1.right)
        .attr("height", height_1 + margin_1.top + margin_1.bottom) //+30)
        .append("g")
        .attr("class", "g-container")
        .attr("transform", "translate(" + margin_1.left + "," + margin_1.top + ")");

      d3.select('.g-container').append('g')
        .attr('class', 'y1 axis1')
        .call(yAxis_1);

      //create x axis, if y axis doesn't start at 0 drop x axis accordingly
      d3.select('.g-container').append('g')
        .attr('class', 'x1 axis1')
        .attr('transform', 'translate(0,' + height_1 + ')')
        .call(xAxis_1);

      d3.select(".x1").select("path").style("stroke", "#666");

      //create line
      line1 = d3.select('.g-container').append('g').selectAll('path')
        .data(d3.entries(lines_1));

      line1
        .enter()
        .append('path')
        .attr('class', 'line1')
        .style("stroke", '#36add9')
        .style("fill", 'none')
        .style("stroke-width", 3)
        .style("stroke-linecap", 'round')
        .style("stroke-linejoin", 'round')
        .attr('d', function(d) {
          return line_1(d.value)
        })
        .call(transition)

      // add dot markers and text to lines
      firstDot1 = lines_1.yourarea[0];
      lastDot1 = lines_1.yourarea[lines_1.yourarea.length - 1];

      // first dot
      dot1First = d3.select('.g-container').selectAll('.dot1First')
        .data([firstDot1])

      dot1First
        .enter()
        .append("circle")
        .attr("class", "dot1First")
        .attr("cx", function(d, i) {
          return x_1(d.date)
        })
        .attr('cy', function(d, i) {
          return y_1(d.amt)
        })
        .attr("r", 5)
        .style("fill", "#36add9");

      dot1FirstText = d3.select('.g-container').selectAll('dot1First-g')
        .data([firstDot1])
        .enter()
        .append('g').attr('class', 'dot1First-g')

      // last dot
      dot2First = d3.select('.g-container').selectAll('.dot2First')
        .data([lastDot1])

      dot2First
        .enter()
        .append("circle")
        .attr("class", "dot2First")
        .attr("cx", function(d, i) {
          return x_1(d.date)
        })
        .attr('cy', function(d, i) {
          return y_1(d.amt)
        })
        .attr("r", 5)
        .style("fill", "#36add9");

      dot2FirstText = d3.select('.g-container').selectAll('dot2First-g')
        .data([lastDot1])
        .enter()
        .append('g').attr('class', 'dot2First-g')

      // chart 2

      var svg_2 = d3.select('#chart2')
        .append('svg')

      svg_2
        .attr("id", "chart-2")
        .style("background-color", "#fff")
        .attr("width", chart_width_1 + margin_1.left + margin_1.right)
        .attr("height", height_1 + margin_1.top + margin_1.bottom) //+30)
        .append("g")
        .attr("class", "g-container-2")
        .attr("transform", "translate(" + margin_1.left + "," + margin_1.top + ")");

      d3.select('.g-container-2').append('g')
        .attr('class', 'y2 axis2')
        .call(yAxis_2);

      //create x axis, if y axis doesn't start at 0 drop x axis accordingly
      d3.select('.g-container-2').append('g')
        .attr('class', 'x2 axis2')
        .attr('transform', 'translate(0,' + height_1 + ')')
        .call(xAxis_2);

      d3.select(".x2").select("path").style("stroke", "#666");

      //create lines
      d3.select('.g-container-2').append('g').selectAll('path')
        .data(d3.entries(lines_2))
        .enter()
        .append('path')
        .attr('class', 'line2')
        .style("stroke", '#36add9')
        .style("fill", 'none')
        .style("stroke-width", 3)
        .style("stroke-linecap", 'round')
        .style("stroke-linejoin", 'round')
        .attr('d', function(d) {
          return line_2(d.value);
        })
        .call(transition);

      // add dot markers and text to lines
      firstDot2 = lines_2.value[0];
      lastDot2 = lines_2.value[lines_2.value.length - 1];

      // first dot

      dot1Second = d3.select('.g-container-2').selectAll('.dot1Second')
        .data([firstDot2])

      dot1Second
        .enter()
        .append("circle")
        .attr("class", "dot1Second")
        .attr("cx", function(d, i) {
          return x_2(d.date)
        })
        .attr('cy', function(d, i) {
          return y_2(d.amt)
        })
        .attr("r", 5)
        .style("fill", "#36add9");

      dot1SecondText = d3.select('.g-container-2').selectAll('.dot1Second-g')
        .data([firstDot2])
        .enter()
        .append('g').attr('class', 'dot1Second-g')

      // last dot
      dot2Second = d3.select('.g-container-2').selectAll('.dot2Second')
        .data([lastDot2])

      dot2Second
        .enter()
        .append("circle")
        .attr("class", "dot2Second")
        .attr("cx", function(d, i) {
          return x_2(d.date)
        })
        .attr('cy', function(d, i) {
          return y_2(d.amt)
        })
        .attr("r", 5)
        .style("fill", "#36add9");

      dot2SecondText = d3.select('.g-container-2').selectAll('.dot2Second-g')
        .data([lastDot2])
        .enter()
        .append('g').attr('class', 'dot2Second-g')

      drawTextNoSvg()
    } // end of if else

    // // css fix
    d3.selectAll("path").attr("fill", "none");

    d3.selectAll("text").attr("font-family", "'Open Sans', sans-serif");

    d3.select('.y1')
      .style('display', 'none');

    d3.select('.x1')
      .style('display', 'none');

    d3.select('.y2')
      .style('display', 'none');

    d3.select('.x2')
      .style('display', 'none');

    d3.selectAll(".x1 text").attr("font-size", "12px").attr("fill", "#666");
    d3.selectAll(".y1 text").attr("font-size", "12px").attr("fill", "#666");

    d3.select(".x1")
      // .attr("stroke", "red")
      .attr("stroke-width", "1px")
      .style("shape-rendering", "crispEdges");

    // use pym to calculate chart dimensions
    if (pymChild) {
      pymChild.sendHeight();
    }

    // pymChild.sendHeight();
    function drawTextNoSvg() {
      dot1FirstText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_1(d.date)-10
        })
        .attr('y', (height_1-margin_1.top-margin_1.bottom))
        .attr('text-anchor', 'end')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return numberFormat2(d.amt) + ' pubs'
        })
        .style('opacity', '0')
        .transition()
        // .duration(3000)
        .style('opacity', '1');

      dot1FirstText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_1(d.date)-10
        })
        .attr('y',  (height_1-margin_1.top-margin_1.bottom)+20)
        .attr('text-anchor', 'end')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return new Date(d.date).getFullYear()
        })
        .style('opacity', '0')
        .transition()
        // .duration(3000)
        .style('opacity', '1');

      dot2FirstText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_1(d.date)+10
        })
        .attr('y',(height_1-margin_1.top-margin_1.bottom))
        .attr('text-anchor', 'start')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return numberFormat2(d.amt) + ' pubs'
        })
        .style('opacity', '0')
        .transition()
        .delay(2000)
        .duration(1000)
        .style('opacity', '1');

      dot2FirstText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_1(d.date)+10
        })
        .attr('y', (height_1-margin_1.top-margin_1.bottom)+20)
        .attr('text-anchor', 'start')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return new Date(d.date).getFullYear()
        })
        .style('opacity', '0')
        .transition()
        .delay(2000)
        .duration(1000)
        .style('opacity', '1');

      dot1SecondText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_1(d.date)-10
        })
        .attr('y', (height_1-margin_1.top-margin_1.bottom))
        .attr('text-anchor', 'end')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return numberFormat2(d.amt) + ' jobs'
        })
        .style('opacity', '0')
        .transition()
        // .duration(3000)
        .style('opacity', '1');

      dot1SecondText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_2(d.date)-10
        })
        .attr('y', (height_1-margin_1.top-margin_1.bottom)+20)
        .attr('text-anchor', 'end')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return new Date(d.date).getFullYear()
        })
        .style('opacity', '0')
        .transition()
        // .duration(3000)
        .style('opacity', '1');

      dot2SecondText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_2(d.date)+10
        })
        .attr('y', (height_1-margin_1.top-margin_1.bottom))
        .attr('text-anchor', 'start')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return numberFormat2(d.amt) + ' jobs'
        })
        .style('opacity', '0')
        .transition()
        .delay(2000)
        .duration(1000)
        .style('opacity', '1');

      dot2SecondText
        .append('text')
        .attr('class', 'dot-text')
        .attr('x', function(d, i) {
          return x_1(d.date)+10
        })
        .attr('y', (height_1-margin_1.top-margin_1.bottom)+20)
        .attr('text-anchor', 'start')
        .style('fill', '#36add9')
        .text(function(d, i) {
          return new Date(d.date).getFullYear()
        })
        .style('opacity', '0')
        .transition()
        .delay(2000)
        .duration(1000)
        .style('opacity', '1');
    }

    function drawText() {

          dot1FirstText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_1(d.date)-10
            })
            .attr('y', (height_1-margin_1.top-margin_1.bottom))
            .attr('text-anchor', 'end')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return numberFormat2(d.amt) + ' pubs'
            })
            .style('opacity', '0')
            .transition()
            .duration(3000)
            .style('opacity', '1');

          dot1FirstText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_1(d.date)-10
            })
            .attr('y',  (height_1-margin_1.top-margin_1.bottom)+20)
            .attr('text-anchor', 'end')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return new Date(d.date).getFullYear()
            })
            .style('opacity', '0')
            .transition()
            .duration(3000)
            .style('opacity', '1');

          dot2FirstText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_1(d.date)+10
            })
            .attr('y',(height_1-margin_1.top-margin_1.bottom))
            .attr('text-anchor', 'start')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return numberFormat2(d.amt) + ' pubs'
            })
            .style('opacity', '0')
            .transition()
            // .delay(2000)
            .duration(3000)
            .style('opacity', '1');

          dot2FirstText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_1(d.date)+10
            })
            .attr('y', (height_1-margin_1.top-margin_1.bottom)+20)
            .attr('text-anchor', 'start')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return new Date(d.date).getFullYear()
            })
            .style('opacity', '0')
            .transition()
            // .delay(2000)
            .duration(3000)
            .style('opacity', '1');

          dot1SecondText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_1(d.date)-10
            })
            .attr('y', (height_1-margin_1.top-margin_1.bottom))
            .attr('text-anchor', 'end')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return numberFormat2(d.amt) + ' jobs'
            })
            .style('opacity', '0')
            .transition()
            .duration(3000)
            .style('opacity', '1');

          dot1SecondText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_2(d.date)-10
            })
            .attr('y', (height_1-margin_1.top-margin_1.bottom)+20)
            .attr('text-anchor', 'end')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return new Date(d.date).getFullYear()
            })
            .style('opacity', '0')
            .transition()
            .duration(3000)
            .style('opacity', '1');

          dot2SecondText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_2(d.date)+10
            })
            .attr('y', (height_1-margin_1.top-margin_1.bottom))
            .attr('text-anchor', 'start')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return numberFormat2(d.amt) + ' jobs'
            })
            .style('opacity', '0')
            .transition()
            // .delay(2000)
            .duration(3000)
            .style('opacity', '1');

          dot2SecondText
            .append('text')
            .attr('class', 'dot-text')
            .attr('x', function(d, i) {
              return x_1(d.date)+10
            })
            .attr('y', (height_1-margin_1.top-margin_1.bottom)+20)
            .attr('text-anchor', 'start')
            .style('fill', '#36add9')
            .text(function(d, i) {
              return new Date(d.date).getFullYear()
            })
            .style('opacity', '0')
            .transition()
            // .delay(2000)
            .duration(3000)
            .style('opacity', '1');
    }//end of draw text
  } //end of drawGraphic

  // function that makes api call
  function getCodes(myPC) {

    var myURIstring = encodeURI("https://api.postcodes.io/postcodes/" + myPC);
    $.support.cors = true;
    $.ajax({
      type: "GET",
      crossDomain: true,
      dataType: "jsonp",
      url: myURIstring,
      error: function(xhr, ajaxOptions, thrownError) {},
      success: function(data1) {
        if (data1.status == 200) {
          //$("#pcError").hide();
          var laCode = data1.result.codes.admin_district;
          var laName = data1.result.admin_district;
          drawGraphic(laCode, laName)
        } else {
          $("#pcText").val("Sorry, invalid postcode.");
        }
      }
    });
  } //end of getCodes

  // animate the line
  function transition(path) {
    path
      .transition()
      .duration(2000)
      .attrTween('stroke-dasharray', tweenDash)
  }//end of transition

  function tweenDash() {
    var l = this.getTotalLength();
    var i = d3.interpolateString("0," + l, l + "," + l);
    return function(t) {
      return i(t);
    };
  }//end of tweenDahs

  function socialbuttons() {

    d3.select('.share').remove();

    keydivwidth = parseInt(d3.select("#keydiv").style("width"));

    d3.select('#keydiv').append("div").attr("class","share").style("width",(keydivwidth-20) +"px").html("<span>Share</span>");

    var sharebuttons = 	d3.select('.share').append("div").style("padding-top","5px")
    clickedlink = false;

    ParentURL = (window.location != window.parent.location)
                  ? document.referrer
                  : document.location;

    sharebuttons.append("a")
      .attr("id","facebookShare")
      .attr("href","https://www.facebook.com/sharer/sharer.php?u=" + ParentURL)
      .attr("target","_blank")
      .attr("title","Facebook")
      .append("img")
      .attr("class","socialicon")
      .attr("src","img/facebook.svg")
      .style("height","30px")
      .style("width","30px")
      .on("click",function(){
        dataLayer.push({'event':'buttonClicked','selected':'socialshare'})
      });

    sharebuttons.append("a")
        .attr("id","twitterShare")
        .attr("href","https://twitter.com/intent/tweet?text=What's happening to pubs where you live? Find out with this interactive tool. " + ParentURL)
        .attr("target","_blank")
        .style("height","30px")
        .style("width","30px")
        .attr("title","Twitter")
        .append("img")
        .attr("class","socialicon")
        .attr("src","img/twitter.svg")
        .style("height","30px")
        .style("width","30px")
        .style("padding-left","5px")
        .style("padding-right","5px")
        .on("click",function(){
          dataLayer.push({'event':'buttonClicked','selected':'socialshare'})
        });

    sharebuttons.append("img")
        .attr("class","socialicon")
        .attr("src","img/link.svg")
        .style("height","30px")
        .style("width","30px")
        .on("click", copiedtoclipboard);


    sharebuttons.append("p").attr("class","copytextlabel").text("Copy this link").style("text-align","left").style("font-weight","400").style("font-size","14px").style("margin","5px").style("display","none");
    sharebuttons.append("input").attr("class","copytext").attr("value",ParentURL).style("height","30px").style("width","100%").style("display","none");


    function copiedtoclipboard() {

      dataLayer.push({'event':'buttonClicked','selected':'socialshare'})

      if(clickedlink ==false) {
        clickedlink =true;
        d3.select(".copytextlabel").style("display","block");
        d3.select(".copytext").style("display","block");
		  if (pymChild) {
			pymChild.sendHeight();
		  }
      }	else {
        clickedlink =false;
        d3.select(".copytextlabel").style("display","none");
        d3.select(".copytext").style("display","none");
		  if (pymChild) {
			pymChild.sendHeight();
		  }
      }
    }
  }//end of social buttons
  socialbuttons()
} //end of init

if (Modernizr.svg) {
  d3.queue()
    .defer(d3.csv, 'data/pubperhead.csv')
    .defer(d3.csv, 'data/pubnumbers.csv')
    .defer(d3.csv, 'data/pubjobs.csv')
    .await(function(error, data_csv1, data_csv2, data_csv3) {
      //load chart data
      data1 = data_csv1;
      data2 = data_csv2;
      data3 = data_csv3;
      // console.log(data)

      init()

      //use pym to create iframed chart dependent on specified variables
      // pymChild = new pym.Child({
      //   renderCallback: init
      // });
    })
} else {
  //use pym to create iframe containing fallback image (which is set as default)
  pymChild = new pym.Child();
  if (pymChild) {
    pymChild.sendHeight();
  }
}
