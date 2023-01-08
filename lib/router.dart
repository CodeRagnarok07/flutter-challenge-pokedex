import 'package:flutter/material.dart';
import 'package:pokedex/views/List/main.dart';

class Navegator extends StatefulWidget {
  const Navegator({Key? key}) : super(key: key);

  @override
  _NavegatorState createState() => _NavegatorState();
}

class _NavegatorState extends State<Navegator> {
  int indexTap = 0;
  final List<Widget> widgetsChildren = [
    // ProfileTrips(),
    ViewPokemonList(),
    ViewPokemonList()
  ];

  void onTapTapped(int index) {
    setState(() {
      indexTap = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const home = BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'home',
    );

    return Scaffold(
        body: widgetsChildren[indexTap],
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(canvasColor: Colors.white, primaryColor: Colors.purple),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: onTapTapped,
              currentIndex: indexTap,
              items: const [
                home,
                home,
                // search,
                // account_circle,
              ]),
        ));
  }
}
