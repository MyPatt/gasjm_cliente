import 'dart:math';

class Transaction {
  String? name;
  double? point;
  int? createdMillis;

  Transaction({this.name, this.point, this.createdMillis});
}

List<Transaction> transactions = List.generate(5, (index) {
  Random random = Random();
  bool isRedeem = random.nextBool();

  String name = isRedeem ? "Vía a Santa Rosa, Ambato" : "Quito &, Ambato";
  double point = isRedeem ? -50.0 : (random.nextInt(9) + 1) * 1.8;
  return Transaction(
      name: name,
      point: point,
      createdMillis: DateTime.now()
          .add(Duration(
            days: -random.nextInt(7),
            hours: -random.nextInt(23),
            minutes: -random.nextInt(59),
          ))
          .millisecondsSinceEpoch);
})
  ..sort((v1, v2) => (v2.createdMillis! - v1.createdMillis!.toInt()));
