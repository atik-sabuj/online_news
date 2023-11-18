import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_news/models/news_channels_headlines_model.dart';


class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi() async{

    String url = 'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=a6376f2f94534529af242f6066c7a8aa';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      final body = jsonDecode(response.body);

      return NewsChannelsHeadlinesModel.fromJson(body);
    }
    throw Exception('Error');
  }
}