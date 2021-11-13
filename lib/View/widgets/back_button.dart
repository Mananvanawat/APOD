import 'package:flutter/material.dart';

class BackButtons extends StatelessWidget {
  const BackButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: MediaQuery.of(context).size.height*0.06,
        child: ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back_ios),
            Text("Back"),
          ],
        )),
      ),
    );
  }
}
