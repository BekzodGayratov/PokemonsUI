import 'package:app/models/pokedeks_model.dart';
import 'package:app/service/pokedex_service.dart';
import 'package:app/sizeConfig/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokedexModel? _pokedexes;
  @override
  void initState() {
    super.initState();
    ServicePokedex.getPokedex().then((value) {
      _pokedexes = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: getProportionScreenHeight(65),
          ),
          Center(
            child: Image.asset("assets/logo.png"),
          ),
          SizedBox(
            height: getProportionScreenHeight(30),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionScreenWidth(30)),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "Buscar Pokemon",
                    contentPadding: EdgeInsets.symmetric(
                        vertical: getProportionScreenHeight(5.0),
                        horizontal: getProportionScreenWidth(10)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                onTap: () {
                  Navigator.pushNamed(context, "/search",
                      arguments: _pokedexes);
                },
              ),
            ),
          ),
          SizedBox(
            height: getProportionScreenHeight(40),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.4, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionScreenWidth(10)),
                    child: FutureBuilder(
                        future: ServicePokedex.getPokedex(),
                        builder:
                            (context, AsyncSnapshot<PokedexModel> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("ERROR: ${snapshot.error}"),
                            );
                          } else {
                            var data = snapshot.data!.pokemon;
                            return Stack(
                              children: [
                                Container(
                                    height: getProportionScreenHeight(120),
                                    width: getProportionScreenWidth(180),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFC7CFF),
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  getProportionScreenHeight(70),
                                              left:
                                                  getProportionScreenWidth(20)),
                                          child: Container(
                                            height:
                                                getProportionScreenHeight(30),
                                            width:
                                                getProportionScreenWidth(130),
                                            decoration: BoxDecoration(
                                                color: const Color(0xff676767),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("#${data![index].num!}",
                                                    style: const TextStyle(
                                                      fontSize: 12.0,
                                                      color: Color(0xffF993FB),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    )),
                                                Text(
                                                  data[index].name!,
                                                  style: const TextStyle(
                                                      fontSize: 12.0,
                                                      color: Color(0xffFFFFFF),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                Positioned(
                                  left: getProportionScreenWidth(40),
                                  bottom: getProportionScreenHeight(70),
                                  child: SizedBox(
                                    height: getProportionScreenHeight(80),
                                    width: getProportionScreenWidth(80),
                                    child: CachedNetworkImage(
                                      imageUrl: data[index].img!,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
