import 'dart:io';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excel Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Excel Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Item> items = [];
  String header = ''; // Сделать список хедеров

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    readExcel();
  }

  Future<void> readExcel() async {
    ByteData data = await rootBundle.load('assets/Schedule.xlsx');
    Uint8List bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    Excel excel = Excel.decodeBytes(bytes);

    final table = excel.tables['Лист1'];
    final rows = table!.rows;
    var cell = table.cell(CellIndex.indexByString("A1"));
    // Вручную задавать или через цикл?
    print(cell.value); // пушить в массив заголовки,
    header = cell.value.toString();

    for (int i = 1; i < rows.length; i++) {
      final row = rows[i];
      // print(row[0]?.value); отображение данных
      final item = Item(
        // { data: row[0], id: 1  }
        name: row[0].toString(),
        price: row[1].toString(),
        quantity: row[2].toString(),
      );
      setState(() {
        items.add(item);
        // print(items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: Center(
      //   child: ListView.builder(
      //     padding: EdgeInsets.all(16.0),
      //     itemCount: items.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       final item = items[index];
      //       return ListTile(
      //         title: Text(item.name),
      //         subtitle: Text('First: ${item.price}, Second: ${item.quantity}'),
      //       );
      //     },
      //   ),
      // ),
      body: Center(
        child: ListView( // Динамически отображать из массива
          scrollDirection: Axis.horizontal,
          children: [
            DataTable(
                columns: [
                  DataColumn(
                      label: Text(header)
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                  DataColumn(
                      label: Text('ID')
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(
                      Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    ),
                    DataCell(
                        Text('0001')
                    )
                  ]),
                ]
            )
          ],
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final String price;
  final String quantity;

  Item({required this.name, required this.price, required this.quantity});
}