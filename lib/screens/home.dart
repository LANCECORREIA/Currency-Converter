import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double input = 0.0;
  List<Currency> data = [];
  List<bool> selected = [];
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as List<Currency>;
    selected = selected.isEmpty
        ? List.generate(data.length, (index) => false)
        : selected;
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Converter"),
      ),
      // region
      // body: Column(
      //   children: [
      //     SizedBox(
      //       height: 20,
      //     ),
      //     TextFormField(
      //       initialValue: '0.0',
      //       autofocus: true,
      //       decoration: InputDecoration(
      //         labelText: "Enter Amount",
      //         labelStyle: TextStyle(
      //           color: Colors.black,
      //         ),
      //         border: OutlineInputBorder(),
      //         icon: Icon(
      //           Icons.currency_rupee,
      //           color: Colors.black,
      //         ),
      //       ),
      //       keyboardType: TextInputType.number,
      //       onChanged: ((value) {
      //         setState(() {
      //           try {
      //             input = double.parse(value);
      //           } catch (e) {
      //             input = 0.0;
      //           }
      //         });
      //       }),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     // Card(
      //     //   child: ListTile(
      //     //     leading: Icon(Icons.currency_bitcoin),
      //     //     title: Text("Total: ${input / double.parse('1')}"),
      //     //   ),
      //     // ),
      //     // Card(
      //     //   child: ListTile(
      //     //     leading: Icon(Icons.currency_lira),
      //     //     title: Text("Total: ${input * 0.0015}"),
      //     //   ),
      //     // ),
      //   ],
      // endregion
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: '0.0',
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Enter Amount",
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                icon: Icon(
                  Icons.currency_rupee,
                  color: Colors.black,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: ((value) {
                setState(() {
                  try {
                    input = double.parse(value);
                  } catch (e) {
                    input = 0.0;
                  }
                });
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(context, '/detail',
                          arguments: data[index]),
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[index].symbol),
                      ),
                      title: Text(
                          "${(input / double.parse(data[index].price)).toStringAsFixed(2)}"),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            try {
                              selected[index] = !selected[index];
                            } catch (e) {
                              print(e);
                            }
                          });
                        },
                        child: selected[index]
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
