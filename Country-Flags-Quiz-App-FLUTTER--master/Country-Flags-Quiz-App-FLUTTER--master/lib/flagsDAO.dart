

import 'package:country_flags_app/flags.dart';
import 'package:country_flags_app/helper.dart';

class FlagsDAO {

  Future<List<Flags>> getQuestions(String difficulty,int number) async {
    var db = await Helper.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM $difficulty ORDER BY RANDOM() LIMIT $number");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Flags(satir["flagId"], satir["flagName"], satir["flagImage"]);
    });
  }

  Future<List<Flags>> getWrongQuestions(String difficulty,int id) async {
    var db = await Helper.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM $difficulty WHERE flagId != $id ORDER BY RANDOM() LIMIT 3");
    return List.generate(maps.length, (i){
      var satir = maps[i];
      return Flags(satir["flagId"], satir["flagName"], satir["flagImage"]);
    });
  }

}
