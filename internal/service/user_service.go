package service

import (
	"context"

	"github.com/felipeRese/Nicti/internal/dtos"
	"github.com/felipeRese/Nicti/internal/repository"
	"github.com/jackc/pgx/v5/pgxpool"
)

type UserService struct {
	Conn *pgxpool.Pool
}

func NewUserService(Conn *pgxpool.Pool) *UserService {
	return &UserService{
		Conn: Conn,
	}
}

func (s *UserService) CreateUser(dto dtos.CreateUserDTO) (*dtos.UserResponseDTO, error){
	repo := repository.New(s.Conn)
	params := repository.CreateUserParams{
		Name: dto.Name,
		Email: dto.Email,
	}
	user, err := repo.CreateUser(context.Background(), params)
	if err != nil {
		return nil, err
	}

	return &dtos.UserResponseDTO{
		ID: user.ID,
		Name: user.Name,
		Email: user.Email,
	}, nil
}


func (s *UserService) GetUserByID(ID int64) (*dtos.UserResponseDTO, error){
	repo := repository.New(s.Conn)
	user, err := repo.GetUserById(context.Background(), ID)
	if err != nil {
		return nil, err
	}

	return &dtos.UserResponseDTO{
		ID: user.ID,
		Name: user.Name,
		Email: user.Email,
	}, nil
}
