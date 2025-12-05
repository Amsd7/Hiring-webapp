package com.project1.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project1.demo.entity.ClientProfile;
import com.project1.demo.entity.Job;

public interface JobRepo extends JpaRepository<Job,Integer> {

	List<Job> findByClient_Id(Long clientId);
	List<Job> findByClient(ClientProfile client);


}
