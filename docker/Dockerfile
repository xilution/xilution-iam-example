FROM mhart/alpine-node:10.16.3 as build

WORKDIR /build

COPY package.json yarn.lock /build/

ARG XILUTION_ENVIRONMENT
ARG XILUTION_SUB_ORGANIZATION_ID
ARG XILUTION_WEB_CLIENT_ID
ARG XILUTION_INSTANCE_ID

RUN yarn install --frozen-lockfile && yarn cache clean

COPY src /build/src
COPY tsconfig.json /build
COPY tslint.json /build
COPY public /build/public
COPY scripts /build/scripts
COPY webpack.config.js /build

RUN yarn verify
RUN ls scripts
RUN webpack-cli \
      --env.XILUTION_ENVIRONMENT="${XILUTION_ENVIRONMENT}" \
      --env.XILUTION_SUB_ORGANIZATION_ID="${XILUTION_SUB_ORGANIZATION_ID}" \
      --env.XILUTION_WEB_CLIENT_ID="${XILUTION_WEB_CLIENT_ID}" \
      --env.XILUTION_INSTANCE_ID="${XILUTION_INSTANCE_ID}" \
      --mode production \
      --config webpack.config.js

FROM nginx:1.17.2-alpine

COPY --from=build /build/dist /usr/share/nginx/html

EXPOSE 80
