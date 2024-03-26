import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Список элементов',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 248, 59, 194)),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 218, 73, 160),
              title: Text(
                'Список элементов',
                style:
                    TextStyle(color: Color.fromARGB(255, 243, 189, 244)),
              ),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Простой'),
                  Tab(text: 'Бесконечный'),
                  Tab(text: 'Степень 2'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FirstScreen(),
                SecondScreen(),
                ThirdScreen(),
              ],
            )),
      ),
    );
  }
}

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text('0000'),
        Divider(),
        Text('0001'),
        Divider(),
        Text('0010'),
        Divider(),
      ],
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      return Text('строка $index');
    });
  }
}

class ThirdScreen extends StatefulWidget {
  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final List<String> _array = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, i) {
      print('num $i : нечетное = ${i.isOdd}');

      if (i.isOdd) return Divider();

      final int index = i ~/ 2;

      print('index $index');
      print('lenght ${_array.length}');

      if (index >= _array.length)
        _array.addAll(['$index', '${index + 1}', '${index + 2}']);
      return ListTile(
          title: Text('2' +
              ' ^ ' +
              _array[index] +
              ' = ' +
              pow(2, int.parse(_array[index])).toString()));
    });
  }
}
