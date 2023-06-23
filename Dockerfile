FROM golang:1.20 as builder

RUN mkdir -p /app
WORKDIR /app

COPY go.mod .

ENV GOPROXY https://proxy.golang.org,direct

RUN go mod download && go mod verify

COPY . .

ENV CGO_ENABLED=0

RUN GOOS=linux go build ./desafioImersao.go

FROM scratch

WORKDIR /app

COPY --from=builder /app .

CMD ["/app/desafioImersao"]