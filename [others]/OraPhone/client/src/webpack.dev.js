module.exports = {
    entry: './client.js',
    output: {
        filename: 'client.js',
        path: __dirname+'/..',
    },
    mode: 'development',
    watch: true,
    watchOptions: {
        ignored: /node_modules/
    },
};