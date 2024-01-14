import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../data_source/remote/api_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiHelper apiHelper;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(GetAllNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NewsErrorState) {
              return Center(
                child: Text(state.errorMsg),
              );
            } else if (state is NewsLoadedState) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.loadedData.articles!.length,
                itemBuilder: (_, index) {
                  var news = state.loadedData.articles![index];
                  return ListTile(
                    title: Text(news.title!),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
