class Dog {
  final String name;
  final String image_link;
  final int good_with_other_dogs;
  final int good_with_childrens;

  const Dog({
    required this.name,
    required this.image_link,
    required this.good_with_other_dogs,
    required this.good_with_childrens,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      name: json['name'],
      good_with_other_dogs: json['good_with_other_dogs'],
      image_link: json['image_link'],
      good_with_childrens: json['good_with_children'],
    );
  }
}