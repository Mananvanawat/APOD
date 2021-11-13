import 'package:apod/Models/date_model.dart';
import 'package:apod/Models/image_error.dart';
import 'package:apod/Utils/constants.dart';
import 'package:apod/View/widgets/nav_drawer.dart';
import 'package:apod/view_models/date_view_model.dart';
import 'package:apod/view_models/image_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../View/widgets/back_button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  Future<void> _selectDate(BuildContext context, DateViewModel dateViewModel,
      ImageViewModel imageViewModel) async {
    DateTime selectedDate = dateViewModel.dateModel!.date;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1994, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      dateViewModel.setDate(DateModel(date: picked,day: DateFormat('EEEE').format(picked)));
    imageViewModel.getImage(DateFormat('yyyy-MM-dd').format(picked!));
  }

  @override
  Widget build(BuildContext context) {
    ImageViewModel imageViewModel = context.watch<ImageViewModel>();
    DateViewModel dateViewModel = context.watch<DateViewModel>();
    return WillPopScope(
      onWillPop: () async {
        await imageViewModel.getImage(
            DateFormat('yyyy-MM-dd').format(DateTime.parse("2000-01-01")));
        await dateViewModel
            .setDate(DateModel(date: DateTime.parse("2000-01-01"),day: DateFormat('EEEE').format(DateTime.parse("2000-01-01"))));
        return false;
      },
      child: Scaffold(
         drawer: NavDrawer(),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'APOD',
              style: TextStyle(
              fontFamily: 'Trueno', color: Colors.black, fontSize: 34),
            ),

          ),
          body: Container(
              color: ColorCode[dateViewModel.dateModel!.day],
            child: _ui(context, imageViewModel, dateViewModel)),
          )
    );
  }

  _ui(context, ImageViewModel imageViewModel, DateViewModel dateViewModel) {
    if (imageViewModel.loading)
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
              BackButtons()
            ],
          ),
        ),
      );
    if (imageViewModel.imageError!.code != 200) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(imageViewModel.imageError!.message,style: TextStyle(fontFamily: 'Trueno',fontSize: 17),), BackButtons()],
        ),
      ));
    }
    return Container(

        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onLongPress: () async {
                await _selectDate(context, dateViewModel, imageViewModel);
              },
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: <Widget>[
                        Container(
                            child: const Center(
                                child: CircularProgressIndicator())),
                        Container(
                          child: FadeInImage.memoryNetwork(
                            imageErrorBuilder: (context, url, error) {
                              return Center(child: Image.network(errorImageAddress));
                            },
                            placeholder: kTransparentImage,
                            image: imageViewModel.imageModel!.url,
                          ),
                        ),
                      ],
                    ),
                  ))),
          BackButtons()
        ],
      ),
    ));
  }
}
