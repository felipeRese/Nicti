package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/felipeRese/Nicti/internal/dtos"
	"github.com/felipeRese/Nicti/internal/service"
)

type UserHandler struct {
	UserService service.UserService
}
func NewUserHandler(UserService service.UserService) *UserHandler{
	return &UserHandler{
		UserService: UserService,
	}
}

func (h *UserHandler) CreateUser(w http.ResponseWriter, r *http.Request){
	defer r.Body.Close()

	var dto dtos.CreateUserDTO
	if err := json.NewDecoder(r.Body).Decode(&dto); err != nil {
		http.Error(w, "invalid JSON", http.StatusBadRequest)
		return
	}

	user, err := h.UserService.CreateUser(dto)
	if err != nil {
		http.Error(w, fmt.Sprintf("Error occurred while creating user: %s", err), http.StatusInternalServerError)
		return
	}

	resp := dtos.UserResponseDTO{
		ID: user.ID,
		Name: user.Name,
		Email: user.Email,
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	if err = json.NewEncoder(w).Encode(&resp); err != nil {
		http.Error(w, fmt.Sprintf("Error encoding response: %s", err), http.StatusInternalServerError)
		return
	}
}

func (h *UserHandler) GetUserById(w http.ResponseWriter, r *http.Request){
	defer r.Body.Close()
	idString := r.PathValue("id")
	id, err := strconv.Atoi(idString)
	if err != nil {
		http.Error(w, "Invalid id", http.StatusBadRequest)
		return
	}

	user, err := h.UserService.GetUserByID(int64(id))
	if err != nil {
		http.Error(w, "user not found", http.StatusNotFound)
		return
	}

	resp := dtos.UserResponseDTO{
		ID: user.ID,
		Name: user.Name,
		Email: user.Email,
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	if err = json.NewEncoder(w).Encode(&resp); err != nil {
		http.Error(w, fmt.Sprintf("Error encoding response: %s", err), http.StatusInternalServerError)
		return
	}
}
