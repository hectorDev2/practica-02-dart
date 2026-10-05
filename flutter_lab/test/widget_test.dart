import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_lab/main.dart';

void main() {
  testWidgets('La calculadora se renderiza', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CalculadoraApp());
    await tester.pumpAndSettle();

    expect(find.text('Tarjeta de Perfil'), findsOneWidget);
    await tester.tap(find.text('Calculadora'));
    await tester.pumpAndSettle();
    expect(find.byType(GridView), findsOneWidget);
  });
}
