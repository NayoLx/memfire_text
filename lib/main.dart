import 'package:flutter/material.dart';
import 'package:memfire_text/utils/helper.dart';
import 'package:supabase/supabase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = 'You have pushed the button this many times:';
  late SupabaseClient _client;
  TextEditingController _name = TextEditingController();
  TextEditingController _desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    MemFireHelper();
    _client = MemFireHelper.client;
    select();
  }

  void select() async {
    final user = await _client.from('${MemFireHelper.user}').select().execute();
    if (user.data != null) {
      text = 'user is not null';
      print('user is not null');
    } else {
      text = 'no datebase';
    }
    setState(() {});
  }

  void addDoc() async {
    if (_name.text.isNotEmpty == false) {
      text = '姓名不能为空';
      setState(() {});
      return;
    }

    if (_desc.text.isNotEmpty == false) {
      text = '描述不能为空';
      setState(() {});
      return;
    }

    final count = await _client.from('${MemFireHelper.doc}').select().execute();
    final doc = await _client.from('${MemFireHelper.doc}').insert({
      'id': (count.data as List<dynamic>).length + 1,
      'created_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'updated_at': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'name': _name.text,
      'desc': _desc.text
    }).execute();
    if (doc.error == null) {
      text = 'add success';
      _name.text = '';
      _desc.text = '';
    } else {
      text = '${doc.error}';
    }
    setState(() {});
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
            Text('tip: $text'),
            TextField(
              controller: _name,
            ),
            TextField(
              controller: _desc,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addDoc,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
