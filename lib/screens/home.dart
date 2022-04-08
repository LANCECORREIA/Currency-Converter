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
  Map passedArgs = {};

  //sharedpreference to save the selected currency
  Future<void> _saveSelected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //parse boolean list to string list
    List<String> string_selected =
        selected.map((e) => e ? 'true' : 'false').toList();
    prefs.setStringList('selected', string_selected);
  }

  @override
  Widget build(BuildContext context) {
    passedArgs = ModalRoute.of(context)!.settings.arguments as Map;
    data = passedArgs['data'] as List<Currency>;
    selected = passedArgs['selected'] as List<bool>;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 231, 231),
      appBar: AppBar(
        title: Text("Crypto Converter"),
        backgroundColor: Color.fromARGB(255, 105, 239, 173),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.pushNamed(context, '/favourite',
                  arguments: data
                      .where((element) => selected[data.indexOf(element)])
                      .toList());
            },
          ),
        ],
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
                      tileColor: Colors.white,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pushNamed(context, '/detail',
                            arguments: data[index]);
                      },
                      leading: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/${data[index].name}.png'),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            "${data[index].symbol}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${(input / double.parse(data[index].price)).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            try {
                              selected[index] = !selected[index];
                              _saveSelected();
                            } catch (e) {
                              print(e);
                            }
                          });
                        },
                        child: selected[index]
                            ? Icon(Icons.favorite, color: Colors.red)
                            : Icon(Icons.favorite_border, color: Colors.red),
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
