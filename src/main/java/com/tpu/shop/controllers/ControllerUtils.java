package com.tpu.shop.controllers;

import com.tpu.shop.utils.ValidationMessage;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class ControllerUtils {
    static Map<String, String> getErrors(BindingResult bindingResult) {
        Collector<FieldError, ?, Map<String, String>> collector = Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        );
        return bindingResult.getFieldErrors().stream().collect(collector);
    }

    static boolean checkFile(
            @RequestParam("file") MultipartFile file,
            Model model,
            boolean isImage,
            List<String> types,
            long size) {
        String fileError = "";
        if (file.isEmpty()) {
            fileError = ValidationMessage.EMPTY_FIELD + "\n";
        }
        String type = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1).toLowerCase();
        if (!file.isEmpty() && !types.contains(type)) {
            if (isImage) {
                fileError += ValidationMessage.INVALID_IMAGE_FORMAT + "\n";
            } else {
                fileError += ValidationMessage.INVALID_FILE_FORMAT + "\n";
            }
        }

        if (file.getSize() > size) {
            if (isImage) {
                fileError += ValidationMessage.INVALID_IMAGE_SIZE;
            } else {
                fileError += ValidationMessage.INVALID_FILE_SIZE;
            }
        }

        boolean isFileError = !fileError.isEmpty();
        if (isFileError) {
            model.addAttribute("fileError", fileError);
        }

        return isFileError;
    }
}
