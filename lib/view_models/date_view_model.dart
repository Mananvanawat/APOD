import 'package:apod/Models/date_model.dart';
import 'package:apod/Services/date_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../view_models/date_view_model.dart';

class DateViewModel extends ChangeNotifier{
 DateModel _dateModel = DateModel(date: DateTime.now(),day:"Monday");
 DateModel? get dateModel => _dateModel;
 DateViewModel(){
   getDate();
 }
 setDate(DateModel dateModel)async{
   _dateModel = dateModel;
   await DateService().setDate(dateModel.date);
   notifyListeners();
 }
 getDate()async{
   var res = await DateService().getDate();
   setDate(DateModel(date: res,day:DateFormat('EEEE').format(res)));
 }
}