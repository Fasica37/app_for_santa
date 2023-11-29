import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/child_list_bloc.dart';
import 'bloc/child_list_event.dart';
import 'view/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Instantiate the ChildListBloc to manage the state of the application.
  final ChildListBloc listBloc = ChildListBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        // We provide the bloc instance to the widget tree.
        create: (context) => listBloc..add(LoadChildListEvent()),
        child: MyHomePage(),
      ),
    );
  }
}
