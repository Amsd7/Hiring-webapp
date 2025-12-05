package com.project1.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project1.demo.entity.ClientProfile;
import com.project1.demo.entity.User;

public interface ClientRepo extends JpaRepository<ClientProfile,Integer> {

	ClientProfile findByUserId(int i);

	ClientProfile findByUser(User user);

}
