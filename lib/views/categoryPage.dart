// import 'package:engin/service/gameService.dart';
// import 'package:flutter/material.dart';
// import 'package:engin/model/game_Model.dart';
// import 'package:google_fonts/google_fonts.dart'; // import your game model here
//
// class CategoryPage extends StatefulWidget {
//   const CategoryPage({Key? key}) : super(key: key);
//
//   @override
//   State<CategoryPage> createState() => _CategoryPageState();
// }
//
// class _CategoryPageState extends State<CategoryPage> {
//   // Define a list of game categories
//   List<String> _categories = ['Action', 'Adventure', 'RPG', 'Sports', 'Strategy'];
//
//   // Define a list of games for each category
//   Map<String, List<Game>> _games = {
//     'Action': [],
//     'Adventure': [],
//     'RPG': [],
//     'Sports': [],
//     'Strategy': [],
//   };
//
//   // Load the games for each category when the widget is created
//   @override
//   void initState() {
//     super.initState();
//     _loadGames();
//   }
//
//   // Load the games for each category from your API
//   void _loadGames() async {
//     // Load games for each category and update the _games map
//     // You can use your GameService to load the games from your API
//     setState(() async {
//       _games['Action'] = await GameService.searchGames('action');
//       _games['Adventure'] = await GameService.searchGames('adventure');
//       _games['RPG'] = await GameService.searchGames('rpg');
//       _games['Sports'] = await GameService.searchGames('sports');
//       _games['Strategy'] = await GameService.searchGames('strategy');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Define a grid view to display the game categories and their games
//     return GridView.count(
//       crossAxisCount: 2, // Display 2 categories per row
//       padding: const EdgeInsets.all(10),
//       mainAxisSpacing: 10,
//       crossAxisSpacing: 10,
//       children: _categories.map((category) {
//         return Column(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: (){},
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     image: DecorationImage(
//                       image: AssetImage('assets/$category.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       category,
//                       style: GoogleFonts.poppins(
//                         fontSize: 24,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }
//
//
// }

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
  List<String> _categories = ['Action', 'Adventure', 'RPG', 'Sports', 'Strategy'];

  // Define a map to store the games for each category
  Map<String, List<Game>> _games = {
    'Action': [],
    'Adventure': [],
    'RPG': [],
    'Sports': [],
    'Strategy': [],
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define a grid view to display the game categories and their games
    return GridView.count(
      crossAxisCount: 2, // Display 2 categories per row
      padding: const EdgeInsets.all(10),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: _categories.map((category) {
        // Return a InkWell instead of a Column to make the grid tile tappable
        return InkWell(
          onTap: () {
            // Navigate to a new page to show the games for the selected category
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
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/$category.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
