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
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
                child: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('New Game'),
                        content:
                            new Text('Delete all datas and start a new game ?'),
                        actions: <Widget>[
                          new FlatButton(
                              child: new Text('NO'),
                              onPressed: () => Navigator.of(context).pop()),
                          new FlatButton(
                            child: Text("YES"),
                            onPressed: () {
                              setState(() {
                                players = [];
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }),
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "PLAYERS"),
              Tab(text: 'DISTRICTS'),
              Tab(text: 'COLORS'),
              Tab(text: 'COMPLETE'),
              Tab(text: 'COINS'),
              Tab(text: 'RESULTS'),
            ],
          ),
          title: Text('Citadels'),
        ),
        body: TabBarView(
          children: [
            Scaffold(
              body: _displayList(_displayPlayerItem),
              floatingActionButton: new FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: _addPlayerLayout,
                tooltip: 'Add player',
                child: new Icon(Icons.add),
              ),
            ),
            // Icon(Icons.directions_car),
            Scaffold(body: _displayList(_displayDistrictItem)),
            Scaffold(body: _displayList(_displayColorsItem)),
            Scaffold(body: _displayList(_displayCityItem)),
            Scaffold(body: _displayList(_displayCoinItem)),
            Scaffold(body: _displaySortedList(_displayResultItem)),
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

  Widget _displaySortedList(Widget Function(Player, int) itemsFunc) {
    List<Player> playersSorted = new List.from(players);
    playersSorted.sort((a, b) {
      if (a.score() < b.score()) {
        return 1;
      } else if ((a.score() > b.score())) {
        return -1;
      } else {
        return -Comparable.compare(a.coins, b.coins);
      }
    });
    return new Container(
      margin: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          if (index >= players.length) {
            return null;
          }
          Player player = playersSorted[index];
          return itemsFunc(player, index);
        },
      ),
    );
  }

  Widget _displayPlayerItem(Player player, int index) {
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
              title:Icon(Icons.close),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: new Text('Sure to delete player ?'),
                        actions: <Widget>[
                          new FlatButton(
                              child: new Text('NO'),
                              onPressed: () => Navigator.of(context).pop()),
                          new FlatButton(
                            child: Text("YES"),
                            onPressed: () {
                              setState(() => players.removeAt(index));
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
              },
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

  Widget _displayColorsItem(Player player, int index) {
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
            child: Checkbox(
              value: !(player.scoreColor == 0),
              onChanged: (val) {
                setState(() {
                  if (val) {
                    player.scoreColor = 3;
                  } else {
                    player.scoreColor = 0;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayCityItem(Player player, int index) {
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
            child: Checkbox(
              value: player.hasCompletedFirst(),
              onChanged: (val) {
                setState(() {
                  if (val) {
                    player.scoreCity = 4;
                  } else {
                    player.scoreCity = 0;
                  }
                });
              },
            ),
          ),
          Expanded(
            child: Checkbox(
              value: player.hasCompletedAfter(),
              onChanged: (val) {
                setState(() {
                  if (val) {
                    player.scoreCity = 2;
                  } else {
                    player.scoreCity = 0;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayCoinItem(Player player, int index) {
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
                  text: player.coins.toString(),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (val) {
                  setState(() {
                    player.coins = int.parse(val);
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
    Color backColor = Colors.white;
    switch (index) {
      case 0:
        backColor = Color.fromRGBO(254, 225, 1, 0.2);
        break;
      case 1:
        backColor = Color.fromRGBO(167, 167, 173, 0.2);
        break;
      case 2:
        backColor = Color.fromRGBO(167, 112, 68, 0.2);
        break;
    }

    return new Container(
      color: backColor,
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
                  players.add(Player(val));
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
}

class Player {
  String name;
  int scoreDistrict = 0;
  int scoreColor = 0;
  int scoreCity = 0;
  int coins = 0;

  Player(String name) {
    this.name = name;
  }

  int score() {
    return this.scoreDistrict + this.scoreColor + this.scoreCity;
  }

  bool hasCompletedFirst() {
    return this.scoreCity == 4;
  }

  bool hasCompletedAfter() {
    return this.scoreCity == 2;
  }
}
