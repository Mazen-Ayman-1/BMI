import 'package:callllc/core/widgets.dart';
import 'package:callllc/features/cubit/bmi_cubit.dart';
import 'package:callllc/features/cubit/bmi_state.dart';
import 'package:callllc/features/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

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
                              SizedBox(height: height * 0.02),
                              Text(
                                'Please Modify the values',
                                style: TextStyle(
                                  fontSize: isLandscape ? width * 0.03 : width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: height * 0.03),
                              if (isLandscape)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          AppValueCard(
                                            label: 'Weight (kg)',
                                            value: state.weight,
                                            height: height,
                                            width: width,
                                            isLandscape: isLandscape,
                                            onDecrease: () => context.read<BmiCubit>().decreaseWeight(),
                                            onIncrease: () => context.read<BmiCubit>().increaseWeight(),
                                          ),
                                          SizedBox(height: height * 0.02),
                                          AppValueCard(
                                            label: 'Age',
                                            value: state.age,
                                            height: height,
                                            width: width,
                                            isLandscape: isLandscape,
                                            onDecrease: () => context.read<BmiCubit>().decreaseAge(),
                                            onIncrease: () => context.read<BmiCubit>().increaseAge(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: width * 0.05),
                                    Expanded(
                                      child: AppHeightSlider(
                                        heightValue: state.height,
                                        height: height,
                                        width: width,
                                        isLandscape: isLandscape,
                                        onChanged: (value) => context.read<BmiCubit>().changeHeight(value),
                                      ),
                                    ),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: AppValueCard(
                                            label: 'Weight (kg)',
                                            value: state.weight,
                                            height: height,
                                            width: width,
                                            isLandscape: isLandscape,
                                            onDecrease: () => context.read<BmiCubit>().decreaseWeight(),
                                            onIncrease: () => context.read<BmiCubit>().increaseWeight(),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.05),
                                        Expanded(
                                          child: AppValueCard(
                                            label: 'Age',
                                            value: state.age,
                                            height: height,
                                            width: width,
                                            isLandscape: isLandscape,
                                            onDecrease: () => context.read<BmiCubit>().decreaseAge(),
                                            onIncrease: () => context.read<BmiCubit>().increaseAge(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.03),
                                    AppHeightSlider(
                                      heightValue: state.height,
                                      height: height,
                                      width: width,
                                      isLandscape: isLandscape,
                                      onChanged: (value) => context.read<BmiCubit>().changeHeight(value),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          AppButton(
                            text: 'Calculate',
                            onPressed: () {
                              context.read<BmiCubit>().calculateBMI();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ResultScreen()),
                              );
                            },
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
}
