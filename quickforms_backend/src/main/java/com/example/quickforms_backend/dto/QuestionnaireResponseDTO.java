package com.example.quickforms_backend.dto;

import lombok.Data;
import java.util.Map;
import java.util.List;

@Data
public class QuestionnaireResponseDTO {
    private List<Map<String, Object>> answers;
    private String userAgent;
}
