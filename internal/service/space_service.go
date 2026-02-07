package service

import (
	"context"
	"errors"

	"github.com/felipeRese/Nicti/internal/dtos"
	"github.com/felipeRese/Nicti/internal/repository"
	"github.com/jackc/pgx/v5/pgxpool"
)

type SpaceService struct {
	Conn *pgxpool.Pool
}

func NewSpaceService(Conn *pgxpool.Pool) *SpaceService {
	return &SpaceService{
		Conn: Conn,
	}
}

func (s *SpaceService) CreateSpace(dto dtos.CreateSpaceDTO) (*dtos.SpaceResponseDTO, error){
	repo := repository.New(s.Conn)
	params := repository.CreateSpaceParams{
		UserID: dto.UserId,
		Nickname: dto.Nickname,
	}
	space, err := repo.CreateSpace(context.Background(), params)
	if err != nil {
		return nil, err
	}

	return &dtos.SpaceResponseDTO{
		ID: space.ID,
		Nickname: space.Nickname,
		UserId: space.UserID,
		Balance: space.Balance,
	}, nil
}


func (s *SpaceService) ListSpacesByUserId(ID int64) (*[]dtos.SpaceResponseDTO, error){
	repo := repository.New(s.Conn)
	spaces, err := repo.ListSpacesByUserId(context.Background(), ID)
	if err != nil {
		return nil, err
	}
	if len(spaces) < 1 {
		return nil, errors.New("Space not found")
	}

	spacesDTO := make([]dtos.SpaceResponseDTO, len(spaces))
	for i := range len(spaces) {
		spacesDTO[i] = dtos.SpaceResponseDTO{
			ID: spaces[i].ID,
			Nickname: spaces[i].Nickname,
			UserId: spaces[i].UserID,
			Balance: spaces[i].Balance,
		}
	}
	return &spacesDTO, nil;

}
