const path = require('path');
module.exports = {
    mode: "development",
    entry: "./src/js/main.js",
    output: {
        path: path.resolve(__dirname, "src/dist"),
        filename: "bundle.js",
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                use: 'babel-loader',
                exclude: /node_modules/
            },
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader','sass-loader'],
            }
        ]
    }
}