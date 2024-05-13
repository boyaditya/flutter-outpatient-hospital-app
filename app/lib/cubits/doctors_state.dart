class DoctorModel {
  final int id;
  final String name;
  final String imgName;
  final String interest;
  final String education;
  final int idSpecialization;

  DoctorModel({
    required this.id,
    required this.name,
    required this.imgName,
    required this.interest,
    required this.education,
    required this.idSpecialization,
  });

  static fromJson(item) {}
}
