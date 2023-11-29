import 'package:app_for_santa/models/child.dart';

abstract class ChildListState {}

class InitialState extends ChildListState {}

class LoadedState extends ChildListState {
  final List<Child> children;

  LoadedState(this.children);
}
