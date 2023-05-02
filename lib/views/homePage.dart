import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:engin/model/game_Model.dart';
import 'package:engin/service/gameService.dart';
import 'package:engin/views/GameDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Game> games = [];
  //Result result = ame.result[];
  late Future<List<Game>> gameFuture;
  int currentindex =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGames();
  }

  void fetchGames() {
    gameFuture = GameService.getGameList();
    gameFuture.then((fetchedGames) {
      setState(() {
        games.addAll(fetchedGames);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100]
      ),
      child: FutureBuilder<List<Game>>(
        future:  gameFuture,
        builder: (context , snapshot){
          if(snapshot.hasData){
            return Column(
              children: [
                SizedBox(height: 20,),
                top(context),
                SizedBox(height: 10,),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child:
                  CarouselSlider(
                    options: CarouselOptions(
                      onPageChanged: (index,reason){
                        setState(() {
                          currentindex = index;
                        });
                      },
                      autoPlay: true,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,

                    ),
                    items: games.map((game) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsPage(game : game)));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                  imageUrl: game.backgroundImageUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                // Image.network(
                                //   game.backgroundImageUrl!,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(game.name ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(game.rating.toString()),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(26.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.8,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 30.0,
                    ),
                    itemCount: games.length,
                    itemBuilder: (BuildContext context, int index) {
                      var game = games[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailsPage(game : game)));
                        },
                        child: GridTile(
                          footer: GridTileBar(
                            backgroundColor: Colors.white,
                            title: Text(game.name,style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),),
                            subtitle: Row(
                              children: [
                                Icon(Icons.star ,color: Colors.black,size: 20,),
                                SizedBox(width: 10,),
                                Text(game.rating.toString(),style: GoogleFonts.poppins(color: Colors.black)),
                              ],
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: game.backgroundImageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          //Image.network(game.backgroundImageUrl!, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
                ],
            );
          }else if(snapshot.hasError){
            return  Center(
              child: Text("Error",style: GoogleFonts.poppins(color: Colors.red),),
            );
          }
          else {
            return const Center(
              child:CircularProgressIndicator(),
            );
            }
        },
      ),
    );
  }
  Widget top(BuildContext context){
    return SafeArea(
      child: ListTile(
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
          "ENGIN",
            style: GoogleFonts.roboto(
              fontSize: 60,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
