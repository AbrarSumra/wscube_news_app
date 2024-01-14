import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wscube_news_app/bloc_journal/journal_bloc.dart';
import 'package:wscube_news_app/bloc_journal/journal_event.dart';
import 'package:wscube_news_app/bloc_journal/journal_state.dart';
import 'package:wscube_news_app/screens/detail_news.dart';

import '../data_source/remote/api_helper.dart';

class JournalNewsScreen extends StatefulWidget {
  const JournalNewsScreen({super.key});

  @override
  State<JournalNewsScreen> createState() => _JournalNewsScreenState();
}

class _JournalNewsScreenState extends State<JournalNewsScreen> {
  late ApiHelper apiHelper;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<JournalBloc>(context).add(GetJournalNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text(
          "News App",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<JournalBloc, JournalState>(
        builder: (context, state) {
          if (state is JournalLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is JournalErrorState) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is JournalLoadedState) {
            return ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              //shrinkWrap: true,
              itemCount: state.loadedData.articles!.length,
              itemBuilder: (_, index) {
                var news = state.loadedData.articles![index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => DetailNews(
                                  author: news.author!,
                                  title: news.title!,
                                  description: news.description!,
                                  url: news.url!,
                                  urlToImage: news.urlToImage,
                                  publishedAt: news.publishedAt!,
                                  content: news.content!,
                                )));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: SizedBox(
                        width: 100,
                        height: 100,
                        child: news.urlToImage != null
                            ? Image.network(
                                news.urlToImage!.toString(),
                                fit: BoxFit.fill,
                              )
                            : Container(),
                      ),
                      title: Text(
                        news.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            news.publishedAt!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
