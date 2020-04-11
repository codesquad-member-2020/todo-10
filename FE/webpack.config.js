const path = require('path');

module.exports = {
    mode: 'development',
    entry: ['./src/js/main.js', './src/style/common.scss', './src/style/todo.scss', './src/style/card.scss', './src/style/menu.scss'],
    output: {
        path: path.resolve(__dirname, 'src/dist'),
        filename: 'bundle.js',
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                use: 'babel-loader',
                exclude: /node_modules/,
            },
            {
                test: /\.scss$/,
                use: ['style-loader', 'css-loader', 'sass-loader'],
                exclude: /node_modules/,
            },
            {
                test: /\.ts$/,
                use: ['ts-loader'],
                exclude: /node_modules/,
            }
        ],
    },
};
