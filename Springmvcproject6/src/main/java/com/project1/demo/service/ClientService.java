package com.project1.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project1.demo.entity.ClientProfile;
import com.project1.demo.entity.Job;
import com.project1.demo.repository.ClientRepo;
import com.project1.demo.repository.JobRepo;

import java.util.List;

@Service
public class ClientService {

    @Autowired
    private ClientRepo clientProfileRepo;

    @Autowired
    private JobRepo jobRepo;

    public ClientProfile saveProfile(ClientProfile profile) {
        return clientProfileRepo.save(profile);
    }

    public ClientProfile getProfileByUserId(int userId) {
        return clientProfileRepo.findByUserId(userId);
    }

    public Job postJob(Job job) {
        return jobRepo.save(job);
    }

    public List<Job> getJobsByClient(Long clientId) {
        return jobRepo.findByClient_Id(clientId);
    }
}

