class Pokemon {
  final String name;
  final int id;
  final String url;
  final String type_1;
  final String? type_2;
  final String image;

  const Pokemon(
      {required this.name,
      required this.id,
      required this.url,
      required this.type_1,
      required this.type_2,
      required this.image});

  factory Pokemon.fromJson(Map<String, dynamic> data) {
    return Pokemon(
        name: data['name'],
        id: data['id'],
        url: data['url'],
        type_1: data['type_1'],
        type_2: data['type_2'],
        image: data['image']);
  }
}
