package router

import (
	"net/http"

	"github.com/felipeRese/Nicti/internal/handler"
)

func SetupRoutes(h *handler.Handler) *http.ServeMux{
	router := http.NewServeMux()

	router.HandleFunc("GET /user/{id}", h.UserHandler.GetUserById)
	router.HandleFunc("POST /user", h.UserHandler.CreateUser)

	router.HandleFunc("POST /space", h.SpaceHandler.CreateSpace)
	router.HandleFunc("GET /space/{id}", h.SpaceHandler.ListSpacesByUserId)

	return router 
}

