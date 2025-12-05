package com.project1.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project1.demo.entity.JobApplication;
import com.project1.demo.repository.JobApplicationRepo;

@Service
public class JobApplicationService {
	@Autowired
	private JobApplicationRepo repo;

	    public List<JobApplication> getApplicantsByJobId(int jobId) {
	        return repo.findByJobId(jobId);
	    }

	    public JobApplication getById(int id) {
	        return repo.findById(id).orElse(null);
	    }

	    public JobApplication save(JobApplication application) {
	        return repo.save(application);
	    }
	}


