import 'package:tuple/tuple.dart';

String bodmas(String equation) {
  Tuple2<List, List> tuple = strip(equation);
  List operands = tuple.item1;
  List operators = tuple.item2;
  if (operands.length == 1) {
    return operands[0];
  } else {
    if  (operators.contains('/')) {
      //logic for division
      int i = operators.indexOf('/');
      double j = double.parse(operands[i]);
      double k = double.parse(operands[i + 1]);
      double answer = j / k;
      operators.removeAt(i);
      operands.removeAt(i);
      operands.insert(i, answer.toString());
      operands.removeAt(i + 1);
      return bodmas(build(operands, operators));
    } else if (operators.indexOf('x') != -1) {
      //logic for multiplication
      int i = operators.indexOf('x');
      double j = double.parse(operands[i]);
      double k = double.parse(operands[i + 1]);
      double answer = j * k;
      operators.removeAt(i);
      operands.removeAt(i);
      operands.insert(i, answer.toString());
      operands.removeAt(i + 1);
      return bodmas(build(operands, operators));
    } else if (operators.indexOf('+') != -1) {
      //logic for addition
      int i = operators.indexOf('+');
      double j = double.parse(operands[i]);
      double k = double.parse(operands[i + 1]);
      double answer = j + k;
      operators.removeAt(i);
      operands.removeAt(i);
      operands.insert(i, answer.toString());
      operands.removeAt(i + 1);
      return bodmas(build(operands, operators));
    } else if (operators.indexOf('-') != -1) {
      //logic for subtraction
      int i = operators.indexOf('-');
      double j = double.parse(operands[i]);
      double k = double.parse(operands[i + 1]);
      double answer = j - k;
      operators.removeAt(i);
      operands.removeAt(i);
      operands.insert(i, answer.toString());
      operands.removeAt(i + 1);
      return bodmas(build(operands, operators));
    } else {
      return operands[0];
    }
  }
}

String build(List operands, List operators) {
  //a function that builds an equation using the lists of operands and operators
  String equation = '';
  int i = 0;
  for (i; i < operators.length; i++) {
    equation = equation + operands[i] + operators[i];
  }
  equation += operands[i];
  return equation;
}

Tuple2<List, List> strip(String equation) {
  //a function that splits the equation string into 2 lists of operators and operands
  int j = 0;
  List operands = [];
  List operators = [];
  for (int i = 0; i < equation.length; i++) {
    try {
      double.parse(equation.substring(i, i + 1));
    } catch (u) {
      if (equation.substring(i, i + 1) == '.') {
        null;
      } else {
        operands.add(equation.substring(j, i));
        operators.add(equation.substring(i, i + 1));
        j = i + 1;
      }
    }
  }
  operands.add(equation.substring(j, equation.length));
  return Tuple2(operands, operators);
}
