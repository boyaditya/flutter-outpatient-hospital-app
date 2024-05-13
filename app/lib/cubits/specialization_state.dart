class SpecializationModel {
  final int id;
  final String title;
  final String description;
  final String imgName;

  SpecializationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imgName,
  });

  static SpecializationModel fromJson(Map<String, dynamic> item) {
    return SpecializationModel(
      id: item['id'],
      title: item['title'],
      description: item['description'],
      imgName: item['img_name'],
    );
  }
}