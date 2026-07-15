class BmiState {
  final bool isMale;
  final int weight;
  final int age;
  final double height;
  final double bmi;

  const BmiState({
    this.isMale = true,
    this.weight = 65,
    this.age = 20,
    this.height = 170,
    this.bmi = 0,
  });

  BmiState copyWith({
    bool? isMale,
    int? weight,
    int? age,
    double? height,
    double? bmi,
  }) {
    return BmiState(
      isMale: isMale ?? this.isMale,
      weight: weight ?? this.weight,
      age: age ?? this.age,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
    );
  }
}