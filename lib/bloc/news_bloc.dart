import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_source/remote/api_exception.dart';
import '../data_source/remote/api_helper.dart';
import '../data_source/remote/urls.dart';
import '../models/news_data_model.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  ApiHelper apiHelper;
  NewsBloc({required this.apiHelper}) : super(NewsInitialState()) {
    on<GetAllNews>((event, emit) async {
      emit(NewsLoadingState());

      try {
        var mData = await apiHelper.getApi(Urls.API_KEY);
        var loadedData = NewsModel.fromJson(mData);
        emit(NewsLoadedState(loadedData: loadedData));
      } catch (e) {
        emit(NewsErrorState(errorMsg: (e as AppException).toString()));
      }
    });
  }
}
