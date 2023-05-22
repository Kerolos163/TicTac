import 'package:flutter/material.dart';

import 'game_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String activeplayer = "X";
  bool gameover = false;
  int turn = 0;
  String result = "";
  Game game = Game();
  bool isswitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  children: [
                    ...farstblock(),
                    _expanded(context),
                    ...lastblock()
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ...farstblock(),
                          const SizedBox(height: 50,),
                          ...lastblock()
                        ],
                      ),
                    ),
                    _expanded(context),
                  ],
                )),
    );
  }

  List<Widget> farstblock() {
    return [
      SwitchListTile.adaptive(
        value: isswitched,
        onChanged: (value) {
          setState(() {
            isswitched = value;
          });
        },
        title: const Text(
          "Turn on/off two Player ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 31,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const SizedBox(height: 50,),
      Text(
        "It's $activeplayer Turn".toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 50,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30,),
    ];
  }

  List<Widget> lastblock() {
    return [
      Text(
        result,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 10,
      ),
      TextButton.icon(
          onPressed: () {
            setState(() {
              Player.PlayerX = [];
              Player.PlayerO = [];
              activeplayer = "X";
              gameover = false;
              turn = 0;
              result = "";
            });
          },
          icon: const Icon(Icons.replay, color: Colors.white),
          label: const Text(
            "Repeat The Game !",
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).splashColor)))
    ];
  }

  Expanded _expanded(BuildContext context) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.0,
      children: List.generate(
          9,
          (index) => InkWell(
                onTap: gameover
                    ? null
                    : () async {
                        if (!Player.PlayerX.contains(index) &&
                            !Player.PlayerO.contains(index)) {
                          game.PlayGame(index, activeplayer);
                          UpDateState();
                          if (!isswitched && !gameover && turn != 9) {
                            game.autoplay(activeplayer);
                            UpDateState();
                          }
                        }
                      },
                borderRadius: BorderRadius.circular(15),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Theme.of(context).shadowColor),
                    child: Center(
                      child: Text(
                        Player.PlayerX.contains(index)
                            ? "X"
                            : Player.PlayerO.contains(index)
                                ? "O"
                                : "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Player.PlayerX.contains(index)
                              ? Colors.blue
                              : Colors.red,
                          fontSize: 65,
                        ),
                      ),
                    )),
              )),
    ));
  }

  void UpDateState() {
    setState(() {
      activeplayer = activeplayer == "X" ? "O" : "X";
      turn++;
      // print(turn);
      if (game.checkwinner() == "X" || game.checkwinner() == "O") {
        gameover = true;
        result = "${game.checkwinner()} is Winner ";
      } else if (!gameover && turn == 9) {
        result = "No Winner";
      }
    });
  }
}
