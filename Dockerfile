# Stage 1: Development environment
FROM node:alpine AS development

RUN apk update && apk add --no-cache nodejs
RUN corepack enable
RUN addgroup webdev && adduser -S -G webdev react-app

USER react-app

WORKDIR /app

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm install

USER react-app

COPY . .

EXPOSE 5173

CMD ["pnpm", "dev"]

# Stage 2: Build production image
FROM  node:alpine AS builder

RUN apk update && apk add --no-cache nodejs

WORKDIR /app

COPY package.json .
COPY pnpm-lock.yaml .

RUN corepack enable
RUN pnpm install

COPY . .

RUN pnpm build

# Stage 3: Serve production image
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]