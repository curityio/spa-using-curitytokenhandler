// import fs from 'fs';
import path from 'path';
import webpack from 'webpack';
import {merge} from 'webpack-merge';
import common from './webpack.common.js';
import webpackDevServer from 'webpack-dev-server';

const dirname = process.cwd();
const devServer: webpackDevServer.Configuration = {

    /*server: {
        type: 'https',  
        options: {
            key: fs.readFileSync('./certs/example.ssl.key'),
            cert: fs.readFileSync('./certs/example.ssl.crt'),
        },
    },*/
    static: {
        directory: path.join(dirname, './dist'),
    },
    port: 3000,
    historyApiFallback: true,
    hot: true,
    allowedHosts: [
        'www.product.example',
    ],
};

const devConfig: webpack.Configuration = {
    mode: 'development',
    devServer,
};

export default merge(common, devConfig);
