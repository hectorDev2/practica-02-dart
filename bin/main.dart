/// Práctica 02: List, Map, Set y otros tipos de datos en Dart.

class ListNode {
  ListNode(this.value, [this.next]);

  final int value;
  ListNode? next;
}

/// Une dos listas enlazadas ordenadas en una única lista ordenada.
///
/// Se reutilizan los nodos originales; no se crean copias de cada elemento.
ListNode? mergeSortedLists(ListNode? first, ListNode? second) {
  final dummy = ListNode(0);
  var tail = dummy;

  while (first != null && second != null) {
    if (first.value <= second.value) {
      tail.next = first;
      first = first.next;
    } else {
      tail.next = second;
      second = second.next;
    }
    tail = tail.next!;
  }

  tail.next = first ?? second;
  return dummy.next;
}

ListNode? listToLinkedList(List<int> values) {
  ListNode? head;
  ListNode? tail;

  for (final value in values) {
    final node = ListNode(value);
    if (head == null) {
      head = node;
    } else {
      tail!.next = node;
    }
    tail = node;
  }

  return head;
}

List<int> linkedListToList(ListNode? head) {
  final values = <int>[];
  for (var node = head; node != null; node = node.next) {
    values.add(node.value);
  }
  return values;
}

/// Devuelve la intersección conservando la cantidad de apariciones comunes.
List<int> intersectWithMultiplicity(List<int> nums1, List<int> nums2) {
  final available = <int, int>{};
  for (final value in nums1) {
    available[value] = (available[value] ?? 0) + 1;
  }

  final intersection = <int>[];
  for (final value in nums2) {
    final count = available[value] ?? 0;
    if (count > 0) {
      intersection.add(value);
      available[value] = count - 1;
    }
  }
  return intersection;
}

/// Cuenta los tipos de fruta que no pudieron ser colocados.
///
/// Se utiliza un Set para registrar los índices de cestas ya ocupadas. Así se
/// conserva la identidad de cada cesta aunque dos tengan igual capacidad.
int countUnplacedFruitTypes(List<int> fruits, List<int> baskets) {
  final occupiedBaskets = <int>{};
  var unplaced = 0;

  for (final fruitAmount in fruits) {
    var placed = false;
    for (var basketIndex = 0; basketIndex < baskets.length; basketIndex++) {
      if (!occupiedBaskets.contains(basketIndex) &&
          baskets[basketIndex] >= fruitAmount) {
        occupiedBaskets.add(basketIndex);
        placed = true;
        break;
      }
    }
    if (!placed) {
      unplaced++;
    }
  }

  return unplaced;
}

void demonstratePrimitiveTypes() {
  print('== Tipos primitivos y null safety ==');
  const int integer = 42;
  const double decimal = 3.14;
  const String language = 'Dart';
  const bool isCompiled = true;
  dynamic dynamicValue = 'texto';
  dynamicValue = 2026;
  const inferred = 'var infiere el tipo en compilación';
  String? nullableName;
  final displayName = nullableName ?? 'Sin nombre';

  print('int: $integer | double: $decimal | String: $language');
  print('bool: $isCompiled | dynamic: $dynamicValue');
  print('var: $inferred | nullable: $displayName');
}

void demonstrateCollections() {
  print('\n== List ==');
  final students = <String>['Ana', 'Luis', 'María', 'Carlos'];
  students.add('Pedro');
  final longNames = students.where((student) => student.length > 4).toList();
  final uppercaseNames = students
      .map((student) => student.toUpperCase())
      .toList();
  final sortedStudents = [...students]..sort();
  print('Original: $students');
  print('where (> 4): $longNames');
  print('map (mayúsculas): $uppercaseNames');
  print('sort: $sortedStudents');

  print('\n== Map ==');
  final prices = <String, double>{'Manzana': 2.50, 'Pera': 3.00, 'Uva': 5.50};
  prices.putIfAbsent('Mango', () => 4.75);
  prices.update('Pera', (price) => price * 1.1);
  final affordable = Map.fromEntries(
    prices.entries.where((entry) => entry.value < 4),
  );
  print('Precios: $prices');
  print('Menores de S/. 4.00: $affordable');

  print('\n== Set ==');
  final firstSet = <int>{1, 2, 3, 4, 5};
  final secondSet = <int>{4, 5, 6, 7, 8};
  print('Unión: ${firstSet.union(secondSet)}');
  print('Intersección: ${firstSet.intersection(secondSet)}');
  print('Diferencia: ${firstSet.difference(secondSet)}');
}

void demonstrateOtherTypes() {
  print('\n== Otros tipos ==');
  final heart = String.fromCharCodes(Runes('\u2764'));
  final point = (10.0, 20.0);
  final person = (name: 'Ana', age: 25);
  print('Runes: $heart | Record posicional: (${point.$1}, ${point.$2})');
  print('Record nombrado: ${person.name}, ${person.age} años');
}

void demonstrateExercises() {
  print('\n== Ejercicios de la guía ==');

  final merged = mergeSortedLists(
    listToLinkedList([1, 2, 4]),
    listToLinkedList([1, 3, 4]),
  );
  print('List - listas combinadas: ${linkedListToList(merged)}');

  print(
    'Map - intersección: '
    '${intersectWithMultiplicity([1, 2, 2, 1], [2, 2])}',
  );

  print(
    'Set - frutas sin colocar: '
    '${countUnplacedFruitTypes([4, 2, 5], [3, 5, 4])}',
  );
}

void main() {
  demonstratePrimitiveTypes();
  demonstrateCollections();
  demonstrateOtherTypes();
  demonstrateExercises();
}
