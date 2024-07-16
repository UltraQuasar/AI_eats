import 'dart:convert';

import 'dart:typed_data';

import 'package:ai_eats/prompt_model/cuisine.dart';
import 'package:ai_eats/prompt_model/prompt_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CuisinesService {
  //cloud storage
  static final dbRef = FirebaseFirestore.instance;
  static final storageRef = FirebaseStorage.instance.ref();

  static Future<List<Cuisine>?> getAllCuisinesCloud() async {
    try {
      final snapshot = await dbRef.collection('cuisines').get();
      List<Cuisine>? tmp =
          snapshot.docs.map((e) => Cuisine.fromSnapshot(e)).toList();
      return tmp;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<Uint8List?> getCuisineIconFromCloud(String image_path) async {
    const oneMegabyte = 1024 * 1024;
    final tmpRef = storageRef.child('Cuisines_icons/$image_path');
    try {
      Uint8List? data = await tmpRef.getData(oneMegabyte);
      print('loaded image from $image_path');
      return data;
    } catch (e) {
      print('error when loading: $image_path');
      print(e.toString());
      return null;
    }
  }



//local storage
  static final String keyCuisinesDataBase = 'cuisines';
// always call updateName first
  static Future<bool> updateCuisinesNameInLocalStorage() async {
    List<Cuisine>? cuisines = await getAllCuisinesCloud();
    if (cuisines != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(keyCuisinesDataBase);
      prefs.setStringList(keyCuisinesDataBase, []);
      List<String> tmp = [];
      for (Cuisine c in cuisines) {
        tmp.add(c.name);
      }
     // PromptGeneration.cuisineHelper = tmp;
      return prefs.setStringList(keyCuisinesDataBase, tmp);
    } else {
      print ('No list with cuisines received');
      return false;
    }
  }
// updates the images from the cloud, image path from the local storage
  static Future<bool> updateCuisinesImagesInLocalStorage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? image_paths = prefs.getStringList(keyCuisinesDataBase);
      if (image_paths != null) {
        for (String path in image_paths) {
          Future<Uint8List?> imageData = getCuisineIconFromCloud('$path.png'); // added because only the name is given to display the widget name right
          // image saved with the widget name e.g american
          saveImage(imageData, path);
        }

        return true;
      } else {
        print('No List with Cuisines in Local Storage');
        return false;
      }
    } catch (e) {
      print(e.toString());
      print('Failed: updateCuisinesImagesInLocalStorage()');
      return false;
    }
  }

  static Future<void> resetLocalStorage() async{
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? list = await prefs.getStringList(keyCuisinesDataBase);
      if (list != null) {
        for (String s in list) {
          prefs.remove(s);
          print('removed $s from local storage (Reset)');
        }
        prefs.setStringList(keyCuisinesDataBase, []);
        print ('rested local storage successfully');
        return;
      }
      print('list is already empty -> not need to reset');
    } catch (e) {
      print('Failed to reset local Storage');
      print(e.toString());
    }
  }

  static Future<bool> saveImage(Future<List<int>?> imageBytes, String name) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<int>? imageBytesTmp = await imageBytes;
      String base64Image = base64Encode(imageBytesTmp!);
      print('image saved locally: $name');
      return prefs.setString(name, base64Image);
    } catch (e) {
      print('Failed: saveImage');
      print(e.toString());
      return false;
    }
  }

  static Future<Image?> getImage(String name) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(name);
      if (data != null) {
        Uint8List bytes = base64Decode(data);
        print('return following image from local storage: $name');
        return Image.memory(
          bytes,
          width: 30,
          height: 30,
        );
      } else {
        print('No image saved under: $name');
        return null;
      }
    } catch (e) {
      print ('Failed to getImage');
      print(e.toString());
      return Image.asset(
        'assets/icons/food_style_selection/error_image.png',
        width: 30,
        height: 30,
      );
    }
  }


// loads every cuisine into the prompt content
  static Future<void> updateCuisineHelper(PromptGeneration p) async{
   try {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     List<String>? checkList = prefs.getStringList(keyCuisinesDataBase);
     if (checkList != null) {
       p.setCuisineHelper(checkList);
       print('updated cuisineHelper successfully');
       return;
     }
     print('failed to update cuisineHelper');
   } catch (e) {
     print(e.toString());
     print('Failed: getAllCuisineNamesFromStorage()');
   }
  }
}
