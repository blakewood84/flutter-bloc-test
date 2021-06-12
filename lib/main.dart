import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/cubits/counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => CounterCubit(),
        child: MyHomePage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final cubit = CounterCubit();
  late StreamSubscription<int> stream;
  @override
  void initState() {
    stream = cubit.stream.listen((event) { 
      print(event);
    });
    super.initState();
  }

  


  @override
  void dispose() {
    stream.cancel();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterCubit>(context);
    return Scaffold(
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) {
          print(count);
          return Center(child: Text('$count'),);
        }
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => counterBloc.increment(),
      ),
    );
  }
}