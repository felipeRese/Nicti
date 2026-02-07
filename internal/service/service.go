package service

import "github.com/jackc/pgx/v5/pgxpool"

type Service struct {
	UserService UserService
	SpaceService SpaceService
}

func NewService(conn *pgxpool.Pool) *Service {
	return &Service{
		UserService: *NewUserService(conn),
		SpaceService: *NewSpaceService(conn),
	}

}
