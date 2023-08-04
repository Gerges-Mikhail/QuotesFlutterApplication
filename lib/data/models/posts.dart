class PostsModel {
  late String name;
  late String language;
  late String id;
  late String createdAt;

  PostsModel({
    required this.name,
    required this.id,
    required this.language,
    required this.createdAt,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'language': language,
      'id': id,
      'createdAt': createdAt,
   };
  }
}
