import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:online_news/models/categories_news_model.dart';
import 'package:online_news/models/news_channels_headlines_model.dart';


class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async{
    
//API CALL HERE(OWN API)
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=WRITE HERE YOUR OWN NEWS API';

    print(url);

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){

      final body = jsonDecode(response.body);

      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }




  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async{

    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=a6376f2f94534529af242f6066c7a8aa';

    print(url);

    final response = await http.get(Uri.parse(url));

    if (kDebugMode) {
      print(response.body);
    }

    if(response.statusCode == 200){

      final body = jsonDecode(response.body);

      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }


}
