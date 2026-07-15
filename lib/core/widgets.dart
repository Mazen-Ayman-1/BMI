import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final double width;
  final bool isLandscape;
  final bool showBackButton;

  const AppHeader({
    super.key,
    required this.width,
    required this.isLandscape,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final double fontSize = isLandscape ? width * 0.05 : width * 0.09;
    return Row(
      children: [
        if (showBackButton)
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: const Color(0xff65B741),
              size: isLandscape ? width * 0.04 : width * 0.06,
            ),
          ),
        if (showBackButton) const Spacer(),
        if (!showBackButton) const Spacer(),
        Text(
          'BMI',
          style: TextStyle(
            color: const Color(0xffFFB534),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: width * 0.01),
        Text(
          'Calculator',
          style: TextStyle(
            color: const Color(0xff65B741),
            fontSize: fontSize * 0.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showBackButton) const Spacer(),
        if (!showBackButton) const Spacer(),
        if (showBackButton) SizedBox(width: width * 0.1),
      ],
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final bool isLandscape;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.height,
    required this.width,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height * 0.08,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff65B741),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: isLandscape ? width * 0.04 : width * 0.07,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class AppValueCard extends StatelessWidget {
  final String label;
  final int value;
  final double height;
  final double width;
  final bool isLandscape;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  const AppValueCard({
    super.key,
    required this.label,
    required this.value,
    required this.height,
    required this.width,
    required this.isLandscape,
    required this.onDecrease,
    required this.onIncrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isLandscape ? height * 0.35 : height * 0.22,
      decoration: BoxDecoration(
        color: const Color(0xffFFF8EA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: isLandscape ? width * 0.025 : width * 0.04,
            ),
          ),
          Text(
            '$value',
            style: TextStyle(
              fontSize: isLandscape ? width * 0.06 : width * 0.11,
              fontWeight: FontWeight.bold,
              color: const Color(0xffC78A10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRoundButton(Icons.remove, onDecrease),
              _buildRoundButton(Icons.add, onIncrease),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRoundButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: isLandscape ? width * 0.03 : width * 0.05),
        padding: EdgeInsets.all(isLandscape ? width * 0.01 : width * 0.02),
        constraints: const BoxConstraints(),
      ),
    );
  }
}

class AppHeightSlider extends StatelessWidget {
  final double heightValue;
  final double height;
  final double width;
  final bool isLandscape;
  final ValueChanged<double> onChanged;

  const AppHeightSlider({
    super.key,
    required this.heightValue,
    required this.height,
    required this.width,
    required this.isLandscape,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.05),
      decoration: BoxDecoration(
        color: const Color(0xffEEF8E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Height (cm)",
            style: TextStyle(
              color: Colors.grey,
              fontSize: isLandscape ? width * 0.025 : width * 0.045,
            ),
          ),
          SizedBox(height: height * 0.01),
          Text(
            heightValue.round().toString(),
            style: TextStyle(
              fontSize: isLandscape ? width * 0.06 : width * 0.11,
              fontWeight: FontWeight.bold,
              color: const Color(0xff65B741),
            ),
          ),
          Slider(
            value: heightValue,
            min: 100,
            max: 220,
            activeColor: const Color(0xff65B741),
            inactiveColor: Colors.grey.shade300,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
