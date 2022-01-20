import 'dart:convert';

import 'package:app/models/pokedeks_model.dart';
import 'package:dio/dio.dart';

class ServicePokedex extends Object {
  static Future<PokedexModel> getPokedex() async {
    Response res = await Dio().get(
        'https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');

    return PokedexModel.fromJson(jsonDecode(res.data));
  }
}