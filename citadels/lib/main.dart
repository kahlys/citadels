import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Citadels',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> players = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "PLAYERS"),
              Tab(text: 'DISTRICTS'),
              Tab(text: 'COLORS'),
              Tab(text: 'COMPLETE'),
              Tab(text: 'RESULTS'),
            ],
          ),
          title: Text('Citadels'),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: _displayPlayerTable(),
              floatingActionButton: new FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: _addPlayerLayout,
                tooltip: 'Add player',
                child: new Icon(Icons.add),
              ),
            ),
            // Icon(Icons.directions_car),
            Scaffold(body: Text("wip")),
            Scaffold(body: Text("wip")),
            Scaffold(body: Text("wip")),
            Scaffold(body: Text("wip")),
          ],
        ),
      ),
    );
  }

  Widget _displayPlayerTable() {
    List<TableRow> rows = [];
    rows.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.blue),
        children: [Text("PLAYER"), Text("AGE")],
      ),
    );
    players.forEach((e) {
      rows.add(
        TableRow(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              child: Text(e),
            ),
            Text("-"),
          ],
        ),
      );
    });

    return new Container(
      margin: const EdgeInsets.all(20.0),
      child: Table(children: rows),
    );
  }

  Widget _displayPlayerList() {
    return new Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index >= players.length) {
            return null;
          }
          return _buildTodoItem(players[index], index);
        },
      ),
    );
  }

  Widget _buildTodoItem(String player, int index) {
    return new Container(
      child: new ListTile(
        title: new Text(player),
      ),
    );
  }

  void _addPlayerLayout() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(title: new Text('Add new player')),
            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                setState(() {
                  _addPlayer(val);
                });
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: 'Player name',
                contentPadding: const EdgeInsets.all(16.0),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addPlayer(String title) {
    players.add(title);
  }
}
