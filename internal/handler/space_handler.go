package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"github.com/felipeRese/Nicti/internal/dtos"
	"github.com/felipeRese/Nicti/internal/service"
)

type SpaceHandler struct {
	SpaceService service.SpaceService
}
func NewSpaceHandler(SpaceService service.SpaceService) *SpaceHandler{
	return &SpaceHandler{
		SpaceService: SpaceService,
	}
}

func (h *SpaceHandler) CreateSpace(w http.ResponseWriter, r *http.Request){
	defer r.Body.Close()

	var dto dtos.CreateSpaceDTO
	if err := json.NewDecoder(r.Body).Decode(&dto); err != nil {
		http.Error(w, "invalid JSON", http.StatusBadRequest)
		return
	}

	space, err := h.SpaceService.CreateSpace(dto)
	if err != nil {
		http.Error(w, fmt.Sprintf("Error occurred while creating space: %s", err), http.StatusInternalServerError)
		return
	}

	resp := dtos.SpaceResponseDTO{
		ID: space.ID,
		Nickname: space.Nickname,
		UserId: space.UserId,
		Balance: space.Balance,
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)

	if err = json.NewEncoder(w).Encode(&resp); err != nil {
		http.Error(w, fmt.Sprintf("Error encoding response: %s", err), http.StatusInternalServerError)
		return
	}
}

func (h *SpaceHandler) ListSpacesByUserId(w http.ResponseWriter, r *http.Request){
	defer r.Body.Close()
	idString := r.PathValue("id")
	id, err := strconv.Atoi(idString)
	if err != nil {
		http.Error(w, "Invalid id", http.StatusBadRequest)
		return
	}

	spaces, err := h.SpaceService.ListSpacesByUserId(int64(id))
	if err != nil {
		http.Error(w, "user not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	if err = json.NewEncoder(w).Encode(spaces); err != nil {
		http.Error(w, fmt.Sprintf("Error encoding response: %s", err), http.StatusInternalServerError)
		return
	}
}
