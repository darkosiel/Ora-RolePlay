// Algo that generate route randomly between points, but choose from one of the five closest points
const { table } = require('console');
const fs = require('fs');
function GenerateRoute(maxValue) {
	let points = JSON.parse(fs.readFileSync('atms.json'));
	let firstPoint = points[Math.floor(Math.random() * points.length)];
	let route = [firstPoint];
	let currentPoint = firstPoint;
	let maxNumberOfPoints = maxValue || 10;

	for (let i = 0; i < maxNumberOfPoints; i++) {
		let closestPoints = points.sort((a, b) => {
			let distA = Math.sqrt(Math.pow(currentPoint.coords.x - a.coords.x, 2) + Math.pow(currentPoint.coords.y - a.coords.y, 2));
			let distB = Math.sqrt(Math.pow(currentPoint.coords.x - b.coords.x, 2) + Math.pow(currentPoint.coords.y - b.coords.y, 2));
			console.log(distA, distB, distA - distB);
			return distA - distB;
		}).slice(0, 5);
		let nextPoint = closestPoints[Math.floor(Math.random() * closestPoints.length)];
		// find which point was choosen and remove it from the array
		let index = points.findIndex((point) => point.coords === nextPoint.coords);
		points.splice(index, 1);
		nextPoint.dist = Math.sqrt(Math.pow(currentPoint.coords.x - nextPoint.coords.x, 2) + Math.pow(currentPoint.coords.y - nextPoint.coords.y, 2));
		route.push(nextPoint);
		currentPoint = nextPoint;
	}

	console.log(route);
}

GenerateRoute(10);