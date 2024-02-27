class Location {
  String? id;
  String? name;
  String? image;
  double? latitude;
  double? longitude;

  Location(
      {this.id, this.name, this.image, this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
