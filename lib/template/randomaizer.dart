import 'dart:math';

class Randomizer{
  static int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(900000) + 100000;
  }
}