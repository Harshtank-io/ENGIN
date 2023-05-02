
import 'package:engin/service/gameService.dart';
import 'package:engin/widget/categoryGameTiles.dart';
import 'package:flutter/material.dart';
import 'package:engin/model/game_Model.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Define a list of game categories
  List<String> _categories = ['Action', 'Adventure', 'RPG', 'Sports', 'Strategy','Puzzle'];

  // Define a map to store the games for each category
  Map<String,List<Game>> _games = {
    'Action': [],
    'Adventure': [],
    'RPG': [],
    'Sports': [],
    'Strategy': [],
    'Puzzle':[],
  };

  // Load the games for each category when the widget is created
  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  // Load the games for each category from your API
  void _loadGames() async {
    // Load games for each category and update the _games map
    // You can use your GameService to load the games from your API
    setState(() async {
      _games['Action'] = await GameService.searchGames('action');
      _games['Adventure'] = await GameService.searchGames('adventure');
      _games['RPG'] = await GameService.searchGames('rpg');
      _games['Sports'] = await GameService.searchGames('sports');
      _games['Strategy'] = await GameService.searchGames('strategy');
      _games['Puzzle'] = await GameService.searchGames('puzzle');
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.5,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 30.0,
      ),
      padding: const EdgeInsets.all(20),
      itemCount: _categories.length,
      itemBuilder: (BuildContext context, int index) {
        final category = _categories[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => categoryGameListPage(
                  games: _games[category]!,
                  category: category,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('lib/assets/$category.jpg'),
                fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.overlay,
                  )
              ),
            ),
            child: Center(
              child: Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
