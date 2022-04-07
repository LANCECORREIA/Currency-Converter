import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:currency_converter/models/currency.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void delayload() async {
    try {
      Response res =
          await get(Uri.http('api.nomics.com', '/v1/currencies/ticker', {
        'key': '867d26f67d0fa0512d0bcaced7ddc85c7e8bbbc8',
        'convert': 'INR',
        'ids': 'BTC,ETH,XRP,ADA,USDT,XRP',
      }));
      print(jsonDecode(res.body));
      List<Currency> data = List<Currency>.from(
          jsonDecode(res.body).map((e) => Currency.fromJson(e)));
      print(data);
      await Future.delayed(const Duration(milliseconds: 3000));
      Navigator.pushReplacementNamed(context, '/home', arguments: data);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    delayload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 200.0,
        ),
      ),
    );
  }
}
