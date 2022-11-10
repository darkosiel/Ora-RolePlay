// Import atm.json
// Read the file using fs lib
// Parse the file using JSON.parse
// Reformat the structure
// Write the file using fs lib


const fs = require('fs');
const points = JSON.parse(fs.readFileSync('atm.json'));

// Reformat the structure of the table
const newPoints = []

points.forEach((point) => {
	// newPoints.push({
	// 	prop : point.Name,
	// 	coords: `vector3(${point.Position.X}, ${point.Position.Y}, ${point.Position.Z})`,	
	// 	rot : `vector3(${point.Rotation.X}, ${point.Rotation.Y}, ${point.Rotation.Z})`,
	// })
	newPoints.push({
		prop : point.Name,
		coords: { "x": point.Position.X, "y": point.Position.Y, "z": point.Position.Z },
		rot : { "x": point.Rotation.X, "y": point.Rotation.Y, "z": point.Rotation.Z },
	})
})

// Create a new file with the new structure
fs.writeFile('atms.json', JSON.stringify(newPoints), (err) => {
	if (err) throw err
	console.log('The file has been saved!')
})