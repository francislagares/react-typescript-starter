FROM node:alpine

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn set version stable
RUN yarn install

# COPY
COPY . .

RUN yarn install

EXPOSE 5173

CMD ["yarn", "dev"]