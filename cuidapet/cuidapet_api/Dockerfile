# Use latest stable channel SDK.
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
COPY .env ./
COPY docker-entrypoint.sh ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/.env /
COPY --from=build /app/bin/server /app/bin/
COPY --from=build /app/docker-entrypoint.sh /

ENV DATABASE_HOST=$DATABASE_HOST
ENV DATABASE_USER=$DATABASE_USER
ENV DATABASE_PORT=$DATABASE_PORT
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD
ENV DATABASE_NAME=$DATABASE_NAME
ENV JWT_SECRET=$JWT_SECRET
ENV FIREBASE_PUSH_KEY=$FIREBASE_PUSH_KEY
ENV REFRESH_TOKEN_EXPIRE_DAYS=$REFRESH_TOKEN_EXPIRE_DAYS
ENV REFRESH_TOKEN_NOT_BEFORE_HOURS=$REFRESH_TOKEN_NOT_BEFORE_HOURS
ENV JWT_EXPIRE=$JWT_EXPIRE

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
