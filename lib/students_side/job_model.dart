class Job {
  final int? id;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String duration;
  final String description;
  final String? type;
  final String? image;

  Job({
    this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.duration,
    required this.description,
    this.type,
    this.image,
  });

  // 🔄 Map → Object
  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'],
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      salary: map['salary'] ?? '',
      duration: map['duration'] ?? '',
      type: map['type'] ?? 'Part Time', // 🔥 FIX
      description: map['description'] ?? 'No description', // 🔥 FIX
    );
  }

  // 🔄 Object → Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'salary': salary,
      'duration': duration,
      'description': description,
      'type': type,
      'image': image,
    };
  }
}