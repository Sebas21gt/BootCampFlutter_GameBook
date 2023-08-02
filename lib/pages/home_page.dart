import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:game_book/constants.dart';
import 'package:game_book/controllers/services_game.dart';
import 'package:game_book/models/model_game.dart';
import 'package:game_book/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key = GlobalKey<ScaffoldState>();
  // final User? user = Auth().currentUser;
  List<ModelGame> game = [];

  @override
  void initState() {
    _getGames();
    super.initState();
  }

  String? dropdownValue;
  
  _getGames() {
    Services().getGamesPopularity().then((value) {
      setState(() {
        game = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: key,
      drawer: const CustomDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (game.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.32,
              child: Container(
                padding: const EdgeInsets.only(top: 38),
                color: Style.backgroundColor,
                child: Stack(
                  alignment: const Alignment(-1, -1),
                  children: [
                    if (game.isNotEmpty)
                      CarouselSlider.builder(
                        itemCount: game.length,
                        itemBuilder: (context, index, realIndex) {
                          final currentGame = game[index];
                          return Stack(
                            alignment: const Alignment(0, 1),
                            children: [
                              FadeInImage.assetNetwork(
                                  placeholder: 'assets/img/loading-waiting.gif',
                                  image: currentGame.thumbnail,
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Style.backgroundColor.withOpacity(1),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                              ),
                              ListTile(
                                title: Text(currentGame.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 22)),
                                subtitle: Text(
                                    currentGame.shortDescription,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                trailing: ElevatedButton(
                                    onPressed: () {}, child: const Text('Ver más')),
                              ),
                            ],
                          );
                        },
                        options: CarouselOptions(
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 1.8,
                          autoPlay: true,
                          disableCenter: true,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              // _current = index;
                            });
                          },
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Todos los juegos',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Style.textColor),
                  textAlign: TextAlign.start),
              if (_getUniquePlatforms().isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Style.secondaryColor,
                  ),
                  child: DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Style.textColor),
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Style.secondaryColor,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Style.textColor),
                    // value: 'Todos los juegos',
                    items: _getUniquePlatforms().map((platform) {
                        return DropdownMenuItem(
                          value: platform,
                          child: Text(platform,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Style.textColor),
                              textAlign: TextAlign.start),
                        );
                      }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value;
                      });
                    },
                  ),
                )
            ],
          ),
          if (game.isNotEmpty)
            Expanded(child: ListView.builder(
              itemBuilder: (context, index) {
                final currentGame = game[index];
                return Card(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'InfoGamePage', arguments: currentGame.id.toString());
                    },
                    child: Stack(
                      alignment: const Alignment(1, 1),
                      children: [
                        FadeInImage.assetNetwork(
                            placeholder: 'assets/img/loading-waiting.gif',
                            image: currentGame.thumbnail),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Style.backgroundColor.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: ListTile(
                              title: Text(currentGame.title,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 22)),
                              trailing: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Style.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(currentGame.platform,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ))
        ],
      ),
    );
  }

  Set<String> _getUniquePlatforms() {
    Set<String> uniquePlatforms = {};
    for (var game in game) {
      uniquePlatforms.add(game.platform);
    }
    return uniquePlatforms;
  }
}
