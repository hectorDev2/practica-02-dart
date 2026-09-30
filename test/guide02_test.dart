import '../bin/main.dart';

void expectEqual<T>(T actual, T expected, String description) {
  if (actual != expected) {
    throw StateError('$description: esperado $expected, obtenido $actual');
  }
}

void expectListEqual<T>(List<T> actual, List<T> expected, String description) {
  if (actual.length != expected.length ||
      !actual.asMap().entries.every(
        (entry) => entry.value == expected[entry.key],
      )) {
    throw StateError('$description: esperado $expected, obtenido $actual');
  }
}

void main() {
  final merged = mergeSortedLists(
    listToLinkedList([1, 2, 4]),
    listToLinkedList([1, 3, 4]),
  );
  expectListEqual(linkedListToList(merged), [
    1,
    1,
    2,
    3,
    4,
    4,
  ], 'List combina listas ordenadas');
  expectListEqual(
    linkedListToList(mergeSortedLists(null, listToLinkedList([0]))),
    [0],
    'List soporta una lista vacía',
  );

  expectListEqual(intersectWithMultiplicity([1, 2, 2, 1], [2, 2]), [
    2,
    2,
  ], 'Map conserva multiplicidades');
  expectListEqual(intersectWithMultiplicity([4, 9, 5], [9, 4, 9, 8, 4]), [
    9,
    4,
  ], 'Map no repite más veces de lo permitido');

  expectEqual(
    countUnplacedFruitTypes([4, 2, 5], [3, 5, 4]),
    1,
    'Set resuelve el ejemplo 1',
  );
  expectEqual(
    countUnplacedFruitTypes([3, 6, 1], [6, 4, 7]),
    0,
    'Set resuelve el ejemplo 2',
  );
  expectEqual(
    countUnplacedFruitTypes([5, 5], [5, 5]),
    0,
    'Set distingue cestas con igual capacidad',
  );

  print('Todas las pruebas de la guía 02 pasaron correctamente.');
}
