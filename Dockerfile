# Based images
FROM node:17-alpine as builder


# Run commands
USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node package.json .
RUN npm i
COPY --chown=node:node . .


# Default start command
CMD ["npm", "run", "build"]


FROM nginx:1.21.6-alpine
EXPOSE 80
COPY --from=builder /home/node/app/build /usr/share/nginx/html