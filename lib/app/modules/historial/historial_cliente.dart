import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class Transaction {
  String? name;
  double? point;
  int? createdMillis;

  Transaction({this.name, this.point, this.createdMillis});
}

List<Transaction> transactions = List.generate(2, (index) {
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
  ..sort((v1, v2) => (v2.createdMillis!-v1.createdMillis!.toInt()));

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.blueBackground,
        elevation: 0.0,
        title: const Text(
          "Historial",
        ),
      ),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    String? prevDay;
    String today = DateFormat("d MMM, y").format(DateTime.now());
    String yesterday = DateFormat("d MMM, y")
        .format(DateTime.now().add(const Duration(days: -1)));

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        Transaction transaction = transactions[index];
        DateTime date =
            DateTime.fromMillisecondsSinceEpoch(transaction.createdMillis!.toInt());
        String dateString = DateFormat("d MMM, y").format(date);

        if (today == dateString) {
          dateString = "Hoy";
        } else if (yesterday == dateString) {
          dateString = "Ayer";
        }

        bool showHeader = prevDay != dateString;
        prevDay = dateString;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            showHeader
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Text(
                      dateString,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: AppTheme.blueDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  )
                : const Offstage(),
            buildItem(index, context, date, transaction),
          ],
        );
      },
    );
  }

  Widget buildItem(
      int index, BuildContext context, DateTime date, Transaction transaction) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(width: 20),
          buildLine(index, context),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            // color: Theme.of(context).accentColor,
            child: Text(
              DateFormat("hh:mm a").format(date),
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppTheme.light,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            flex: 1,
            child: buildItemInfo(transaction, context),
          ),
        ],
      ),
    );
  }

  Card buildItemInfo(Transaction transaction, BuildContext context) {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      elevation: 0.0,
      child: Container(
        color: Colors.transparent,
        /*  decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: transaction.point.isNegative
                  ? [AppTheme.blueLight, AppTheme.blueBackground]
                  : [AppTheme.blueOpacity, AppTheme.blueDark]),
        ),*/
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: Text(
                  transaction.name!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: AppTheme.blueDark),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: Text(
                "Cantidad: 1",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: AppTheme.light),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: Text(
                "Total: " +
                    NumberFormat.simpleCurrency().format(transaction.point),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: AppTheme.light),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildLine(int index, BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor, shape: BoxShape.circle),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 2,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
