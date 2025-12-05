package com.project1.demo;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itextpdf.text.Document;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.project1.demo.entity.CandidateProfile;
import com.project1.demo.entity.ClientProfile;
import com.project1.demo.entity.Job;
import com.project1.demo.entity.JobApplication;
import com.project1.demo.entity.User;
import com.project1.demo.repository.CandidateRepo;
import com.project1.demo.repository.ClientRepo;
import com.project1.demo.repository.JobApplicationRepo;
import com.project1.demo.repository.JobRepo;
import com.project1.demo.repository.UserRepo;
import com.project1.demo.service.CandidateService;
import com.project1.demo.service.ClientService;
import com.project1.demo.service.EmailService;
import com.project1.demo.service.JobApplicationService;
import com.project1.demo.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
//@RequestMapping("/user")
public class HiringController {
	@Autowired 
	private UserService userservice;
	@Autowired
	private CandidateService candidateservice;
	@Autowired
	private ClientService clientservice;
	@Autowired
	private JobApplicationService jobapplicationservice;
	@Autowired
	private EmailService emailservice;
	@Autowired
	private UserRepo userrepo;
	@Autowired
	private CandidateRepo candidaterepo;
	@Autowired
	private JobApplicationRepo jobapplicationrepo;
	@Autowired
	private ClientRepo clientrepo;
	@Autowired
	private JobRepo jobrepo;
	
	
	@GetMapping("/welcomepage")
	public String home() {
		return "welcomepage";
	}
	
	@GetMapping("/register")
	public String showRegisterForm(Model model) {
		model.addAttribute("user",new User());
		return "register";
	}
	
	@PostMapping("/save")
	public String saveUser(@ModelAttribute("user") User user, Model model) {
	    // Check if email already exists
	    if (userrepo.findByEmail(user.getEmail()) != null) {
	        model.addAttribute("error", "Email already exists!");
	        model.addAttribute("user", user);
	        return "register";
	    }

	    // Save the user first
	    userservice.save(user);

	    // Create corresponding profile based on role
	    if ("candidate".equalsIgnoreCase(user.getRole())) {
	        CandidateProfile candidateProfile = new CandidateProfile();
	        candidateProfile.setUser(user);
	        candidateservice.saveProfile(candidateProfile);
	    } 
	    else if ("client".equalsIgnoreCase(user.getRole())) {
	        ClientProfile clientProfile = new ClientProfile();
	        clientProfile.setUser(user);
	        clientservice.saveProfile(clientProfile);
	    }

	    return "registeredsuccessful";
	}
	
