import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomPage(),
    );
  }
}

class MyHomPage extends StatefulWidget {
  @override
  _MyHomPageState createState() => _MyHomPageState();
}

class _MyHomPageState extends State<MyHomPage> {
  @override
  Widget build(BuildContext context) {
    var food = [
      Sales("Sun", 50, Colors.red),
      Sales("Mon", 70, Colors.green),
      Sales("Tue", 100, Colors.blue),
      Sales("Wed", 60, Colors.yellow),
      Sales("Thu", 150, Colors.pink),
      Sales("Fri", 190, Colors.purple),
      Sales('Sat', 80, Colors.orange)
    ];

    var nonfood = [
      Sales("Sun", 80, Colors.red[300]),
      Sales("Mon", 100, Colors.green[300]),
      Sales("Tue", 110, Colors.blue[300]),
      Sales("Wed", 90, Colors.yellow[300]),
      Sales("Thu", 180, Colors.pink[300]),
      Sales("Fri", 250, Colors.purple[300]),
      Sales('Sat', 170, Colors.orange[300])
    ];

    var series = [
      charts.Series(
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sold,
        colorFn: (Sales sales, _) => sales.color,
        id: 'Sales',
        data: food,
        labelAccessorFn: (Sales sales, _) => '${sales.day} : ${sales.sold}',
      ),
      charts.Series(
        domainFn: (Sales sales, _) => sales.day,
        measureFn: (Sales sales, _) => sales.sold,
        colorFn: (Sales sales, _) => sales.color,
        id: 'Sales',
        data: nonfood,
        labelAccessorFn: (Sales sales, _) => '${sales.day} : ${sales.sold}',
      )
    ];
    

    var chart = charts.BarChart(
      series,
      vertical: false,
      barGroupingType: charts.BarGroupingType.stacked,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );

    var pieChart = charts.PieChart(
      series,
      defaultRenderer: charts.ArcRendererConfig(
          arcRendererDecorators: [charts.ArcLabelDecorator()],
          arcWidth: 100),
      animate: true,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Flutter Chart')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Text(
              'Sistem Analys',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 400,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }
}

class Sales {
  final String day;
  final int sold;
  final charts.Color color;

  Sales(this.day, this.sold, Color color):
  this.color=charts.Color(r:color.red, g:color.green, b:color.blue, a: color.alpha);
}
