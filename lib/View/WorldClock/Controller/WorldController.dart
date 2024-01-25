import 'package:clockalarm/Config/Import.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class WorldController extends GetxController {
  final searchlist = [].obs;
  final WorldClocklist = [].obs;
  final currentcitytime = [].obs;

  setup(location) async {
    var istanbulTimeZone = tz.getLocation(location);
    var now = tz.TZDateTime.now(istanbulTimeZone);
   var add = currentcitytime.where((element) => element['name'] == location).toList();
    if(add.length < 1){
    currentcitytime.add({'name': location, 'time': now});}
  }
}
