// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('String Calculator', () {

    test('should return 0 for empty string', () {
      expect(add(""), 0);
    });

    test('should return the number itself for a single number', () {
      expect(add("1"), 1);
      expect(add("2"), 2);
    });

    test('should return the sum of two numbers', () {
      expect(add("1,2"), 3);
      expect(add("3,4"), 7);
    });

     test('should handle multiple numbers', () {
      expect(add("1,2,3"), 6);
      expect(add("1,2,3,4,5"), 15);
    });

    test('should handle newlines as delimiters', () {
      expect(add("1\n2"), 3);
      expect(add("1,2\n3"), 6);
    });

     test('should handle custom delimiters', () {
      expect(add("//;\n1;2"), 3);
      expect(add("//\$\n1\$2\$3"), 6);
    });

    test('should throw exception for negative numbers', () {
      expect(() => add("-1,2"), throwsA(isA<Exception>()));
      expect(() => add("1,-2,3,-4"), throwsA(isA<Exception>()));
    });

    test('should ignore numbers greater than 1000', () {
      expect(add("1,1001,2"), 3);
      expect(add("1002,2,3"), 5);
    });
  });
}


int add(String numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  if (numbers.startsWith("//")) {
    final delimiter = numbers[
        2]; 
    final remainingNumbers = numbers.substring(4); 
    return _sumNumbers(remainingNumbers, delimiter);
  } else {
    return _sumNumbers(numbers, ',');
  }
}

int _sumNumbers(String numbers, String delimiter) {
  String cleanedNumbers =
      numbers.replaceAll('\n', delimiter);

  if (cleanedNumbers.contains('-')) {
    List<int> negatives = [];
    for (String num in cleanedNumbers.split(delimiter)) {
      int n = int.parse(num);
      if (n < 0) {
        negatives.add(n);
      }
    }
    throw Exception("Negatives not allowed: ${negatives.join(", ")}");
  }

  return cleanedNumbers.split(delimiter).fold(0, (sum, num) {
    int n = int.parse(num);
    if (n > 1000) {
      return sum;
    }

    return sum + n;
  });
}
