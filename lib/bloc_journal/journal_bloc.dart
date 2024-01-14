import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_source/remote/api_exception.dart';
import '../data_source/remote/api_helper.dart';
import '../data_source/remote/urls.dart';
import '../models/news_data_model.dart';
import 'journal_event.dart';
import 'journal_state.dart';

class JournalBloc extends Bloc<JournalEvent, JournalState> {
  ApiHelper apiHelper;
  JournalBloc({required this.apiHelper}) : super(JournalInitialState()) {
    on<GetJournalNews>((event, emit) async {
      emit(JournalLoadingState());

      try {
        var mData = await apiHelper.getApi(Urls.JOURNAL_API_KEY);
        var loadedData = NewsModel.fromJson(mData);
        emit(JournalLoadedState(loadedData: loadedData));
      } catch (e) {
        emit(JournalErrorState(errorMsg: (e as AppException).toString()));
      }
    });
  }
}
