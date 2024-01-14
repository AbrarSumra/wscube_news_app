import '../models/news_data_model.dart';

abstract class JournalState {}

class JournalInitialState extends JournalState {}

class JournalLoadingState extends JournalState {}

class JournalErrorState extends JournalState {
  String errorMsg;
  JournalErrorState({required this.errorMsg});
}

class JournalLoadedState extends JournalState {
  NewsModel loadedData;

  JournalLoadedState({required this.loadedData});
}
