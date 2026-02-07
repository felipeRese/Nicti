package dtos

type CreateSpaceDTO struct {
	UserId   int64   `json:"user_id"`
	Nickname string  `json:"nickname"`
}

type SpaceResponseDTO struct {
	ID       int64  `json:"id"`
	Nickname string `json:"nickname"`
	UserId   int64  `json:"user_id"`
	Balance  string `json:"balance"`
}
