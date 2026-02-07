package dtos

type CreateUserDTO struct {
	Name string  `json:"name"`
	Email string `json:"email"`
}

type UserResponseDTO struct {
	ID int64
	Name string
	Email string
}
