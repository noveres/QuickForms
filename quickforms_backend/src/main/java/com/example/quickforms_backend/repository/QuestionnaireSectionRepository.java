package com.example.quickforms_backend.repository;


import com.example.quickforms_backend.entity.QuestionnaireSection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionnaireSectionRepository extends JpaRepository<QuestionnaireSection, Long> {
}