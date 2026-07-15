import 'package:callllc/core/widgets.dart';
import 'package:callllc/features/cubit/bmi_cubit.dart';
import 'package:callllc/features/cubit/bmi_state.dart';
import 'package:callllc/features/screens/input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenderScreen extends StatelessWidget {
  const GenderScreen({super.key});

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
                              SizedBox(height: height * 0.03),
                              AppHeader(width: width, isLandscape: isLandscape),
                              SizedBox(height: height * 0.05),
                              Text(
                                'Please choose your gender',
                                style: TextStyle(
                                  fontSize: isLandscape ? width * 0.03 : width * 0.055,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: height * 0.04),
                              if (isLandscape)
                                Row(
                                  children: [
                                    Expanded(child: _buildGenderCard(context, state, true, height, width, isLandscape)),
                                    SizedBox(width: width * 0.05),
                                    Expanded(child: _buildGenderCard(context, state, false, height, width, isLandscape)),
                                  ],
                                )
                              else
                                Column(
                                  children: [
                                    _buildGenderCard(context, state, true, height, width, isLandscape),
                                    SizedBox(height: height * 0.03),
                                    _buildGenderCard(context, state, false, height, width, isLandscape),
                                  ],
                                ),
                            ],
                          ),
                          AppButton(
                            text: 'Continue',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const InputScreen()),
                              );
                            },
                            height: height,
                            width: width,
                            isLandscape: isLandscape,
                          ),
                          SizedBox(height: height * 0.03),
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

  Widget _buildGenderCard(BuildContext context, BmiState state, bool isMale, double height, double width, bool isLandscape) {
    final bool isSelected = state.isMale == isMale;
    final Color activeColor = isMale ? const Color(0xFF65B741) : const Color(0xFFFFB534);
    final Color bgColor = isMale ? const Color(0xFFF0F8EC) : const Color(0xFFFFF7E8);

    return InkWell(
      onTap: () => context.read<BmiCubit>().changeGender(isMale),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: isLandscape ? height * 0.45 : height * 0.22,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: activeColor, width: 3) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              isMale ? 'Male' : 'Female',
              style: TextStyle(
                fontSize: isLandscape ? width * 0.04 : width * 0.08,
                fontWeight: FontWeight.bold,
                color: activeColor,
              ),
            ),
            Icon(
              isMale ? Icons.male : Icons.female,
              size: isLandscape ? width * 0.12 : width * 0.25,
              color: activeColor,
            ),
          ],
        ),
      ),
    );
  }
}
