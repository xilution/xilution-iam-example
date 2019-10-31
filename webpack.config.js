const path = require("path");
const webpack = require("webpack");

const HtmlWebPackPlugin = require("html-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");

module.exports = env => {

    if (!env) {
        console.error("No environment found.");
        process.exit(1);
    }

    if (!env.XILUTION_ENVIRONMENT) {
        console.error("Environment must be set.");
        process.exit(1);
    }

    if (!env.XILUTION_SUB_ORGANIZATION_ID) {
        console.error("Organization ID must be set.");
        process.exit(1);
    }

    if (!env.XILUTION_WEB_CLIENT_ID) {
        console.error("Client ID must be set.");
        process.exit(1);
    }

    if (!env.API_BASE_URL) {
        console.error("API base URL must be set.");
        process.exit(1);
    }

    return {
        mode: "development",
        devtool: "inline-source-map",
        devServer: {
            contentBase: "/",
            openPage: "",
            historyApiFallback: true,
        },
        entry: "./src/index.tsx",
        module: {
            rules: [
                {
                    exclude: /node_modules/,
                    test: /\.(ts|tsx)$/,
                    loader: "ts-loader",
                },
                {
                    test: /\.html$/,
                    use: [
                        {
                            loader: "html-loader",
                            options: {
                                minimize: false
                            }
                        }
                    ]
                },
            ],
        },
        output: {
            filename: "bundle.js",
            path: path.resolve(__dirname, "./dist"),
        },
        stats: {
            warnings: false
        },
        resolve: {
            extensions: [".mjs", ".tsx", ".ts", ".js"],
        },
        plugins: [
            new webpack.DefinePlugin({
                __XILUTION_ENVIRONMENT__: JSON.stringify(env.XILUTION_ENVIRONMENT),
                __XILUTION_SUB_ORGANIZATION_ID__: JSON.stringify(env.XILUTION_SUB_ORGANIZATION_ID),
                __XILUTION_WEB_CLIENT_ID__: JSON.stringify(env.XILUTION_WEB_CLIENT_ID),
                __API_BASE_URL__: JSON.stringify(env.API_BASE_URL),
            }),
            new HtmlWebPackPlugin({
                filename: "./index.html",
                template: "./public/index.html",
            }),
            new CopyWebpackPlugin([
                {
                    from: path.resolve(__dirname, "./public"),
                    to: path.resolve(__dirname, "./dist")
                }
            ]),
        ],
    }
};
