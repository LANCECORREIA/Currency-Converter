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
        title: Text(instance.name),
      ),
      body: Center(
        child: Text("Detail"),
      ),
    );
  }
}
