<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>

		<div class="chart-container" style="display: block; width: 800px; height: 385px;">
		    <canvas id="chart-${chartSort }" ></canvas>
		</div>
		<script type="text/javascript">
		var ctx = document.getElementById("chart-${chartSort}").getContext('2d');
		var myChart = new Chart(ctx, {
		    type: 'line',
		    data: { 
		    	datasets: ${dataSet},
		    	labels : ${labels}
		    },
		    options: {
				scales: {
			            yAxes: [{
	                		distribution: 'series'
			                ,ticks: {
			                    beginAtZero:true
			                    ,callback: function(value) {if (value % 1 === 0) {return value;}}
			                }
			            }]
			    }
		    }
		});
		</script>
