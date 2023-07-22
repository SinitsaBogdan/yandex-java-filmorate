package ru.yandex.practicum.filmorete.exeptions;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ErrorHandler {

    @ExceptionHandler(ExceptionValidationFilm.class)
    public ResponseEntity<ErrorResponse> handleException(ExceptionValidationFilm exception) {
        ErrorResponse response = new ErrorResponse(exception.getName(), exception.getDescription());
        return new ResponseEntity<>(response, HttpStatus.valueOf(exception.getHttpStatusCode()));
    }

    @ExceptionHandler(ExceptionValidationUser.class)
    public ResponseEntity<ErrorResponse> handleException(ExceptionValidationUser exception) {
        ErrorResponse response = new ErrorResponse(exception.getName(), exception.getDescription());
        return new ResponseEntity<>(response, HttpStatus.valueOf(exception.getHttpStatusCode()));
    }

    @ExceptionHandler(ExceptionNotFoundUserStorage.class)
    public ResponseEntity<ErrorResponse> handleException(ExceptionNotFoundUserStorage exception) {
        ErrorResponse response = new ErrorResponse(exception.getName(), exception.getDescription());
        return new ResponseEntity<>(response, HttpStatus.valueOf(exception.getHttpStatusCode()));
    }

    @ExceptionHandler(ExceptionNotFoundFilmStorage.class)
    public ResponseEntity<ErrorResponse> handleException(ExceptionNotFoundFilmStorage exception) {
        ErrorResponse response = new ErrorResponse(exception.getName(), exception.getDescription());
        return new ResponseEntity<>(response, HttpStatus.valueOf(exception.getHttpStatusCode()));
    }
}