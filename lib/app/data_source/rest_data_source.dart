import 'package:dio/dio.dart';
import '../models/news.dart';

class RestDataSource {
  static const String _baseUrl =
      'https://us-central1-gepp-dev.cloudfunctions.net/ContenidoClientesV1';

  Map<String, dynamic> data = {'data': []};

  Future<List<News>?> fetchNews() async {
    try {
      Response response = await Dio().post(_baseUrl, data: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var getData = response.data['result'] as List;
        List<News> listNews = getData.map((i) => News.fromJSON(i)).toList();
        return listNews;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print(e);
    }
  }
}
