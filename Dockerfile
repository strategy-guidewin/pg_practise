FROM postgres:17-alpine

ENV POSTGRES_DB=interview_lab
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres

COPY init/ /docker-entrypoint-initdb.d/

EXPOSE 5432
