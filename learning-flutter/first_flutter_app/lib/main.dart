import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "new_page": (context) => NewRoute(),
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page',),
        "para_page": (context) => ParamRoute()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '你已经点击了:',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
            Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display4,
            ),
            FlatButton(
              child: Text('open new route'),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
//                Navigator.push(context, MaterialPageRoute(
//                  builder: (context) {
//                    return NewRoute();
//                  },
//                  fullscreenDialog: false,
//                ));
              },
            ),
            RaisedButton(
              onPressed: () async {
                var result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context){
                      return TipRoute(text: "我是提示",);
                    }
                  )
                );
                print("路由返回信息$result");
              },
              child: Text('打开提示页'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed("para_page", arguments: 'shibaoxu');
              },
              child: Text("Para Page"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text('This is new route.'),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key,
    @required this.text
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('提示'),),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text),
              RaisedButton(
                onPressed: ()=> Navigator.pop(context, "我是返回值"),
                child: Text('返回'),
              )
            ],
          )
        ),
      ),
    );
  }
}

class ParamRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('参数化route')),
      body: Center(
        child: Text('我是$args'),
      ),
    );
  }
}
