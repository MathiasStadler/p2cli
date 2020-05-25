FROM golang AS build

RUN git clone http://github.com/mathiasstadler/p2cli  --branch r2 --single-branch 
RUN cd p2cli
RUN make

# RUN go get -u -v github.com/mathiasstadler/p2cli
# WORKDIR $GOPATH/src/github.com/mathiasstadler/p2cli
# RUN CGO_ENABLED=0 GOOS=linux go build -a --tags r2\
#     -ldflags "-extldflags '-static' -X main.Version=$(shell git describe --long --dirty)" \
#    -o /p2 .

FROM scratch
COPY --from=build /p2 /p2
ENTRYPOINT ["/p2"]
