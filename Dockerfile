FROM nginx

ARG BACKEND_URL
ENV BACKEND_URL=$BACKEND_URL

COPY website/ /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
