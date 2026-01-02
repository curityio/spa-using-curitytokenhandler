import CopyPlugin from 'copy-webpack-plugin';
import path from 'path';
import webpack from 'webpack';

const dirname = process.cwd();
const config: webpack.Configuration = {

  context: path.resolve(dirname, './src'),
  target: ['web'],

  entry: {
    app: ['./index.tsx']
  },
  module: {

    rules: [
      {
        test: /\.(ts|tsx)$/,
        use: 'ts-loader',
        exclude: /node_modules/
      }
    ]
  },
  resolve: {
    extensions: ['.ts', '.tsx', '.js']
  },
  output: {
    path: path.resolve(dirname, './dist'),
    filename: `[name].bundle.js`,
  },
  optimization: {

    splitChunks: {
      cacheGroups: {
        vendor: {
          chunks: 'initial',
          name: 'vendor',
          test: /node_modules/,
          enforce: true
        },
      }
    }
  },

  plugins: [

    new CopyPlugin({
      patterns: [
        {
          from: 'index.html',
          to: path.resolve('dist'),
        },
        {
          from: 'app.css',
          to: path.resolve('dist'),
        },
        {
          from: 'config.json',
          to: path.resolve('dist'),
        },
      ]
    }),
  ]
}

export default config;
