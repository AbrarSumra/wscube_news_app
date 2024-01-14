import '../models/news_data_model.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsErrorState extends NewsState {
  String errorMsg;
  NewsErrorState({required this.errorMsg});
}

class NewsLoadedState extends NewsState {
  NewsModel loadedData;

  NewsLoadedState({required this.loadedData});
}
