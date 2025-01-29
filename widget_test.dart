import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/main.dart'; // Substitua 'myapp' pelo nome correto do seu app

void main() {
  testWidgets('Testando a funcionalidade da calculadora', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final button1 = find.text('1');
    final button2 = find.text('2');
    final buttonAdd = find.text('+');
    final buttonEquals = find.text('=');
    final resultDisplay = find.textContaining('0');

    expect(button1, findsOneWidget);
    expect(button2, findsOneWidget);
    expect(buttonAdd, findsOneWidget);
    expect(buttonEquals, findsOneWidget);
    expect(resultDisplay, findsWidgets);

    await tester.tap(button1);
    await tester.pump();
    await tester.tap(buttonAdd);
    await tester.pump();
    await tester.tap(button2);
    await tester.pump();
    await tester.tap(buttonEquals);
    await tester.pump();

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Testando o botão de limpar (C)', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final button1 = find.text('1');
    final buttonClear = find.text('C');
    final resultDisplay = find.textContaining('0');

    await tester.tap(button1);
    await tester.pump();
    expect(find.textContaining('1'), findsOneWidget);

    await tester.tap(buttonClear);
    await tester.pump();
    expect(resultDisplay, findsWidgets);
  });

  testWidgets('Testando divisões por zero', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final button1 = find.text('1');
    final buttonDivide = find.text('/');
    final button0 = find.text('0');
    final buttonEquals = find.text('=');

    await tester.tap(button1);
    await tester.pump();
    await tester.tap(buttonDivide);
    await tester.pump();
    await tester.tap(button0);
    await tester.pump();
    await tester.tap(buttonEquals);
    await tester.pump();

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('Testando inserir ponto e soma', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final button1 = find.text('1');
    final buttonDot = find.text('.');
    final buttonPlus = find.text('+');
    final button2 = find.text('2');
    final buttonEquals = find.text('=');

    await tester.tap(button1);
    await tester.pump();
    await tester.tap(buttonDot);
    await tester.pump();
    await tester.tap(button1);
    await tester.pump();
    await tester.tap(buttonPlus);
    await tester.pump();
    await tester.tap(button2);
    await tester.pump();
    await tester.tap(buttonEquals);
    await tester.pump();

    expect(find.text('3.1'), findsOneWidget);
  });

  testWidgets('Testando inserir dois pontos seguidos', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final button1 = find.text('1');
    final buttonDot = find.text('.');
    final buttonEquals = find.text('=');

    await tester.tap(button1);
    await tester.pump();
    await tester.tap(buttonDot);
    await tester.pump();
    await tester.tap(buttonDot);
    await tester.pump();
    await tester.tap(buttonEquals);
    await tester.pump();

    expect(find.text('1.'), findsOneWidget);
  });

  testWidgets('Testando operadores sem número antes', (WidgetTester tester) async {
    await tester.pumpWidget(const CalculatorApp());

    final List<Map<String, String>> tests = [
      {'op': '+', 'expected': 'Error'},
      {'op': '-', 'expected': 'Error'},
      {'op': '*', 'expected': 'Error'},
      {'op': '/', 'expected': 'Error'},
    ];

    for (var test in tests) {
      final buttonOp = find.text(test['op']!);
      final buttonEquals = find.text('=');

      await tester.tap(buttonOp);
      await tester.pump();
      await tester.tap(buttonEquals);
      await tester.pump();

      expect(find.text(test['expected']!), findsOneWidget);
    }
  });
}
