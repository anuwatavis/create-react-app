FROM alpine as builder

RUN apk add --update nodejs npm
RUN apt-get update -qq && apt-get install -y build-essential nodejs

WORKDIR '/app'

COPY package.json .

RUN npm install 

COPY . . 

CMD ["npm", "run", "build"]

FROM nginx 
EXPOSE 8080

COPY --from=builder /app/build /usr/share/nginx/html