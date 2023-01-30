import 'dart:math';

import 'Dog.dart';


main() {
  final dogs = <Dog>[];
  for (int i = 0; i < 64000; i++) {
    dogs.add(Dog());
  }
  int m = 0;
  Random random = Random();
  for (Dog dog in dogs) {
    dog.weight = random.nextInt(57) + 3;
  }
  final fleet = <List<Dog>>[];
  for (int i = 0; i < 4096; i++) {
    fleet.add(List.filled(16, Dog(), growable: true));
    for (int j = 0; j < 16; j++) {
      fleet[i][j] = dogs[m];
      m++;
      if (m >= 64000) break;
    }
    if (m >= 64000) break;
  }

  for (int i = 0; i < 4096; i++) {
    int sum1 = 0;
    int sum2 = 0;
    int min = fleet[i][0].weight;
    int minIndex = 0;
    if ( i == 4095) {
      fleet[4095].forEach((dog) => sum1 = dog.weight + sum1);
      fleet[0].forEach((dog) => sum2 = dog.weight + sum1);
    }
    else {
      fleet[i].forEach((dog) => sum1 = dog.weight + sum1);
      fleet[i + 1].forEach((dog) => sum2 = dog.weight + sum2);
    }
    while (sum1 - sum2 >= 200) {
      sum1 = 0;
      sum2 = 0;
      for (int j = 0; j < 16; j++) {
        if (fleet[i][j].weight < min) {
          min = fleet[i][j].weight;
          minIndex = j;
        }
      }
      fleet[i].removeAt(minIndex);
      fleet[i + 1].add(Dog(weight: min));
      fleet[i].forEach((dog) => sum1 = dog.weight + sum1);
      fleet[i + 1].forEach((dog) => sum2 = dog.weight + sum2);
    }
    if ((i == 0) && (i == 99) && (i == 999) && (i == 4051)) {
      fleet[i].forEach((dog) => sum1 = dog.weight + sum1);
      print(sum1);
    }

  }
}
