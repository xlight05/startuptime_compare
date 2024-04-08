# Auto Generated Dockerfile
FROM ghcr.io/graalvm/native-image-community:17-ol8 as build

WORKDIR /app/build

COPY graalvm_service.jar .

RUN native-image -jar graalvm_service.jar -H:Name=graalvm_service --no-fallback -H:+StaticExecutableWithDynamicLibC

FROM gcr.io/distroless/base

WORKDIR /home/ballerina


COPY --from=build /app/build/graalvm_service .

CMD ["./graalvm_service"]