	  // Show candidate login page
    @GetMapping("/candidate")
    public String showLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "candidatelogin"; 
    }

    //  Handle login submission
    @PostMapping("/candidate")
    public String loginUser(@RequestParam("email") String email,
                            @RequestParam("password") String password,
                            HttpSession session,
                            Model model) {

        User user = userrepo.findByEmail(email);

        // validate user
        if (user == null || !user.getPassword().equals(password)) {
            model.addAttribute("error", "Invalid email or password!");
            return "candidatelogin";
        }

        // check role
        if (!user.getRole().equalsIgnoreCase("candidate")) {
            model.addAttribute("error", "Access denied! Only candidates can log in.");
            return "candidatelogin";
        }

        // store logged-in user in session
        session.setAttribute("currentUser", user);

        return "redirect:/candidate/home";
    }

    @GetMapping("/candidate/home")
    public String candidateDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            return "redirect:/candidate";
        }

        CandidateProfile profile = candidaterepo.findByUser(user);
        List<JobApplication> applications = jobapplicationrepo.findByCandidate(profile);

        model.addAttribute("user", user);
        model.addAttribute("profile", profile);
        model.addAttribute("applications", applications);

        return "candidate"; 
    }
    @PostMapping("/candidate/updateProfile")
    public String updateProfile(@ModelAttribute CandidateProfile profile,
                                @RequestParam("resumeFile") MultipartFile file,
                                HttpSession session) throws Exception {

        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/candidate";
        }

        // Fetch existing profile
        CandidateProfile existingProfile = candidaterepo.findByUser(user);
        if (existingProfile == null) {
            existingProfile = new CandidateProfile();
            existingProfile.setUser(user);
        }

        // Update fields
        existingProfile.setName(profile.getName());
        existingProfile.setEmail(profile.getEmail());
        existingProfile.setHighestQualification(profile.getHighestQualification());
        existingProfile.setPassingYear(profile.getPassingYear());
        existingProfile.setSkills(profile.getSkills());
        existingProfile.setExperience(profile.getExperience());

        // Handle file upload
        if (!file.isEmpty()) {
            String uploadDir = "uploads";
            Files.createDirectories(Paths.get(uploadDir));
            String fileName = file.getOriginalFilename();
            Path path = Paths.get(uploadDir, fileName);
            Files.write(path, file.getBytes());
            existingProfile.setResume(fileName);
        }
        File dir = new File("uploads");
        if (!dir.exists()) {
            dir.mkdirs();
        }


        candidaterepo.save(existingProfile);

        return "redirect:/candidate/home";
    }
    
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); 
        return "redirect:/welcomepage";
    }
    
 // Show client login page
    @GetMapping("/employeer")
    public String showClientLoginPage(Model model) {
        model.addAttribute("user", new User());
        return "employeerlogin"; 
    }

    // Handle client login submission
    @PostMapping("/employeer")
    public String loginClient(@RequestParam("email") String email,
                              @RequestParam("password") String password,
                              HttpSession session,
                              Model model) {

        User user = userrepo.findByEmail(email);

        // Validate user
        if (user == null || !user.getPassword().equals(password)) {
            model.addAttribute("error", "Invalid email or password!");
            return "employeerlogin";
        }

        // Check role
        if (!user.getRole().equalsIgnoreCase("client")) {
            model.addAttribute("error", "Access denied! Only clients can log in.");
            return "employeerlogin";
        }

        // Store logged-in user in session
        session.setAttribute("currentUser", user);

        // Redirect to client dashboard
        return "redirect:/employeer/home";
    }
    
    @GetMapping("/employeer/home")
    public String clientHome(HttpSession session, Model model) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/employeerlogin";
        }

        ClientProfile profile = clientrepo.findByUser(user);
        if (profile == null) {
            profile = new ClientProfile();
            profile.setUser(user);
            clientrepo.save(profile);
        }
        List<Job> jobs = jobrepo.findByClient(profile);

        model.addAttribute("profile", profile);
        model.addAttribute("jobs", jobs);


        return "employeer";  
    }

    @PostMapping("/employeer/updateProfile")
    public String updateClientProfile(@ModelAttribute ClientProfile profile, HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/employeerlogin";
        }

        ClientProfile existingProfile = clientrepo.findByUser(user);
        if (existingProfile == null) {
            existingProfile = new ClientProfile();
            existingProfile.setUser(user);
        }

        existingProfile.setCompanyname(profile.getCompanyname());
        existingProfile.setCompanyaddress(profile.getCompanyaddress());
        existingProfile.setContactnumber(profile.getContactnumber());

        clientrepo.save(existingProfile);

        return "redirect:/employeer/home";
    }


    @PostMapping("/employeer/postJob")
    public String postJob(@RequestParam String jobTitle,
                          @RequestParam String jobDescription,
                          @RequestParam String requiredSkills,
                          @RequestParam String jobLocation, 
                          @RequestParam String salary,
                          HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        ClientProfile client = clientrepo.findByUserId(user.getId());

        Job job = new Job();
        job.setJobTitle(jobTitle);
        job.setJobDescription(jobDescription);
        job.setRequiredSkills(requiredSkills);
        job.setJobLocation(jobLocation);
        job.setSalary(salary);
        job.setClient(client);
        jobrepo.save(job);

        return "redirect:/employeer/home";
    }
    
 // Show Apply Job Page
    @GetMapping("/candidate/applyJob")
    public String showApplyJobPage(Model model) {
        model.addAttribute("jobs", jobrepo.findAll());
        return "applyjobs";
    }

    // Handle Job Application Submission
    @PostMapping("/candidate/applyJob")
    public String applyJob(@RequestParam("jobId") int jobId, HttpSession session, Model model) {
        User user = (User) session.getAttribute("currentUser");

        // Ensure user is logged in
        if (user == null) {
            return "redirect:/candidate";
        }

        CandidateProfile candidate = candidaterepo.findByUser(user);
        Job job = jobrepo.findById(jobId).orElse(null);

        if (job == null) {
            model.addAttribute("error", "Invalid job selection.");
            model.addAttribute("jobs", jobrepo.findAll());
            return "applyjobs";
        }

        // Check if already applied
        List<JobApplication> existingApplications = jobapplicationrepo.findByCandidate(candidate);
        boolean alreadyApplied = existingApplications.stream()
                .anyMatch(app -> app.getJob().getId() == jobId);
        if (alreadyApplied) {
            model.addAttribute("error", "You have already applied for this job.");
            model.addAttribute("jobs", jobrepo.findAll());
            return "applyjobs";
        }

        // Save new application
        JobApplication application = new JobApplication();
        application.setCandidate(candidate);
        application.setJob(job);
        application.setStatus("Applied");
        jobapplicationrepo.save(application);

        //  Keep message in same page
        model.addAttribute("success", "Successfully applied for the job: " + job.getJobTitle());
        model.addAttribute("jobs", jobrepo.findAll());
        return "applyjobs"; 
    }
    
    @GetMapping("/employeer/viewApplicants/{jobId}")
    public String viewApplicants(@PathVariable("jobId") int jobId, Model model, HttpSession session) {
        User user = (User) session.getAttribute("currentUser");

        // If client not logged in
        if (user == null || !"client".equalsIgnoreCase(user.getRole())) {
            return "redirect:/employeer";
        }

        // Get job and applicants
        Job job = jobrepo.findById(jobId).orElse(null);
        if (job == null) {
            model.addAttribute("error", "Job not found!");
            return "redirect:/employeer/home";
        }

        List<JobApplication> applications = jobapplicationrepo.findByJob(job);

        model.addAttribute("job", job);
        model.addAttribute("applications", applications);
        return "viewapplicants"; 
    }
    @GetMapping("/employeer/select/{applicationId}")
    public String showInterviewForm(@PathVariable Long applicationId, Model model) {
        model.addAttribute("applicationId", applicationId);
        return "interviewform"; 
    }
    @PostMapping("/employeer/select")
    public String sendInterviewMail(
            @RequestParam int applicationId,
            @RequestParam String company,
            @RequestParam String location,
            @RequestParam String details,
            @RequestParam String interviewDate,
            @RequestParam String interviewTime) {

        JobApplication app = jobapplicationservice.getById(applicationId);
        CandidateProfile candidate = app.getCandidate();
        
        app.setInterviewDate(interviewDate);
        app.setInterviewTime(interviewTime);
        app.setInterviewLocation(location);
        app.setStatus("Selected for Interview");
        jobapplicationservice.save(app);

        //  Send Email
        String subject = "Interview Invitation from " + company;

        String message = "Hello " + candidate.getName() + ",\n\n"
                + "You have been shortlisted for an interview.\n\n"
                + "Company: " + company + "\n"
                + "Location: " + location + "\n"
                + "Date: " + interviewDate + "\n"
                + "Time: " + interviewTime + "\n\n"
                + "Details:\n" + details + "\n\n"
                + "Best Wishes,\n"
                + company;

        emailservice.sendEmail(candidate.getEmail(), subject, message);

        //  Update Status


        return "redirect:/employeer/viewApplicants/" + app.getJob().getId();
    }
    
    @PostMapping("/updateApplicationStatus")
    public String updateApplicationStatus(
            @RequestParam int applicationId,
            @RequestParam String status,
            @RequestParam(value = "offerLetter", required = false) MultipartFile file
    ) throws Exception {

        JobApplication application = jobapplicationservice.getById(applicationId);
        application.setStatus(status);

        // Upload offer letter only if hired
        if (status.equalsIgnoreCase("Hired") && file != null && !file.isEmpty()) {

            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            Path uploadPath = Paths.get("uploads/offerletters/");
            Files.createDirectories(uploadPath);

            Path filePath = uploadPath.resolve(fileName);
            Files.write(filePath, file.getBytes());

            application.setOfferLetter("/uploads/offerletters/" + fileName);
        }

        jobapplicationservice.save(application);

        return "redirect:/employeer/viewapplicants";
    }
    
    @GetMapping("/employeer/offer-form/{id}")
    public String showOfferForm(@PathVariable int id, Model model) {

        JobApplication app = jobapplicationrepo.findById(id).orElse(null);

        if (app == null) {
            return "redirect:/error";
        }

        String candidateName = app.getCandidate().getName();
        String jobTitle = app.getJob().getJobTitle();
        String companyName = app.getJob().getClient().getCompanyname();
        String companyAddress = app.getJob().getClient().getCompanyaddress();

        model.addAttribute("app", app);
        model.addAttribute("candidateName", candidateName);
        model.addAttribute("jobTitle", jobTitle);
        model.addAttribute("companyName", companyName);
        model.addAttribute("companyAddress", companyAddress);

        return "offerletter";   
    }

    
    @PostMapping("/employeer/generate-offer/{id}")
    public String generateOfferLetter(
            @PathVariable int id,
            @RequestParam String candidateName,
            @RequestParam String jobTitle,
            @RequestParam String joiningDate,
            @RequestParam String salary,
            @RequestParam String hrName,
            @RequestParam String hrContact,
            RedirectAttributes redirect
    ) {

        JobApplication app = jobapplicationrepo.findById(id).orElse(null);

        if (app == null) {
            redirect.addFlashAttribute("errorMsg", "Application not found!");
            return "redirect:/employeer/viewApplicants";
        }

        String issueDate = LocalDate.now().toString();
        String companyName = app.getJob().getClient().getCompanyname();
        String companyAddress = app.getJob().getClient().getCompanyaddress();

        String content = """
                [Company Logo]

                %s
                %s

                Date: %s

                To,
                %s

                Subject: Offer of Employment – %s

                Dear %s,

                We are pleased to offer you the position of %s at %s based on your performance in the interview.

                Your joining date will be %s. You will be compensated with a salary of %s per month/year.

                Please report to the reporting manager on the joining day for completion of onboarding formalities.

                We look forward to having you as part of our team. Please sign and return a copy of this letter as a token of your acceptance.

                Warm Regards,
                %s
                HR Department
                %s
                Contact: %s
                """.formatted(
                companyName,
                companyAddress,
                issueDate,
                candidateName,
                jobTitle,
                candidateName,
                jobTitle,
                companyName,
                joiningDate,
                salary,
                hrName,
                companyName,
                hrContact
        );

        String folder = "uploads/offerletters/";
        new File(folder).mkdirs();

        String fileName = "OfferLetter_" + id + ".pdf";
        String filePath = folder + fileName;


        try {
        	Document pdfDoc = new Document();
        	PdfWriter.getInstance(pdfDoc, new FileOutputStream(filePath));
        	pdfDoc.open();
        	pdfDoc.add(new Paragraph(content));
        	pdfDoc.close();

            
            app.setOfferLetter(fileName);
            app.setStatus("Hired");
            jobapplicationrepo.save(app);

            redirect.addFlashAttribute("successMsg", "Offer letter created successfully!");

        } catch (Exception e) {
            redirect.addFlashAttribute("errorMsg", "Error generating offer letter!");
            e.printStackTrace();
        }

        return "redirect:/employeer/viewApplicants/" + app.getJob().getId();
    }
    
    @GetMapping("/employeer/download-offer/{id}")
    public ResponseEntity<byte[]> downloadOfferLetter(@PathVariable int id) throws Exception {

        JobApplication app = jobapplicationrepo.findById(id).orElse(null);

        if (app == null || app.getOfferLetter() == null) {
            return ResponseEntity.notFound().build();
        }

        String folder = "uploads/offerletters/";
        String filePath = folder + app.getOfferLetter();

        Path pdfPath = Paths.get(filePath);

        if (!Files.exists(pdfPath)) {
            return ResponseEntity.notFound().build();
        }

        byte[] pdfBytes = Files.readAllBytes(pdfPath);

        return ResponseEntity.ok()
                .header("Content-Disposition", "attachment; filename=" + app.getOfferLetter())
                .header("Content-Type", "application/pdf")
                .body(pdfBytes);
    }





}





