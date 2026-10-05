import 'package:flutter/material.dart';

void main() => runApp(const CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  const CalculadoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const AppHomePage(),
    );
  }
}

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [ProfilePage(), CalculadoraPage()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calculadora',
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarjeta de Perfil'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.indigo.shade200,
                  child: const Icon(Icons.person, size: 70, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ada Lovelace',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ingeniería Informática',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const Divider(height: 32),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ProfileStat(value: '120', label: 'Proyectos'),
                    _ProfileStat(value: '4.8', label: 'Rating'),
                    _ProfileStat(value: '5+', label: 'Años'),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                  label: const Text('Enviar mensaje'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  String _expression = '';
  String _result = '0';

  bool get _hasOperator => RegExp(r'[+\-×÷]').hasMatch(_expression);

  Color get _resultColor {
    final value = double.tryParse(_result);
    if (value == null || value == 0) return Colors.grey;
    return value > 0 ? Colors.blue : Colors.red;
  }

  void _clear() => setState(() {
        _expression = '';
        _result = '0';
      });

  void _press(String value) {
    if (value == 'C') return _clear();
    if (value == '=') return _calculate();

    setState(() {
      if (value == '.') {
        final current = _expression.split(RegExp(r'[+\-×÷]')).last;
        if (current.contains('.')) return;
        if (current.isEmpty) _expression += '0';
      }

      if (RegExp(r'[+\-×÷]').hasMatch(value)) {
        if (_expression.isEmpty) return;
        if (RegExp(r'[+\-×÷]$').hasMatch(_expression)) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      }
      _expression += value;
    });
  }

  void _calculate() {
    if (_expression.isEmpty || !_hasOperator) return;
    try {
      final value = _evaluate(_expression);
      setState(() => _result = _format(value));
    } catch (_) {
      setState(() => _result = 'Error');
    }
  }

  double _evaluate(String expression) {
    final tokens = RegExp(r'(\d+(?:\.\d+)?)|([+\-×÷])')
        .allMatches(expression)
        .map((match) => match.group(0)!)
        .toList();
    if (tokens.length < 3 || tokens.length.isEven) throw FormatException();

    var total = 0.0;
    var term = double.parse(tokens.first);
    for (var i = 1; i < tokens.length; i += 2) {
      final operation = tokens[i];
      final next = double.parse(tokens[i + 1]);
      if (operation == '×') {
        term *= next;
      } else if (operation == '÷') {
        if (next == 0) throw UnsupportedError('No se puede dividir entre cero');
        term /= next;
      } else {
        total += term;
        term = operation == '+' ? next : -next;
      }
    }
    return total + term;
  }

  String _format(double value) {
    if (value == value.roundToDouble()) return value.toInt().toString();
    return value.toStringAsFixed(6).replaceFirst(RegExp(r'0+$'), '');
  }

  @override
  Widget build(BuildContext context) {
    const buttons = [
      '7', '8', '9', '÷',
      '4', '5', '6', '×',
      '1', '2', '3', '-',
      'C', '0', '.', '+',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora Flutter')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_expression, style: const TextStyle(fontSize: 28)),
                    Text(
                      _result,
                      style: TextStyle(
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                        color: _resultColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 4,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ...buttons.map(
                    (button) => _CalculatorButton(
                      label: button,
                      onPressed: () => _press(button),
                    ),
                  ),
                  _CalculatorButton(label: '=', onPressed: _calculate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _CalculatorButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 22)),
    );
  }
}
