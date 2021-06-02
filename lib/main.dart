import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/helper/routes.dart';
import 'package:my_news_app/pages/homepage/bloc/newsBloc.dart';
import 'package:my_news_app/pages/homepage/bloc/newsEvent.dart';
import 'package:my_news_app/pages/newsDetail/bloc/bloc.dart';
import 'package:my_news_app/resources/repository.dart';
import 'package:my_news_app/widgets/bloc/bloc.dart';
import 'blocs/bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NewsBloc>(
            create: (context) =>
                NewsBloc(repository: Repository())..add(Fetch(type: 'General')),
          ),
          BlocProvider<DetailBloc>(create: (context) => DetailBloc()),
          BlocProvider<NavigationBloc>(create: (context) => NavigationBloc(0)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: Routes.getRoute(),
          theme: ThemeData.dark(),
        ));
  }
}
