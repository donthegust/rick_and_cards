import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_cards/models/character_model.dart';
import 'package:rick_and_cards/models/navigation_arguments.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  Future<Results> _getCharacter(int id) async {
    final dio = Dio();

    final response = await dio.get(
      'https://rickandmortyapi.com/api/character/$id',
    );

    return Results.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NavigationArguments;

    const baseTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 24);

    return FutureBuilder(
      future: _getCharacter(args.id),
      builder: (context, snapshot) {
        late Color badgeColor;
        if (snapshot.data?.status == 'Alive') {
          badgeColor = Colors.lightGreenAccent;
        } else if (snapshot.data?.status == 'Dead') {
          badgeColor = Colors.redAccent;
        } else {
          badgeColor = Colors.grey;
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
          ),
          body: snapshot.hasData
              ? Stack(
                  children: [
                    Image.asset(
                      'assets/images/background.jpg',
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipOval(
                            child: Image.network(snapshot.data!.image),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: const Color(0xFF272727),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data!.name, style: baseTextStyle),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text('Status: ',
                                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                          Card(
                                            color: badgeColor,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(snapshot.data!.status,
                                                  style: baseTextStyle.copyWith(
                                                      fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text('Species: ${snapshot.data!.species}',
                                          style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                      Text('Gender: ${snapshot.data!.gender}',
                                          style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                      Text('Origin: ${snapshot.data!.origin.name}',
                                          style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                      Text('Actual Location: ${snapshot.data!.location.name}',
                                          style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                      Row(
                                        children: [
                                          Text('First episode: ',
                                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                          Card(
                                            color: Colors.white70,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                  'EP ${snapshot.data!.episode[0].substring(snapshot.data!.episode[0].length - 1)}',
                                                  style: baseTextStyle.copyWith(
                                                      fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Last episode: ',
                                              style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                          Card(
                                            color: Colors.white70,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                  'EP ${snapshot.data!.episode[snapshot.data!.episode.length - 1].substring(snapshot.data!.episode[0].length - 1)}',
                                                  style: baseTextStyle.copyWith(
                                                      fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text('Created in: ${snapshot.data!.created.split('T')[0]}',
                                          style: baseTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
