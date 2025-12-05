package com.project1.demo.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project1.demo.entity.CandidateProfile;
import com.project1.demo.entity.User;

public interface CandidateRepo extends JpaRepository<CandidateProfile,Integer> {

	CandidateProfile findByUserId(int userId);

	CandidateProfile findByUser(User user);

	

}
