import 'package:flutter/material.dart';
import 'package:quotes/quote_model.dart';
import 'package:quotes/quotes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyAppState(),
        child: MaterialApp(
          title: 'Quotes App',
          home: const HomePage(),
        ));
  }
}

class MyAppState extends ChangeNotifier {
  var current = Quotes.getRandom();

  void getNext() {
    current = Quotes.getRandom();
    notifyListeners();
  }

  var favourites = [];

  void toggleFavorites() {
    if (favourites.contains(current)) {
      favourites.remove(current);
    } else {
      favourites.add(current);
    }
    notifyListeners();
  }

  void removeFavorites(quote) {
    favourites.remove(quote);
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_currentPage) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = favoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $_currentPage');
    }
    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
          ],
          currentIndex: _currentPage,
          onTap: (int inIndex) {
            setState(() {
              _currentPage = inIndex;
            });
          }),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var current = appState.current;
    var favorites = appState.favourites;

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onDoubleTap: () {
              appState.toggleFavorites();
            },
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => quoteDetails(quote: current)));
            },
            child: BigCard(current: current)),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            )
          ],
        )
      ],
    )));
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.current,
  });

  final Quote current;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 17,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            current.getContent(),
          )),
    );
  }
}

class favoritesPage extends StatelessWidget {
  const favoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favorites = appState.favourites;

    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet!'),
      );
    } else {
      return ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('You have ${favorites.length} favorite(s)')),
          for (var quote in favorites)
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text(quote.getContent()),
              onTap: () {
                appState.removeFavorites(quote);
              },
            )
        ],
      );
    }
  }
}

class quoteDetails extends StatelessWidget {
  const quoteDetails({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(quote.getContent()),
        Text(quote.getAuthor()),
        for (var tag in quote.getTags()) Text(tag),
      ],
    ));
  }
}
