FROM nginx:alpine

COPY ./default.conf /etc/nginx/conf.d/default.conf

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
