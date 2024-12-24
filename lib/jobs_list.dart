enum WorkType { onSite, remote, hybrid }

enum JobType { Internship, Freshers, Experienced }

class Job {
  String title;
  String location;
  String company;
  WorkType work;
  JobType type;
  int? minPay;
  int? maxPay;
  int minYearsOfExperience;
  int maxYearsOfExperience;
  String description;

  Job({
    required this.title,
    required this.location,
    required this.company,
    required this.work,
    required this.type,
    this.minPay,
    this.maxPay,
    required this.minYearsOfExperience,
    required this.maxYearsOfExperience,
    required this.description,
  });

  @override
  String toString() {
    return 'Job: $title, Location: $location, WorkType: ${work.toString().split('.').last}, Pay: ${minPay != null ? '₹${minPay!.toStringAsFixed(2)}' : 'Not disclosed'}';
  }
}

class Internship extends Job {
  int duration; // Duration in months

  Internship({
    required String title,
    required String location,
    required String company,
    required WorkType work,
    required JobType type,
    int? minPay,
    int? maxPay,
    required int minYearsOfExperience,
    required int maxYearsOfExperience,
    required this.duration,
    required String description,
  }) : super(
          title: title,
          location: location,
          company: company,
          work: work,
          type: type,
          minPay: minPay,
          maxPay: maxPay,
          minYearsOfExperience: minYearsOfExperience,
          maxYearsOfExperience: maxYearsOfExperience,
          description: description,
        );

  @override
  String toString() {
    return 'Internship: $title, Duration: $duration months, Location: $location, Work: ${work.toString().split('.').last}, Pay: ${minPay != null ? '₹${minPay!.toStringAsFixed(2)}' : 'Not disclosed'}';
  }
}

// Jobs List
class JobsList {
  List<Job> _jobs = [];

  // Add a new job
  void addJob(Job job) {
    _jobs.add(job);
  }

  // Get all jobs
  List<Job> get jobs => _jobs;

  List<Job> filterJobs(List<bool> isSelected) {
    List<JobType> selectedTypes = [];
    if (isSelected[0]) selectedTypes.add(JobType.Internship);
    if (isSelected[1]) selectedTypes.add(JobType.Freshers);
    if (isSelected[2]) selectedTypes.add(JobType.Experienced);

    return _jobs.where((job) => selectedTypes.contains(job.type)).toList();
  }
}

// For Testing
// void main() {
//   JobsList jobsList = JobsList();

//   jobsList.addJob(Job(
//     title: 'Software Engineer',
//     location: 'Mumbai',
//     company: 'Hiremi',
//     type: JobType.Freshers,
//     work: WorkType.onSite,
//     minPay: 1200000,
//     maxPay: 2000000,
//     minYearsOfExperience: 2,
//     maxYearsOfExperience: 5,
//     description:
//         ' As a Software Engineer at Hiremi, you will be responsible for developing, testing, and maintaining software applications. You will collaborate with cross-functional teams to design scalable systems, optimize code performance, and ensure the delivery of high-quality products. This role requires proficiency in programming languages such as Java, Python, or C++, and the ability to work in an agile environment.',
//   ));

//   jobsList.addJob(Job(
//     title: 'Senior Developer',
//     location: 'Delhi',
//     company: 'Hiremi',
//     type: JobType.Experienced,
//     work: WorkType.remote,
//     minPay: 6500000,
//     maxPay: 8500000,
//     minYearsOfExperience: 5,
//     maxYearsOfExperience: 10,
//     description:
//         'As a Senior Developer, you will lead the development of complex software solutions at Hiremi. You will work closely with product managers and architects to create scalable, reliable, and secure applications. Your responsibilities will include mentoring junior developers, reviewing code, and improving the development process. Strong experience in web development frameworks, cloud technologies, and database management is required.',
//   ));

//   jobsList.addJob(Internship(
//     title: 'Flutter Intern',
//     location: 'Bangalore',
//     company: 'CRTD Technologies',
//     type: JobType.Internship,
//     work: WorkType.hybrid,
//     minPay: 15000,
//     maxPay: 15000,
//     minYearsOfExperience: 0,
//     maxYearsOfExperience: 1,
//     duration: 6,
//     description:
//         'Join CRTD Technologies as a Flutter Intern and gain hands-on experience in building mobile applications using the Flutter framework. You will assist in developing, testing, and maintaining cross-platform mobile apps, and work closely with the development team to deliver high-quality user experiences. Ideal candidates should have a basic understanding of Flutter and Dart, with a strong eagerness to learn and grow in mobile app development',
//   ));
// }
