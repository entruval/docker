FROM alpine:3

RUN mkdir dockerhello

# single
ADD text/world.txt dockerhello
ADD text/world1.txt dockerhello
# all
ADD text/*.txt dockerhello


CMD cat "hello/world.txt"

