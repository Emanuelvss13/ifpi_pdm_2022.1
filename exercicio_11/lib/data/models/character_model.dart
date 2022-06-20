import 'package:exercicio_11/domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel(
      {required int id,
      required String name,
      required String status,
      required String species,
      required String type,
      required String gender,
      required String image})
      : super(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            image: image);

  factory CharacterModel.fromJsonByName(Map<String, dynamic> json) {
    return CharacterModel(
        id: json['results'][0]['id'],
        name: json['results'][0]['name'],
        type: json['results'][0]['type'],
        status: json['results'][0]['status'],
        gender: json['results'][0]['gender'],
        species: json['results'][0]['species'],
        image: json['results'][0]['image']);
  }

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        status: json['status'],
        gender: json['gender'],
        species: json['species'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'gender': gender,
      'status': status,
      'species': species,
      'image': image
    };
  }
}
