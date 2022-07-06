import 'package:flutter/material.dart';
import 'package:macoss/assets.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:io';
import 'dart:convert';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callsocket();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: width == 700
          ? Icon(
              Icons.menu,
              color: Color(0xffFFFFFF),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Color(0xff340F35),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        elevation: 0,
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Row(
        children: [
          width >= 1000
              ? Container(
                  width: width * 0.03,
                  height: double.infinity,
                  color: Color(0xff3E113F),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        'assets/images/organization.png',
                        height: 32,
                        width: 32,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Icon(
                        Icons.add,
                        color: Color(0xffFFFFFF),
                      )
                    ],
                  ))
              : Container(),
          Container(
            width: width * 0.3,
            color: Color(0xff3E113F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Organization",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 32,
                        color: Color(0xffFFFFFF),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 84, 23, 86),
                ),
                item("All unreads", union),
                item("Threads", thrad_ic),
                item("All DMs", alldms),
                item("Mentions & reactions", tags),
                item("More", more_ic),
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

item(String text, String icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0),
    child: Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              icon,
              height: 12,
              width: 12,
            ),
          ),
          Expanded(
            flex: 10,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
                color: Color(0xffFFFFFF),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

callsocket() {
  print("called socket");
  Socket socket = io('http://192.168.0.115', <String, dynamic>{});
  socket.onConnect((_) {
    print('connect');
  });
  socket.onDisconnect((_) => print('disconnect'));
}
