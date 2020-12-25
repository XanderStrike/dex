FROM nginx:alpine
COPY compression.conf /etc/nginx/conf.d/compression.conf
COPY . /usr/share/nginx/html
