FROM alpine as builder

RUN apk add --update nodejs npm


WORKDIR '/app'

COPY package.json .

RUN npm install 

COPY . . 

CMD ["npm", "run", "build"]

FROM nginx 
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html