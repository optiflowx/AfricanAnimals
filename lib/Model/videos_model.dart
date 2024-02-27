class Video {
  String? video;
  String? name;
  String? headline;
  String? thumbnail;

  Video({this.video, this.name, this.headline, this.thumbnail});

  Video.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    name = json['name'];
    headline = json['headline'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['video'] = video;
    data['name'] = name;
    data['headline'] = headline;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
