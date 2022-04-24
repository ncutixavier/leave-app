class Department {
  final String sId;
  final String departmentName;
  final String supervisorName;
  final String supervisorEmail;

  const Department({
    required this.sId,
    required this.departmentName,
    required this.supervisorName,
    required this.supervisorEmail,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      sId: json['_id'],
      departmentName: json['name'],
      supervisorName: json['supervisor_name'],
      supervisorEmail: json['supervisor_email'],
    );
  }
}
