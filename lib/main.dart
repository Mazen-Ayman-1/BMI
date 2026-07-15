import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:callllc/features/screens/gender_screen.dart';
import 'package:callllc/features/cubit/bmi_cubit.dart';


void main() {
  runApp(
    BlocProvider(
      create: (context) => BmiCubit(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const GenderScreen(),
    );
  }
}