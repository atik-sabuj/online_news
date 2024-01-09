import 'dart:convert';


import 'package:http/http.dart' as http;

import '../models/categories_new_model.dart';
import '../models/news_channel_headlines_model.dart';

class NewsRepository {


  Future<CategoriesNewsModel> fetchNewsCategoires(String category) async {
    
    //API CALL HERE(OWN API)
    String newsUrl =
        'https://newsapi.org/v2/everything?q=$category&apiKey=WRITE HERE YOUR OWN NEWS API';
    final response = await http.get(Uri.parse(newsUrl));
    
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String newsChannel) async {

    //API CALL HERE(OWN API)
    String newsUrl = 'https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=WRITE HERE YOUR OWN NEWS API';
    print(newsUrl);
    final response = await http.get(Uri.parse(newsUrl));
    print(response.statusCode.toString());
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }
}
