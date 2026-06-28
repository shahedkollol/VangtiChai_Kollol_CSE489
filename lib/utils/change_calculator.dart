/// Greedy algorithm: calculates the minimum number of each
/// Taka note needed to make up [amount].
class ChangeCalculator {
  static const List<int> denominations = [500, 100, 50, 20, 10, 5, 2, 1];

  static Map<int, int> calculate(int amount) {
    final result = <int, int>{};
    var remaining = amount;

    for (final denom in denominations) {
      result[denom] = remaining ~/ denom;
      remaining %= denom;
    }

    return result;
  }
}
