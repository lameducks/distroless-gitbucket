FROM alpine as build
ADD https://github.com/gitbucket/gitbucket/releases/latest/download/gitbucket.war /build/app/gitbucket.war
RUN mkdir -p /build/var/lib/gitbucket /build/var/tmp/gitbucket

FROM gcr.io/distroless/java:11
COPY --from=build /build /

EXPOSE 8080
EXPOSE 29418
VOLUME ["/var/lib/gitbucket"]

ENV GITBUCKET_HOME=/var/lib/gitbucket
ENTRYPOINT ["java"]
CMD ["-Dgitbucket.maxFileSize=2147483647", \
     "-jar", "/app/gitbucket.war", \
     "--temp_dir=/var/tmp/gitbucket"]
