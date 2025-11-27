package com.project1.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project1.demo.entity.User;

public interface UserRepo extends JpaRepository<User,Integer>{
	User findByEmail(String email);

	

}
