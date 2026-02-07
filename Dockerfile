FROM golang

WORKDIR /app

RUN go install github.com/air-verse/air@latest

COPY go.* ./

RUN go mod download

COPY . .

RUN go build -o main ./cmd/main.go

EXPOSE 8080

CMD [ "air", "-c", ".air.toml" ]

