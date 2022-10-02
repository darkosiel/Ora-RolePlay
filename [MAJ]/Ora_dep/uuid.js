const uuid = require('uuid-with-v6');

onNet("uuid", (callback) => {
    callback(uuid.v6())
});