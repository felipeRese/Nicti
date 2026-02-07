package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/felipeRese/Nicti/internal/handler"
	"github.com/felipeRese/Nicti/internal/middleware"
	"github.com/felipeRese/Nicti/internal/router"
	"github.com/felipeRese/Nicti/internal/service"
	"github.com/jackc/pgx/v5/pgxpool"
)

func main() {
	ctx := context.Background()

	// Example: DATABASE_URL="postgres://user:pass@localhost:5432/dbname"
	dsn, ok := os.LookupEnv("DATABASE_URL")
	if !ok || dsn == "" {
		log.Fatal("DATABASE_URL is not set")
	}

	// Create a pgx connection pool
	pool, err := pgxpool.New(ctx, dsn)
	if err != nil {
		log.Fatalf("failed to create pgx pool: %v", err)
	}
	defer pool.Close()

	Service := service.NewService(pool)
	Handler := handler.NewHandler(Service)

	Router := router.SetupRoutes(Handler)

	server := http.Server{
		Addr: ":8080",
		Handler: middleware.Logger(Router),
	}

	fmt.Println("Server listening on port 8080")
	server.ListenAndServe()
}
