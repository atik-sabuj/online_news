

import 'package:online_news/models/categories_news_model.dart';
import 'package:online_news/models/news_channels_headlines_model.dart';
import 'package:online_news/repository/news_repository.dart';

class NewsViewModel {

  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async {

    final response = await _rep.fetchNewsChannelsHeadlinesApi(channelName);
    return response;
  }


  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {

    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;
  }



}