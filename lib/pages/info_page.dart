import 'package:flutter/material.dart';
import 'package:game_book/constants.dart';
import 'package:game_book/controllers/services_game.dart';
import 'package:game_book/models/model_data_game.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoGamePage extends StatefulWidget {
  final String id;
  const InfoGamePage({super.key, required this.id});

  @override
  State<InfoGamePage> createState() => _InfoGamePageState();
}

class _InfoGamePageState extends State<InfoGamePage> {
  ModelDataGame? detailsGame;

  @override
  void initState() {
    super.initState();
    _getGameDetails(widget.id);
  }

  _getGameDetails(String gameId) {
    Services().getDetailsGame(gameId).then((details) {
      setState(() {
        detailsGame = details;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          if (detailsGame != null)
            Stack(children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/img/loading.gif'),
                  image: NetworkImage(detailsGame!.thumbnail),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Style.backgroundColor.withOpacity(1),
                  ],
                )),
              )
            ]),
          if (detailsGame != null)
            Padding(
                padding: const EdgeInsets.all(20),
                child: ListBody(
                  children: [
                    Text(
                      detailsGame!.title,
                      style: const TextStyle(
                          color: Style.textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      detailsGame!.description,
                      style:
                          const TextStyle(color: Style.textColor, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    rowInfo('Desarrollado por: ', detailsGame!.developer),
                    const SizedBox(
                      height: 20,
                    ),
                    rowInfo('Publicado por: ', detailsGame!.publisher),
                    const SizedBox(
                      height: 20,
                    ),
                    rowInfo('Genero: ', detailsGame!.genre),
                    const SizedBox(
                      height: 20,
                    ),
                    rowInfo('Plataforma: ', detailsGame!.platform),
                    const SizedBox(
                      height: 20,
                    ),
                    rowInfo('Requerimientos minimos: ', ''),
                    Container(
                      decoration: BoxDecoration(
                        color: Style.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            rowInfo(
                                'Procesador: ',
                                detailsGame!
                                    .minimumSystemRequirements.processor),
                            rowInfo('Memoria: ',
                                detailsGame!.minimumSystemRequirements.memory),
                            rowInfo(
                                'Graficos: ',
                                detailsGame!
                                    .minimumSystemRequirements.graphics),
                            rowInfo('Almacenamiento: ',
                                detailsGame!.minimumSystemRequirements.storage),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                      ),
                      itemCount: detailsGame!.screenshots.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                insetPadding: const EdgeInsets.only(left: 10, right: 10),
                                child: FadeInImage(
                                  // height: 200,
                                  // width: width,
                                  fit: BoxFit.cover,
                                  placeholder: const AssetImage("assets/img/loading.gif"),
                                  image: NetworkImage(detailsGame!.screenshots[index].image),
                                )
                              )
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FadeInImage(
                              // height: 200,
                              // width: width,
                              fit: BoxFit.cover,
                              placeholder: const AssetImage("assets/img/loading.gif"),
                              image: NetworkImage(detailsGame!.screenshots[index].image),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _launchUrl(Uri.parse(detailsGame!.gameUrl));
                        }, child: const Text('Visitar página'))
                  ],
                )),
        ],
      ),
    ));
  }

  Widget rowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              label,
              style: const TextStyle(
                  color: Style.textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              value,
              style: const TextStyle(color: Style.textColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
}
