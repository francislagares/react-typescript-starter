ARG NODE=alpine:latest

# Stage 1: Development environment
FROM ${NODE} AS development

RUN apk update && apk add --no-cache libc6-compat nodejs yarn

WORKDIR /app

COPY package.json .

RUN if [ -f "yarn.lock" ]; then COPY yarn.lock ./; fi
RUN yarn set version stable

COPY . .

RUN yarn install --silent

CMD ["yarn", "dev"]

# Stage 2: Build production image
FROM ${NODE} AS builder

RUN apk update && apk add --no-cache nodejs yarn

WORKDIR /app

COPY package.json .

RUN if [ -f "yarn.lock" ]; then COPY yarn.lock ./; fi
RUN yarn set version stable

COPY . .

RUN yarn install --silent

RUN yarn build

# Stage 3: Serve production image
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]