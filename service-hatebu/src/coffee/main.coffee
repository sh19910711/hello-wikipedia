jQuery = require("jquery")

CHART_WIDTH = 640
CHART_HEIGHT = 480

jQuery ->
  d3 = require("d3")

  svg = d3.select("#stage").append("svg")
    .attr "class", "chart"
    .attr "width", CHART_WIDTH
    .attr "height", CHART_HEIGHT
    .append "g"

  x = d3.time.scale()
    .range [0, CHART_WIDTH - 40]
  x.domain [1, 5]

  y = d3.scale.linear()
    .range [CHART_HEIGHT - 40, 0.1]
  y.domain [0.1, 128]

  xAxis = d3.svg.axis()
    .scale x
    .orient "bottom"

  yAxis = d3.svg.axis()
    .scale y
    .orient "right"

  line = d3.svg.line()
    .interpolate "monotone"
    .x (page)-> x(page.rank)
    .y (page)-> y(page.hatebu)

  drawSvg = (pages)->

    # x-axis
    svg.append "g"
      .attr "class", "axis x-axis"
      .attr "transform", "translate(0, 0)"
      .call xAxis

    # y-axis
    svg.append "g"
      .attr "class", "axis y-axis"
      .attr "transform", "translate(0, 0)"
      .call yAxis

    # line
    svg.selectAll "circle"
      .data pages
      .enter()
      .append "circle"
      .attr "r", 5
      .attr "cx", (page)-> x(page.rank)
      .attr "cy", (page)-> y(page.hatebu)

  d3.json "/pages", drawSvg

