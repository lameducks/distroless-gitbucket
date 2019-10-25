# distroless-gitbucket

Docker image for [GitBucket](https://gitbucket.github.io/) running on [gcr.io/distroless/java:11](https://gcr.io/distroless/java:11).

[![dockeri.co](https://dockeri.co/image/lameducks/distroless-gitbucket)](https://hub.docker.com/r/lameducks/distroless-gitbucket)

## How to use this image

### General usage

```sh
docker run -p 8080:8080 -v /var/lib/gitbucket:/var/lib/gitbucket -d lameducks/distroless-gitbucket
```

### Exposing external port

GitBucket listens on port 8080 (HTTP) and 29418 (SSH).

```sh
docker run -p 8080:8080 -p 29418:29418 lameducks/distroless-gitbucket
```

### Using volume

All GitBucket data except for databases other than the H2 database is stored in the GitBucket home directory (`/var/lib/gitbucket`).

```sh
docker run -v /var/lib/gitbucket:/var/lib/gitbucket lameducks/distroless-gitbucket
```

### Using external database

GitBucket uses an H2 database by default. When using an external database, specify the database URL and user / password in the environment variables.

```sh
docker run -e GITBUCKET_DB_URL=jdbc:postgresql://db/gitbucket \
           -e GITBUCKET_DB_USER=gitbucket \
           -e GITBUCKET_DB_PASSWORD=gitbucket \
           lameducks/distroless-gitbucket
```

### Complex configuration

If you want to change the Java VM options, you need to override the default CMD instruction.

```sh
docker run lameducks/distroless-gitbucket \
           -Xms1g -Xmx1g -XX:+UseConcMarkSweepGC \
           -Dgitbucket.maxFileSize=2147483647 \
           -jar /app/gitbucket.war \
           --temp_dir=/var/tmp/gitbucket
```
