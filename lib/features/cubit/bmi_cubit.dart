import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(const BmiState());

  void changeGender(bool value) {
    emit(state.copyWith(isMale: value));
  }

  void increaseWeight() {
    emit(state.copyWith(weight: state.weight + 1));
  }

  void decreaseWeight() {
    if (state.weight > 1) {
      emit(state.copyWith(weight: state.weight - 1));
    }
  }

  void increaseAge() {
    emit(state.copyWith(age: state.age + 1));
  }

  void decreaseAge() {
    if (state.age > 1) {
      emit(state.copyWith(age: state.age - 1));
    }
  }

  void changeHeight(double value) {
    emit(state.copyWith(height: value));
  }

  void calculateBMI() {
    double h = state.height / 100;

    double result = state.weight / pow(h, 2);

    emit(state.copyWith(bmi: result));
  }

  String getResult() {
    if (state.bmi < 18.5) {
      return "Underweight";
    } else if (state.bmi < 25) {
      return "Normal";
    } else if (state.bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }
}