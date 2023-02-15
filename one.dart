double BMI(
    {double ft = 0.0,
    double In = 0.0,
    double lbs = 0.0,
    double cm = 0.0,
    double kg = 0.0}) {
  if (ft > 0) {
    //imperial measurements used
    double height = (ft * 0.3048) + (In * 0.0254);
    double weight = (lbs * 0.45359237);
    double bmi = weight / (height * height);
    return bmi;
  } else {
    //metric measurements used
    double height = cm / 100;
    double bmi = kg / (height * height);
    return bmi;
  }
}

void main() {
  print(BMI(ft:6, In:0, lbs:179));
}
