// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:game_book/constants.dart';
// import 'package:game_book/widgets/custom_drawer.dart';

// class GamePage extends StatelessWidget {
//   const GamePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         drawer: const CustomDrawer(),
//         body: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.3,
//               child: ListView.builder(
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     alignment: const Alignment(-1, -1),
//                     children: [
//                       if (game.isNotEmpty)
//                         CarouselSlider.builder(
//                           itemCount: game.length,
//                           itemBuilder: (context, index, realIndex) {
//                             final currentGame = game[index];
//                             return Stack(
//                               alignment: const Alignment(0, 1),
//                               children: [
//                                 Image.network(
//                                   currentGame.thumbnail ??
//                                       'https://www.freetogame.com/g/1/thumbnail.jpg',
//                                   fit: BoxFit.cover,
//                                   width: MediaQuery.of(context).size.width,
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                         colors: [
//                                           Colors.transparent,
//                                           Style.backgroundColor.withOpacity(1),
//                                         ],
//                                         begin: Alignment.topCenter,
//                                         end: Alignment.bottomCenter),
//                                   ),
//                                 ),
//                                 Card(
//                                   color: Colors.transparent,
//                                   child: ListTile(
//                                     title: Text(
//                                         currentGame.title ?? 'No hay datos',
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 22)),
//                                     subtitle: Text(
//                                         currentGame.shortDescription ??
//                                             'No hay datos',
//                                         style: const TextStyle(
//                                             color: Colors.white, fontSize: 14)),
//                                     trailing: ElevatedButton(
//                                         onPressed: () {},
//                                         child: const Text('Ver más')),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                           options: CarouselOptions(
//                             autoPlayCurve: Curves.fastOutSlowIn,
//                             pauseAutoPlayOnTouch: true,
//                             aspectRatio: 1.8,
//                             autoPlay: true,
//                             disableCenter: true,
//                             viewportFraction: 1.0,
//                             enlargeCenterPage: false,
//                             onPageChanged: (index, reason) {
//                               setState(() {
//                                 // _current = index;
//                               });
//                             },
//                           ),
//                         ),
//                       IconButton(
//                         onPressed: () {
//                           key.currentState?.openDrawer();
//                         },
//                         icon: const Icon(Icons.menu, color: Colors.white),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             )
//           ],
//         ));
//   }
// }
