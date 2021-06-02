import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news_app/widgets/bloc/navigation_event.dart';
import 'package:my_news_app/widgets/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final int pageIndex;
  NavigationBloc(this.pageIndex) : super(Opened(pageIndex: pageIndex));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is Navigate) {
      yield Opened(pageIndex: event.pageIndex);
    }
  }
}
