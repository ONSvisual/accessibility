var pymChild = null;
var graphic_1 = d3.select('#chart1');
var graphic_2 = d3.select('#chart2');
var keypoints = d3.select('#keypoints');
var footer = d3.select(".footer");

function init() {

  // clear out existing graphics
  graphic_1.selectAll("*").remove();

  // clear out existing graphics
  graphic_2.selectAll("*").remove();




  // pymChild = new pym.Child;

  // document.getElementById('submitPost').addEventListener('click', function() {
  //   var myPostcode = document.getElementById('pcText').value
  //   getCodes(myPostcode)
  // })

  // click to get postcode and submit to api call
  $("#submitPost").click(function(event) {

    event.preventDefault();
    event.stopPropagation();

    myValue = $("#pcText").val();

    getCodes(myValue);

  });



  function drawGraphic(code, name) {

    // First chart
    var UKSeries1 = data1.filter(function(d) {
      return d['Area code'] === 'UK0000001';
    });

    var yourSeries1 = data1.filter(function(d) {
      return d['Area code'] === code;
    });

    var chart1data = d3.zip(UKSeries1,yourSeries1);
    console.log(yourSeries1);
    console.log(UKSeries1);




    var UKFinal = UKSeries1[0][2018];
    var yourFinal1 = yourSeries1[0][2018];

    var difference1 = +UKFinal - (+yourFinal1);

    if (UKFinal < yourFinal1) {
      var highLow = "higher";
    } else if (UKFinal > yourFinal1) {
      var highLow = "lower";
    };

    // Second chart
    var yourSeries2 = data2.filter(function(d) {
      return d['Area code'] === code;
    });

    var yourFirst2 = yourSeries2[0][2001];
    var yourFinal2 = yourSeries2[0][2018];

    var difference2 = Math.abs(+yourFirst2 - (+yourFinal2));

    var numberFormat = d3.format(",.0f");

    if (yourFirst2 < yourFinal2) {
      var highLow2 = "more";
    } else if (yourFirst2 > yourFinal2) {
      var highLow2 = "fewer";
    };

    // fill the first paragraph with text
    document.getElementById('pubs-person').innerHTML = yourFinal1;
    document.getElementsByClassName('area-name')[0].innerHTML = name;
    document.getElementById('difference-average').innerHTML = difference1;
    document.getElementById('higher-lower').innerHTML = highLow;

    // fill the second paragraph with text
    document.getElementById('num-pubs').innerHTML = numberFormat(difference2);
    document.getElementById('more-less').innerHTML = highLow2;
    document.getElementsByClassName('area-name')[1].innerHTML = name;

    // chart1

    var graphicData1 = [];

    // for(i = 0; i < yourSeries1.length; i++){
      yourSeries1.forEach(function(d) {
        for (var key in d) {
          var obj = {};
          if (key !== "Area name" && key !== "Area code") {
            obj.year = key;
            obj.uk = UKSeries1[0][key];
            obj.yourarea=yourSeries1[0][key]
            graphicData1.push(obj)
          }
        }
      });
    // }
    //
    console.log(graphicData1)

    graphicData1.forEach(function(d) {
      d.year = d3.timeParse('%Y')(d.year);

    });

    var graphicDataUK = [];

    UKSeries1.forEach(function(d) {
      for (var key in d) {
        var obj = {};
        if (key !== "Area name" && key !== "Area code") {
          obj.year = key;
          obj.value = +d[key];
          obj.area = d['Area name'];
          obj.area_code = d['Area code'];
          graphicDataUK.push(obj)
        }
      }
    });

    graphicDataUK.forEach(function(d) {
      d.year = d3.timeParse('%Y')(d.year);
    });

    var width = document.getElementById('chart1').clientWidth;

    var margin_1 = {
      top: 40,
      right: 0,
      bottom: 0,
      left: 0
    };

    var chart_width_1 = parseInt(width) - margin_1.left - margin_1.right;
    var height_1 = 120;

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

    if (document.getElementsByTagName('svg').length) {
      console.log('SVG exists')
      // binding data to lines

      var updateLine = d3.select('.g-container').select(".line1")
          .data(d3.entries(lines_1.uk))



      console.log(lines_1.uk)

      updateLine.select('.line1')
        .enter()
        // .append('path')
        // .attr('class', function(d,i) { return 'line line'+i})
        .style("stroke", "red")
        // .style("fill", 'none')
        // .style("stroke-width", 3)
        // .style("stroke-linecap", 'round')
        // .style("stroke-linejoin", 'round')
        .merge(updateLine)
        .transition()
        .duration(1000)
        .attr('d', line_1);

        } else {
          console.log('SVG does not exists')


      var yDomain_1 = [0, 12];

      y_1.domain(yDomain_1);

      var svg_1 = d3.select('#chart1')
        .append('svg')
      svg_1
        .attr("id", "chart-1")
        .style("background-color", "#fff")
        .attr("width", chart_width_1 + margin_1.left + margin_1.right)
        .attr("height", height_1 + margin_1.top + margin_1.bottom) //+30)
        .append("g")
        .attr("class", "g-container")
        .attr("transform", "translate(" + margin_1.left + "," + margin_1.bottom + ")");

      // svg_1.append("rect")
      //   .style("fill", "#fff")
      //   .attr("width", chart_width_1)
      //   .attr("height", height_1);

      d3.select('.g-container').append('g')
        .attr('class', 'y1 axis1')
        .call(yAxis_1);

      //create x axis, if y axis doesn't start at 0 drop x axis accordingly
      d3.select('.g-container').append('g')
        .attr('class', 'x1 axis1')
        .attr('transform', 'translate(0,' + height_1 + ')')
        .call(xAxis_1);

      d3.select(".x1").select("path").style("stroke", "#666");


      //create lines

      var lineColor = ["#dadada", "#36add9"]
      d3.select('.g-container').append('g').selectAll('path')
        .data(d3.entries(lines_1))
        .enter()
        .append('path')
        .attr('class', function(d,i) { return 'line line'+i})
        .style("stroke", function(d,i) { return lineColor[i]})
        .style("fill", 'none')
        .style("stroke-width", 3)
        .style("stroke-linecap", 'round')
        .style("stroke-linejoin", 'round')
        .attr('d', function(d) {console.log(d)
          return line_1(d.value);
        });

      // chart2

      var graphicData2 = [];

      yourSeries2.forEach(function(d) {
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
      }

      var yDomain_2 = [0, 30000];

      y_2.domain(yDomain_2);

      var svg_2 = d3.select('#chart2')
        .append('svg')

      svg_2
        .attr("id", "chart-2")
        .style("background-color", "#fff")
        .attr("width", chart_width_1 + margin_1.left + margin_1.right)
        .attr("height", height_1 + margin_1.top + margin_1.bottom) //+30)
        .append("g")
        .attr("class", "g-container-2")
        .attr("transform", "translate(" + margin_1.left + "," + margin_1.bottom + ")");

      // svg_1.append("rect")
      //   .style("fill", "#fff")
      //   .attr("width", chart_width_1)
      //   .attr("height", height_1);

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
        .attr('class', 'line')
        .style("stroke", '#36add9')
        .style("fill", 'none')
        .style("stroke-width", 3)
        .style("stroke-linecap", 'round')
        .style("stroke-linejoin", 'round')
        .attr('d', function(d) {
          return line_2(d.value);
        });


      // // css fix
      d3.selectAll("path").attr("fill", "none");

      d3.selectAll("text").attr("font-family", "'Open Sans', sans-serif");

      d3.select('.y1')
        .style('display', 'none');

      d3.select('.y2')
        .style('display', 'none');

      d3.selectAll(".x1 text").attr("font-size", "12px").attr("fill", "#666");
      d3.selectAll(".y1 text").attr("font-size", "12px").attr("fill", "#666");

      d3.select(".x1")
        .attr("stroke", "red")
        .attr("stroke-width", "1px")
        .style("shape-rendering", "crispEdges");
    }


    // use pym to calculate chart dimensions
    if (pymChild) {
      pymChild.sendHeight();
    }


    pymChild.sendHeight();
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
  // pymChild.sendHeight();
} //end of init

if (Modernizr.svg) {
  d3.queue()
    .defer(d3.csv, 'data/pubperhead.csv')
    .defer(d3.csv, 'data/pubnumbers.csv')
    .await(function(error, data_csv1, data_csv2) {
      //load chart data
      data1 = data_csv1;
      data2 = data_csv2;
      // console.log(data)

      //use pym to create iframed chart dependent on specified variables
      pymChild = new pym.Child({
        renderCallback: init
      });
    })
} else {
  //use pym to create iframe containing fallback image (which is set as default)
  pymChild = new pym.Child();
  if (pymChild) {
    pymChild.sendHeight();
  }
}
