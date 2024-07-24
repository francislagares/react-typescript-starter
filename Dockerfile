# Use the node alpine image as the base image
FROM node:alpine

# Install necessary packages and enable corepack
RUN apk update && apk add --no-cache nodejs && corepack enable

# Set the working directory to /app
WORKDIR /app

# Copy only the package.json file initially for installing dependencies
COPY package.json .

# Install dependencies using pnpm
RUN pnpm install

# Copy all files from the host to the container's working directory
COPY . .

# Expose port 5173
EXPOSE 5173

# Command to run the application
CMD ["pnpm", "dev"]

# Stage 2: Build production image
FROM  node:alpine AS builder

RUN apk update && apk add --no-cache nodejs && corepack enable

WORKDIR /app

COPY package.json .
COPY pnpm-lock.yaml .

RUN pnpm install

COPY . .

RUN pnpm build

# Stage 3: Serve production image
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]