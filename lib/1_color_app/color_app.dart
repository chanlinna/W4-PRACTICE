import 'package:flutter/material.dart';
import 'package:w4_practice/1_color_app/services/color_service.dart';

final colorService = ColorService();

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue, green, yellow, brown, purple, grey, pink }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: ListenableBuilder(
        listenable: colorService,
        builder: (context, child) {
          return ListView(
            padding: EdgeInsets.all(10),
            children: CardType.values.map((type) {
              return ColorTap(type: type);
            }).toList(),
          );
        },
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor {
    switch (type) {
      case CardType.red:
        return Colors.red;
      case CardType.blue:
        return Colors.blue;
      case CardType.green:
        return Colors.green;
      case CardType.yellow:
        return Colors.yellow;
      case CardType.brown:
        return Colors.brown;
      case CardType.purple:
        return Colors.purple;
      case CardType.grey:
        return Colors.grey;
      case CardType.pink:
        return Colors.pink;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tapCount = colorService.tapCounts[type]!;

    return GestureDetector(
      onTap: () => colorService.incrementCount(type),
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: ListenableBuilder(
          listenable: colorService,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: CardType.values.map((type) {
                return Text(
                  '${type.name} Taps: ${colorService.tapCounts[type]}',
                  style: const TextStyle(fontSize: 24),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
