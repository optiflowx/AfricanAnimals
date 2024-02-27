class Animal {
  String? id;
  String? name;
  String? headline;
  String? description;
  String? link;
  String? image;
  List<String>? gallery;
  List<String>? fact;

  Animal(
      {this.id,
      this.name,
      this.headline,
      this.description,
      this.link,
      this.image,
      this.gallery,
      this.fact});

  Animal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    headline = json['headline'];
    description = json['description'];
    link = json['link'];
    image = json['image'];
    gallery = json['gallery'].cast<String>();
    fact = json['fact'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['headline'] = headline;
    data['description'] = description;
    data['link'] = link;
    data['image'] = image;
    data['gallery'] = gallery;
    data['fact'] = fact;
    return data;
  }
}
