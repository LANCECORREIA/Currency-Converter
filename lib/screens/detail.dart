import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    Currency instance = ModalRoute.of(context)!.settings.arguments as Currency;
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Converter"),
        backgroundColor: Color.fromARGB(255, 105, 239, 173),
        foregroundColor: Colors.black,
      ),
      body: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("Name"),
              subtitle: Text(instance.name),
            ),
            ListTile(
              title: Text("Price"),
              subtitle: Text(instance.price),
            ),
            ListTile(
              title: Text("Symbol"),
              subtitle: Text(instance.symbol),
            ),
            ListTile(
              title: Text("Rank"),
              subtitle: Text(instance.rank),
            ),
          ],
        ),
      ),
    );
  }
}
