import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> PlayerX = [];
  static List<int> PlayerO = [];
}

extension ContainsAll on List {
  containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    } else {
      return contains(x) && contains(y) && contains(z);
    }
  }
}

class Game {
  void PlayGame(int index, String activeplayer) {
    if (activeplayer == "X") {
      Player.PlayerX.add(index);
    } else {
      Player.PlayerO.add(index);
    }
  }

  String checkwinner() {
    String winner = "";
    if (Player.PlayerX.containsAll(0, 1, 2) ||
        Player.PlayerX.containsAll(3, 4, 5) ||
        Player.PlayerX.containsAll(6, 7, 8) ||
        Player.PlayerX.containsAll(0, 3, 6) ||
        Player.PlayerX.containsAll(1, 4, 7) ||
        Player.PlayerX.containsAll(2, 5, 8) ||
        Player.PlayerX.containsAll(0, 4, 8) ||
        Player.PlayerX.containsAll(2, 4, 6)) {
      winner = "X";
    } else if (Player.PlayerO.containsAll(0, 1, 2) ||
        Player.PlayerO.containsAll(3, 4, 5) ||
        Player.PlayerO.containsAll(6, 7, 8) ||
        Player.PlayerO.containsAll(0, 3, 6) ||
        Player.PlayerO.containsAll(1, 4, 7) ||
        Player.PlayerO.containsAll(2, 5, 8) ||
        Player.PlayerO.containsAll(0, 4, 8) ||
        Player.PlayerO.containsAll(2, 4, 6)) {
      winner = "O";
    } else {
      winner = "";
    }

    return winner;
  }

  Future autoplay(String activeplayer) async {
    int index = 0;
    List emptycells = [];
    for (var i = 0; i < 9; i++) {
      if (!Player.PlayerX.contains(i) && !Player.PlayerO.contains(i)) {
        emptycells.add(i);
      }
    }
    if(Player.PlayerO.containsAll(0, 1) && emptycells.contains(2)) {
      index = 2;
    } else if (Player.PlayerO.containsAll(3, 4) && emptycells.contains(5)) {
      index = 5;
    } else if (Player.PlayerO.containsAll(6, 7) && emptycells.contains(8)) {
      index = 8;
    } else if (Player.PlayerO.containsAll(0, 3) && emptycells.contains(6)) {
      index = 6;
    } else if (Player.PlayerO.containsAll(1, 4) && emptycells.contains(7)) {
      index = 7;
    } else if (Player.PlayerO.containsAll(2, 5) && emptycells.contains(8)) {
      index = 8;
    } else if (Player.PlayerO.containsAll(0, 4) && emptycells.contains(8)) {
      index = 8;
    } else if (Player.PlayerO.containsAll(2, 4) && emptycells.contains(6)) {
      index = 6;
    }
    else if   (Player.PlayerO.containsAll(0,2) && emptycells.contains(1)) {
      index = 1;
    } else if (Player.PlayerO.containsAll(3,5) && emptycells.contains(4)) {
      index = 4;
    } else if (Player.PlayerO.containsAll(6,8) && emptycells.contains(7)) {
      index = 7;
    } else if (Player.PlayerO.containsAll(0,6) && emptycells.contains(3)) {
      index = 3;
    } else if (Player.PlayerO.containsAll(1,7) && emptycells.contains(4)) {
      index = 4;
    } else if (Player.PlayerO.containsAll(2,8) && emptycells.contains(5)) {
      index = 5;
    } else if (Player.PlayerO.containsAll(0,8) && emptycells.contains(4)) {
      index = 4;
    } else if (Player.PlayerO.containsAll(2,6) && emptycells.contains(4)) {
      index = 4;
    }
    else if   (Player.PlayerO.containsAll(1,2) && emptycells.contains(0)) {
      index = 1;
    } else if (Player.PlayerO.containsAll(4,5) && emptycells.contains(3)) {
      index = 4;
    } else if (Player.PlayerO.containsAll(7,8) && emptycells.contains(6)) {
      index = 7;
    } else if (Player.PlayerO.containsAll(3,6) && emptycells.contains(0)) {
      index = 3;
    } else if (Player.PlayerO.containsAll(4,7) && emptycells.contains(1)) {
      index = 4;
    } else if (Player.PlayerO.containsAll(5,8) && emptycells.contains(2)) {
      index = 5;
    } else if (Player.PlayerO.containsAll(4,8) && emptycells.contains(0)) {
      index = 4;
    } else if (Player.PlayerO.containsAll(4,6) && emptycells.contains(2)) {
      index = 4;
    }
    else{
    Random random = Random();
    int randomindex = random.nextInt(emptycells.length);
    index = emptycells[randomindex];
    }

    PlayGame(index, activeplayer);
  }
}
