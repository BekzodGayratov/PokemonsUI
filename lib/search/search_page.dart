import 'package:app/models/pokedeks_model.dart';
import 'package:app/sizeConfig/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  PokedexModel? pokedex;
  SearchPage({Key? key, this.pokedex}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Pokemon> _pokemons = [];
  Set<Pokemon> _searchedPokemons = {};
  @override
  void initState() {
    super.initState();
    _pokemons = widget.pokedex!.pokemon!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getProportionScreenHeight(100),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              onChanged: (v) {
                _searchedPokemons.clear();
                for (Pokemon item in _pokemons) {
                  if (v.length == 0) {
                    _searchedPokemons.clear();
                    setState(() {});
                  } else if (item.name!.toLowerCase().contains(v.toLowerCase())) {
                    _searchedPokemons.add(item);
                    setState(() {});
                  }
                }
              },
            ),
          ],
        ),
        actions: const [Icon(Icons.drive_file_rename_outline_outlined)],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionScreenWidth(40),
                vertical: getProportionScreenHeight(30)
              ),
              child: Stack(
                children: [
                  Container(
                      height: getProportionScreenHeight(200),
                      width: getProportionScreenWidth(300),
                      decoration: BoxDecoration(
                          color: const Color(0xffFC7CFF),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: getProportionScreenHeight(70),
                                left: getProportionScreenWidth(20)),
                            child: Container(
                              height: getProportionScreenHeight(30),
                              width: getProportionScreenWidth(200),
                              decoration: BoxDecoration(
                                  color: const Color(0xff676767),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("#${_searchedPokemons.toList()[index].num}",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Color(0xffF993FB),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    _searchedPokemons.toList()[index].name!,
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                  Positioned(
                    left: getProportionScreenWidth(70),
                    bottom: getProportionScreenHeight(70),
                    child: SizedBox(
                      height: getProportionScreenHeight(120),
                      width: getProportionScreenWidth(90),
                      child: CachedNetworkImage(
                        imageUrl: _searchedPokemons.toList()[index].img!,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          itemCount: _searchedPokemons.length,
        ),
      ),
    );
  }
}
