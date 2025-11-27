package com.project1.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project1.demo.entity.User;
import com.project1.demo.repository.UserRepo;


@Service
public class UserService {

    @Autowired
    private UserRepo userRepo;

    public User registerUser(User user) {
        return userRepo.save(user);
    }

    public User login(String email, String password) {
        User user = userRepo.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public User findByEmail(String email) {
        return userRepo.findByEmail(email);
    }

    public void updateUser(User user) {
        userRepo.save(user);
    }

	public void save(User user) {
		userRepo.save(user);
		// TODO Auto-generated method stub
		
	}
}
