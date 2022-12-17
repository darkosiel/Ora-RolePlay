// Create an array to store our particles
var particles = [];

// The amount of particles to render
var particleCount = 500;

// The maximum velocity in each direction
var maxVelocity = 1;

// The target frames per second (how often do we want to update / redraw the scene)
var targetFPS = 24;

// Create an image object (only need one instance)
var imageObj = new Image();

// Once the image has been downloaded then set the image on all of the particles
imageObj.onload = function() {
    particles.forEach(function(particle) {
            particle.setImage(imageObj);
    });
};

// Once the callback is arranged then set the source of the image
imageObj.src = "ui_assets/smoke.png";



// A function to create a particle object.
function Particle(context) {

    this.randomSeed = Math.random();

    // Set the initial x and y positions
    this.x = 0;
    this.y = 0;

    // Set the initial velocity
    this.xVelocity = 0;
    this.yVelocity = 0;

    // Set the radius
    this.radius = 5;

    // Store the context which will be used to draw the particle
    this.context = context;

    // The function to draw the particle on the canvas.
    this.draw = function() {
        
        // If an image is set draw it
        if(this.image){
            // global alpha goes from 0.1 to 0.2 in 5 seconds
            this.context.globalAlpha = 0.15 + 0.05 * Math.sin(Date.now() / 5000);
            this.context.drawImage(this.image, this.x - 100, this.y - 100);
        }
    };

    // Update the particle.
    this.update = function() {
        // Update the position of the particle with the addition of the velocity.
        this.x += this.xVelocity;
        this.y += this.yVelocity;

        // Check if has crossed the right edge
        if (this.x >= this.context.canvas.width) {
            this.xVelocity = -this.xVelocity;
            this.x = this.context.canvas.width;
        }
        // Check if has crossed the left edge
        else if (this.x <= 0) {
            this.xVelocity = -this.xVelocity;
            this.x = 0;
        }

        // Check if has crossed the bottom edge
        if (this.y >= this.context.canvas.height) {
            this.yVelocity = -this.yVelocity;
            this.y = this.context.canvas.height;
        }
        
        // Check if has crossed the top edge
        else if (this.y <= 0) {
            this.yVelocity = -this.yVelocity;
            this.y = 0;
        }
    };

    // A function to set the position of the particle.
    this.setPosition = function(x, y) {
        this.x = x;
        this.y = y;
    };

    // Function to set the velocity.
    this.setVelocity = function(x, y) {
        this.xVelocity = x;
        this.yVelocity = y;
    };
    
    this.setImage = function(image){
        this.image = image;
    }
}

// A function to generate a random number between 2 values
function generateRandom(min, max){
    return Math.random() * (max - min) + min;
}

// The canvas context if it is defined.
var context;

// Initialise the scene and set the context if possible
function init() {
    var canvas = document.getElementById('smoke');
    if (canvas.getContext) {

        // Set the context variable so it can be re-used
        context = canvas.getContext('2d');

        // Create the particles and set their initial positions and velocities
        for(var i=0; i < particleCount; ++i){
            var particle = new Particle(context);
            
            // Set the position to be inside the canvas bounds
            particle.setPosition(generateRandom(0, canvas.width), generateRandom(0, canvas.height));
            
            // Set the initial velocity to be either random and either negative or positive
            particle.setVelocity(generateRandom(-maxVelocity, maxVelocity), generateRandom(-maxVelocity, maxVelocity));
            particles.push(particle);            
        }
    }
    else {
        alert("Please use a modern browser");
    }
}

// The function to draw the scene
function draw() {
    // Clear the drawing surface
    context.clearRect(0, 0, context.canvas.width, context.canvas.height);

    // Go through all of the particles and draw them.
    particles.forEach(function(particle) {
        particle.draw();
    });
}

// Update the scene
function refresh() {
    particles.forEach(function(particle) {
        particle.update();
    });
}

// Initialize the scene
init();

// If the context is set then we can draw the scene (if not then the browser does not support canvas)
if (context) {
    setInterval(function() {
        // Update the scene befoe drawing
        refresh();

        // Draw the scene
        draw();
    }, 1000 / targetFPS);
}