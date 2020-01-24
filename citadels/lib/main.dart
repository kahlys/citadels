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
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
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
              body: _displayList(_displayPalyerItem),
              floatingActionButton: new FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: _addPlayerLayout,
                tooltip: 'Add player',
                child: new Icon(Icons.add),
              ),
            ),
            // Icon(Icons.directions_car),
            Scaffold(body: _displayList(_displayDistrictItem)),
            Scaffold(body: Text("wip")),
            Scaffold(body: Text("wip")),
            Scaffold(body: _displayList(_displayResultItem)),
          ],
        ),
      ),
    );
  }

  Widget _displayList(Widget Function(Player, int) itemsFunc) {
    return new Container(
      margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index >= players.length) {
            return null;
          }
          Player player = players[index];
          return itemsFunc(player, index);
        },
      ),
    );
  }

  Widget _displayPalyerItem(Player player, int index) {
    return new Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: new Text(player.name),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayDistrictItem(Player player, int index) {
    return new Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: new Text(player.name),
            ),
            flex: 3,
          ),
          Expanded(
            child: ListTile(
              title: new TextField(
                controller: TextEditingController(
                  text: player.scoreDistrict.toString(),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (val) {
                  setState(() {
                    player.scoreDistrict = int.parse(val);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayResultItem(Player player, int index) {
    return new Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: new Text(player.name),
            ),
            flex: 3,
          ),
          Expanded(
            child: ListTile(
              title: new Text(player.score().toString()),
            ),
            flex: 1,
          ),
        ],
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

  void _addPlayer(String name) {
    players.add(Player(name));
  }
}

class Player {
  String name;
  int scoreDistrict = 0;
  int scoreColor = 0;
  int scoreCity = 0;

  Player(String name) {
    this.name = name;
  }

  int score() {
    return this.scoreDistrict + this.scoreColor + this.scoreCity;
  }
}
