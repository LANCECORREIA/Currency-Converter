import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  double input = 0.0;
  List<Currency> data = [];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as List<Currency>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Converter"),
        backgroundColor: Color.fromARGB(255, 105, 239, 173),
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
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
                      textColor: Colors.black,
                      onTap: () => Navigator.pushNamed(context, '/detail',
                          arguments: data[index]),
                      leading: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/${data[index].name}.png'),
                        ),
                      ),
                      title: Text(
                          "${(input / double.parse(data[index].price)).toStringAsFixed(2)}"),
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
