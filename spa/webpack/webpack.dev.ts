import path from 'path';
import webpack from 'webpack';
import {merge} from 'webpack-merge';
import common from './webpack.common.js';

const dirname = process.cwd();
const devConfig: webpack.Configuration = {

  mode: 'development',
  devServer: {
    static: {
        directory: path.join(dirname, './dist'),
    },
    port: 3000,
    historyApiFallback: {
        index: 'index.html'
    },
    hot: true,
    allowedHosts: [
        'www.product.example', 'login.example.com'
    ],
  },
};

export default merge(common, devConfig);
