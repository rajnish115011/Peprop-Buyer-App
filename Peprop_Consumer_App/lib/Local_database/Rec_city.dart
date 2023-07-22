import 'dart:convert';

class Rec_city {

  final String city_name;


  Rec_city({
    required this.city_name,

  });

  // Convert a Breed into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'city_name': city_name,

    };
  }
  factory Rec_city.fromMap(Map<String, dynamic> map) {
    return Rec_city(
      city_name: map['city_name'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory Rec_city.fromJson(String source) => Rec_city.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() => 'Rec_city( city_name: $city_name)';
}

