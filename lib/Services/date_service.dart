import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateService {
  setDate(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(date);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('date', formattedDate);
    print("yes to setDate");
  }

  getDate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('date')) {
      String? date = pref.getString('date');

      print(date);
      return DateTime.parse(date!);
    } else {
      print("no");
      return DateTime.parse('2000-01-01 00:00:00');
    }
  }
}
