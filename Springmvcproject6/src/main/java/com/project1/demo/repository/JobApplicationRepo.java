package com.project1.demo.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.project1.demo.entity.CandidateProfile;
import com.project1.demo.entity.Job;
import com.project1.demo.entity.JobApplication;

public interface JobApplicationRepo extends JpaRepository<JobApplication, Integer> {
    List<JobApplication> findByCandidateId(Long candidateId);
    List<JobApplication> findByCandidate(CandidateProfile candidate);
    boolean existsByCandidateAndJob(CandidateProfile candidate, Job job);
	List<JobApplication> findByJob(Job job);
	List<JobApplication> findByJobId(int jobId);

}
