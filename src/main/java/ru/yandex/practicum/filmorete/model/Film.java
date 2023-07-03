package ru.yandex.practicum.filmorete.model;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Positive;
import javax.validation.constraints.Size;
import java.time.LocalDate;

import static ru.yandex.practicum.filmorete.exeptions.MessageErrorValidFilm.VALID_ERROR_FILM_NOT_DESCRIPTION;

@Data
@Builder
public class Film {

    @Positive
    private Integer id;

    @NotBlank
    @NonNull
    private final String name;

    @NotBlank
    @NonNull
    @Size(max = 200)
    private final String description;

    @NonNull
    private final LocalDate releaseDate;

    @Positive
    private final Integer duration;
}