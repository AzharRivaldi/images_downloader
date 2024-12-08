class ModelHome {
  String? previewURL;
  String? downloadURL;
  String? thumdUser;
  String? userName;
  String? typeImages;
  String? tagsImages;

  ModelHome({
    this.previewURL, this.downloadURL,
    this.thumdUser, this.userName,
    this.typeImages, this.tagsImages});

  ModelHome.fromJson(Map<String, dynamic> json) {
    previewURL = json['webformatURL'];
    downloadURL = json['largeImageURL'];
    thumdUser = json['userImageURL'];
    userName = json['user'];
    typeImages = json['type'];
    tagsImages = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['webformatURL'] = previewURL;
    data['largeImageURL'] = downloadURL;
    data['userImageURL'] = thumdUser;
    data['user'] = userName;
    data['type'] = typeImages;
    data['tags'] = tagsImages;
    return data;
  }

  static List<ModelHome> fromJsonList(List list) {
    if (list.isEmpty) return List<ModelHome>.empty();
    return list.map((item) => ModelHome.fromJson(item)).toList();
  }
}