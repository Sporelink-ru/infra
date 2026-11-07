FROM node:20-alpine AS build
WORKDIR /app
COPY panel/package*.json ./
RUN npm install
COPY panel/ .
RUN npm run build

FROM nginx:alpine
COPY infra/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80