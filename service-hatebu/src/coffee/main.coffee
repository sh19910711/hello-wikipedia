jQuery = require("jquery")

CHART_MARGIN  = 12
CHART_WIDTH   = 640 - CHART_MARGIN * 2
CHART_HEIGHT  = 480 - CHART_MARGIN * 2

CHART_MARGIN_TRANSLATE = "translate(#{CHART_MARGIN}, #{CHART_MARGIN})"

jQuery ->
  d3 = require("d3")

  svg = d3.select("#stage").append("svg")
    .attr "class", "chart"
    .attr "width", CHART_WIDTH + CHART_MARGIN * 2
    .attr "height", CHART_HEIGHT + CHART_MARGIN * 2
    .append "g"
    .attr "transform", CHART_MARGIN_TRANSLATE

  x = d3.time.scale()
    .range [0, CHART_WIDTH - 40]
  x.domain [5, 1]

  y = d3.scale.linear()
    .range [CHART_HEIGHT - 40, 0.1]
  y.domain [128, 0.1]

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

  margin = 28

  # x-axis
  svg.append "g"
    .attr "class", "axis x-axis"
    .attr "transform", "translate(#{margin}, 0)"
    .call xAxis

  # y-axis
  svg.append "g"
    .attr "class", "axis y-axis"
    .attr "transform", "translate(0, #{margin})"
    .call yAxis
    .append "text"
      .style "text-anchor", "end"
      .attr "x", 50
      .attr "y", 430
      .text "はてブ数"

  drawChart = (pages)->

    # line
    svg.selectAll "circle"
      .data pages
      .enter()
      .append "circle"
      .attr "cx", 0
      .attr "cy", 0
      .transition()
      .duration 50
      .delay (d, i)-> i * 1
      .attr "r", 5
      .attr "cx", (page)-> x(page.rank) + margin
      .attr "cy", (page)-> y(page.hatebu) + margin

  d3.json "/pages", drawChart

