FROM alpine:3

LABEL author=henry
LABEL purpose=exercises state=public

# when build
RUN mkdir hello
RUN echo "Hello world" > "hello/world.txt"

# when running
CMD cat "hello/world.txt"

