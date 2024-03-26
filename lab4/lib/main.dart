import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart'; //библиотека для реализации звонка и открытия карт
import 'package:share/share.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 29, 161, 29)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Общежития КубГАУ'),
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  //функция звонка
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 320,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/obschaga.jpg'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Общежитие №20',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Краснодар, ул. Калинина, 13',
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        onPressed: _incrementCounter,
                        tooltip: 'Increment',
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(children: [
                    IconButton(
                      //2 след строчки убирают лишний padding между иконкой и текстом
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.phone, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          _makePhoneCall('tel:0597924917');
                        });
                      },
                    ),
                    Text(
                      'Позвонить',
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.location_on, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          MapUtils.openMap(45.050329, 38.920740);
                        });
                      },
                    ),
                    Text(
                      'Маршрут',
                      style: TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ]),
                ),
                Expanded(
                    child: Column(children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    icon: Icon(Icons.share, color: Colors.green),
                    onPressed: () {
                      setState(() {
                        Share.share(
                            'https://kubsau.ru/entrant/podig/obshchezhitiya/');
                      });
                    },
                  ),
                  Text(
                    'Поделиться',
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  ),
                ])),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Text(
                'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что состав-ляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в об-щежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направ-лена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требова-ниям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных за-лов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю ра-боту по самообслуживанию.»',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        )),
      ),
    );
  }
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
