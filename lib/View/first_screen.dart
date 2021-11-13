import 'package:apod/Models/date_model.dart';
import 'package:apod/View/second_screen.dart';
import 'package:apod/view_models/date_view_model.dart';
import 'package:apod/view_models/image_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Utils/constants.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateViewModel dateViewModel = context.watch<DateViewModel>();
    ImageViewModel imageViewModel = context.watch<ImageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, there",
          style: TextStyle(fontFamily: 'Trueno', color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: ColorCode[dateViewModel.dateModel!.day],
        child: _ui(context, imageViewModel, dateViewModel),
      ),
    );
  }

  /*Future<void> _selectDate(BuildContext context, DateViewModel dateViewModel,
      ImageViewModel imageViewModel) async {
    DateTime selectedDate = dateViewModel.dateModel!.date;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      dateViewModel.setDate(DateModel(date: picked,day: DateFormat('EEEE').format(picked)));
    imageViewModel.getImage(DateFormat('yyyy-MM-dd').format(picked!));
  }*/
  Future<void> _selectDate(BuildContext context, DateViewModel dateViewModel,
      ImageViewModel imageViewModel) async {
    DateTime selectedDate = dateViewModel.dateModel!.date;
    DateTime? picked = await showModalBottomSheet<DateTime>(

      context: context,
      builder: (context) {
        DateTime tempPickedDate = selectedDate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Done'),
                      onPressed: () {
                        dateViewModel.setDate(DateModel(date: tempPickedDate,day: DateFormat('EEEE').format(tempPickedDate)));
                        imageViewModel.getImage(DateFormat('yyyy-MM-dd').format(tempPickedDate));
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  _ui(context, ImageViewModel imageViewModel, DateViewModel dateViewModel) {
    DateTime selectedDate = dateViewModel.dateModel!.date;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(fontSize: 50, fontFamily: 'Trueno'),
          ),
              ),elevation: 5,
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () =>
                          _selectDate(context, dateViewModel, imageViewModel),
                      child: Text('Select date',style: TextStyle(fontSize: 20,fontFamily: 'Trueno'),),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                          onPressed: () async {
                            imageViewModel.getImage(DateFormat('yyyy-MM-dd').format(dateViewModel.dateModel!.date));
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => SecondScreen()));
                          },
                          child: Text("Show",style: TextStyle(fontSize: 20,fontFamily: 'Trueno')))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
