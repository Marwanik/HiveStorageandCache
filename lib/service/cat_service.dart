import 'package:dio/dio.dart';

import 'package:listwithcasheandstorage/model/cat_model.dart';



class ApiService {
  static const String url = 'https://freetestapi.com/api/v1/cats';

  final Dio _dio = Dio();

  Future<List<CatModel>> fetchcats() async {
    try {
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List jsonResponse = response.data;
        List<CatModel> cats = [];

        for (var catData in jsonResponse) {
          // Check if all required fields are not null
          if (catData['name'] != null && catData['origin'] != null && catData['image'] != null) {
            cats.add(CatModel(
              name: catData['name'],
              origin: catData['origin'],
              image: catData['image'],
            ));
          }
        }

        return cats;
      } else {
        throw Exception('Failed to load cats');
      }
    } catch (e) {
      throw Exception('Failed to load cats: $e');
    }
  }

}