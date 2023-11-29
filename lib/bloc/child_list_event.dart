import '../models/child.dart';

abstract class ChildListEvent {}

class LoadChildListEvent extends ChildListEvent {}

class AddChildEvent extends ChildListEvent {
  final Child child;

  AddChildEvent(this.child);
}

class ChangeStatusEvent extends ChildListEvent {
  final int index;

  ChangeStatusEvent(this.index);
}
