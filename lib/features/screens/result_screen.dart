import 'package:callllc/core/widgets.dart';
import 'package:callllc/features/cubit/bmi_cubit.dart';
import 'package:callllc/features/cubit/bmi_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double height = constraints.maxHeight;
            final double width = constraints.maxWidth;
            final bool isLandscape = width > height;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: height),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: BlocBuilder<BmiCubit, BmiState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: height * 0.02),
                              AppHeader(width: width, isLandscape: isLandscape, showBackButton: true),
                              SizedBox(height: isLandscape ? height * 0.02 : height * 0.05),
                              if (isLandscape)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "Your BMI is",
                                            style: TextStyle(
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          _buildResultCard(state, height, width, isLandscape),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: width * 0.05),
                                    Expanded(
                                      child: _buildAdviceText(context, state.bmi, width, isLandscape),
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    Text(
                                      "Your BMI is",
                                      style: TextStyle(
                                        fontSize: width * 0.06,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: height * 0.03),
                                    _buildResultCard(state, height, width, isLandscape),
                                    SizedBox(height: height * 0.04),
                                    _buildAdviceText(context, state.bmi, width, isLandscape),
                                  ],
                                ),
                            ],
                          ),
                          AppButton(
                            text: 'Recalculate',
                            onPressed: () => Navigator.pop(context),
                            height: height,
                            width: width,
                            isLandscape: isLandscape,
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResultCard(BmiState state, double height, double width, bool isLandscape) {
    return Container(
      height: isLandscape ? height * 0.45 : height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xffEEF8E9),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.bmi.toStringAsFixed(1),
            style: TextStyle(
              fontSize: isLandscape ? width * 0.08 : width * 0.18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff65B741),
            ),
          ),
          SizedBox(height: height * 0.01),
          BlocBuilder<BmiCubit, BmiState>(
            builder: (context, state) {
              return Text(
                context.read<BmiCubit>().getResult(),
                style: TextStyle(
                  fontSize: isLandscape ? width * 0.04 : width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff65B741),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceText(BuildContext context, double bmi, double width, bool isLandscape) {
    String advice = "";
    if (bmi < 18.5) {
      advice = "You are underweight.\nTry to eat more!";
    } else if (bmi < 25) {
      advice = "You have a normal body weight.\nGood Job!";
    } else if (bmi < 30) {
      advice = "You are overweight.\nTry to exercise more!";
    } else {
      advice = "You are obese.\nPlease consult a doctor!";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Text(
        advice,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isLandscape ? width * 0.03 : width * 0.05,
          color: Colors.black54,
          height: 1.5,
        ),
      ),
    );
  }
}
