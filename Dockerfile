FROM golang AS build

RUN cd / && git clone http://github.com/mathiasstadler/p2cli  --tags r2 --single-branch && cd r2 && git branch && make -d && ls -l && pwd

# RUN go get -u -v github.com/mathiasstadler/p2cli
# WORKDIR $GOPATH/src/github.com/mathiasstadler/p2cli
# RUN CGO_ENABLED=0 GOOS=linux go build -a --tags r2\
#     -ldflags "-extldflags '-static' -X main.Version=$(shell git describe --long --dirty)" \
#    -o /p2 .

FROM scratch
COPY --from=build /r2/p2 /p2
COPY tests/data.p2 /data.p2
ENTRYPOINT ["/p2"]
