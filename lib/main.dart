import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:movie/screens/trending_movie_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const TrendingMovieClass(),
    );
  }
}
