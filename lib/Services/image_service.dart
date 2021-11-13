import 'dart:io';

import 'package:apod/Models/image_model.dart';
import 'package:http/http.dart' as http;
import '../Services/api_error.dart';
class ImageServices{
  static Future<Object> getImage(String date) async {
    try{
      print('***********************');
      print(date);
      var url = Uri.parse('https://api.nasa.gov/planetary/apod?api_key=j3y7mYMcOXwLv9MRgA0GIxUIeCcyMWxD4bcX6PNg&date=$date');
      var response = await http.get(url);
      if (200 == response.statusCode) {
        return Success( response: imageModelFromJson(response.body));
      }
      print(response.body);
      return Failure(
          code: 100,
          errorResponse: 'Date must be between Jun 16, 1995 and today\'s date');
    } on SocketException {
      return Failure(
          code: 102,
          errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(
          code: 102,
          errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(
          code: 103,
          errorResponse: 'Unknown Error');
    }
  }
}