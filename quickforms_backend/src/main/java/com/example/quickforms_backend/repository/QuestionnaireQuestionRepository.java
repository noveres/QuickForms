package com.example.quickforms_backend.repository;


import com.example.quickforms_backend.entity.QuestionnaireQuestion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionnaireQuestionRepository extends JpaRepository<QuestionnaireQuestion, Long> {
}