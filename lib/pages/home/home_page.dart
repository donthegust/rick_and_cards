import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_cards/models/character_model.dart';
import 'package:rick_and_cards/models/info_model.dart';
import 'package:rick_and_cards/models/response_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _searchController;
  ResponseData _responseData = ResponseData();
  // InfoModel _infoSearchResults = InfoModel(count: 0);
  // List<CharacterModel> _listCharacterResults = [];
  // int _searchResultsCount = 0;
  bool _existPages = false;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchCharacter('');
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchCharacter(String val) async {
    final dio = Dio();
    final response = await dio.get(
      'https://rickandmortyapi.com/api/character/',
      queryParameters: {'name': val},
    );

    setState(() {
      _responseData = ResponseData.fromMap(response.data);
      log(_responseData.info!.count.toString());
      _existPages = _responseData.info!.next != null || _responseData.info!.prev != null;
      // _searchResultsCount = _responseData.info!.count!;
      //log(response.data['info'].toString());
      // _infoSearchResults = InfoModel.fromMap(response.data['info']);
      // //log(response.data['results'].toString());
      // _listCharacterResults = response.data['results'];
    });
    //log(response.data['info']['count'].toString());
    // log(response.data.toString());
  }

  Future<void> _navigationPages(String page) async {
    final dio = Dio();
    if (page == 'next') {
      final response = await dio.get(_responseData.info!.next!);
      _responseData = ResponseData.fromMap(response.data);
    } else {
      final response = await dio.get(_responseData.info!.prev!);
      _responseData = ResponseData.fromMap(response.data);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // log(_searchResultsCount.toString());
    // log(_responseData.info!.count.toString());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                            hintText: 'Pesquise por algum personagem', prefixIcon: Icon(Icons.search)),
                        //onChanged: (value) => {},
                        onChanged: _searchCharacter,
                      ),
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.15,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: const Icon(Icons.search),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _responseData.results != null
                  ? ListView.builder(
                      itemCount: _responseData.info!.count! > 20 ? 20 : _responseData.info!.count! - 1,
                      itemBuilder: (BuildContext context, int index) {
                        // log(index.toString());
                        return Card(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.all(8),
                                  child: Image.network(_responseData.results![index]!.image!),
                                  // child: Placeholder(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_responseData.results![index]!.name!),
                                    Text(_responseData.results![index]!.status!),
                                    Text(_responseData.results![index]!.species!),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
            Visibility(
              visible: _existPages,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: _responseData.info?.prev != null ? () => _navigationPages('prev') : null,
                          child: const Icon(
                            Icons.arrow_left,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: _responseData.info?.next != null ? () => _navigationPages('next') : null,
                          child: const Icon(
                            Icons.arrow_right,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
