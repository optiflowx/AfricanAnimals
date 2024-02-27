import 'dart:convert';

import 'package:africa/Model/animal_model.dart';
import 'package:africa/Model/cover_model.dart';
import 'package:africa/Model/videos_model.dart';
import 'package:flutter/services.dart';

class Bundle {
  Bundle._();

  //CoverImage;
  static Future<List<CoverImage>>? coverImages() async {
    //Collect the local json data from the file.
    final jsonData = await rootBundle.loadString('lib/Data/covers.json');

    //Creating a dynamic list of the data in the json file.
    final list = jsonDecode(jsonData) as List;

    return list.map((cover) => CoverImage.fromJson(cover)).toList();
  }

  //Animal
  static Future<List<Animal>>? animalList() async {
    //Collect the local json data from the file.
    final jsonData = await rootBundle.loadString('lib/Data/animals.json');

    //Creating a dynamic list of the data in the json file.
    final list = jsonDecode(jsonData) as List;

    return list.map((animal) => Animal.fromJson(animal)).toList();
  }

  //Animal
  static Future<List<Video>>? videosList() async {
    //Collect the local json data from the file.
    final jsonData = await rootBundle.loadString('lib/Data/videos.json');

    //Creating a dynamic list of the data in the json file.
    final list = jsonDecode(jsonData) as List;

    return list.map((video) => Video.fromJson(video)).toList();
  }
}
