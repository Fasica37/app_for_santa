import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/child_content.dart';
import 'child_list_event.dart';
import 'child_list_state.dart';

class ChildListBloc extends Bloc<ChildListEvent, ChildListState> {
  ChildListBloc() : super(InitialState()) {
    on<ChildListEvent>((event, emit) {
      if (event is LoadChildListEvent) {
        emit(LoadedState(
            List.from(children))); // Return a copy of the static list
      } else if (event is AddChildEvent) {
        children.add(event.child);
        emit(LoadedState(List.from(children)));
      } else if (event is ChangeStatusEvent) {
        children[event.index].isNice = !children[event.index].isNice;
        emit(LoadedState(List.from(children)));
      }
    });
  }
}
