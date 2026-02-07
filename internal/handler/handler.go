package handler

import "github.com/felipeRese/Nicti/internal/service"

type Handler struct {
	UserHandler UserHandler
	SpaceHandler SpaceHandler
}

func NewHandler(s *service.Service) *Handler{
	return &Handler{
		UserHandler: *NewUserHandler(s.UserService),
		SpaceHandler: *NewSpaceHandler(s.SpaceService),
	}
}


