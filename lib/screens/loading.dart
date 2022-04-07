import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  List<bool> selected = [];
  //use sharedpreference to check if selected currency exists
  Future<void> _checkSelected(data) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        List<String> string_selected = prefs.getStringList('selected') ?? [];
        //parse string list to boolean list
        selected =
            string_selected.map((e) => e == 'true' ? true : false).toList();
        if (selected.length != data.length) {
          selected = List.generate(data.length, (index) => false);
        }
      });
    } catch (e) {
      print(e);
    }
  }

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
      _checkSelected(data);
      await Future.delayed(const Duration(milliseconds: 3000));
      Navigator.pushReplacementNamed(context, '/home',
          arguments: {"data": data, "selected": selected});
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
