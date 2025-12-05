package com.project1.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project1.demo.entity.CandidateProfile;
import com.project1.demo.entity.JobApplication;
import com.project1.demo.repository.CandidateRepo;
import com.project1.demo.repository.JobApplicationRepo;

import java.util.ArrayList;
import java.util.List;


@Service
public class CandidateService {

    @Autowired
    private CandidateRepo candidateProfileRepo;

    @Autowired
    private JobApplicationRepo jobApplicationRepo;

    public CandidateProfile saveProfile(CandidateProfile profile) {
        return candidateProfileRepo.save(profile);
    }

    public CandidateProfile getProfileByUserId(int userId) {
        return candidateProfileRepo.findByUserId(userId);
    }

    public List<JobApplication> getAppliedJobs(int candidateId) {
        CandidateProfile candidate = candidateProfileRepo.findById(candidateId).orElse(null);

        if (candidate == null) {
            return new ArrayList<>(); // or throw an exception
        }

        return jobApplicationRepo.findByCandidate(candidate);
    }

	
}

