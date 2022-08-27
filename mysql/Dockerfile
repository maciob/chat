FROM mysql:8.0.30 
ARG MYSQL_ROOT_PASSWORD
ENV MYSQL_ROOT_PASSWORD="pass"
WORKDIR app/
COPY entrypoint.sh entrypoint.sh
RUN chmod 755 entrypoint.sh
CMD ["service","mysqld", "start"]
CMD ["./entrypoint.sh"]
