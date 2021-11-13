import 'dart:io';

import 'package:apod/Models/date_model.dart';
import 'package:apod/View/first_screen.dart';
import 'package:apod/view_models/date_view_model.dart';
import 'package:apod/view_models/image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime tempPickedDate = DateTime.now();
    DateViewModel dateViewModel = context.watch<DateViewModel>();
    ImageViewModel imageViewModel = context.watch<ImageViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontFamily: 'Trueno', color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                  height: 100,
                  child: Image.asset("assets/image.jpg"),),
            ),
          ),
            SizedBox(height: 20,),
            Text("Name: Manan Vanawat",style: TextStyle(fontFamily: 'Trueno',fontSize: 17),),
            Text("Mobile number: +919001207886",style: TextStyle(fontFamily: 'Trueno',fontSize: 17),),
            Text("Email: vanawat.manan@gmail.com",style: TextStyle(fontFamily: 'Trueno',fontSize: 17),),
            InkWell(
                child: new Text('Github link',style: TextStyle(fontFamily: 'Trueno',fontSize: 17,color: Colors.blue)),
                onTap: () => launch('https://github.com/mananvanawat')
            ),
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: ElevatedButton(
                      onPressed: () async {
                        dateViewModel.setDate(DateModel(date: tempPickedDate,day: DateFormat('EEEE').format(tempPickedDate)));
                        imageViewModel.getImage(DateFormat('yyyy-MM-dd').format(tempPickedDate));
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        Navigator.pushReplacement(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => FirstScreen()));
                      },
                      child: Text("Reset",style: TextStyle(fontSize: 20,fontFamily: 'Trueno')))),
            ),
          ],
        ),
      ),
    );
  }
}
