import 'package:flutter/material.dart';
import '../third_screen.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Hello',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile',
    style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: 'Trueno')
            ),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ThirdScreen()))
            },
          ),

        ],
      ),
    );
  }
}