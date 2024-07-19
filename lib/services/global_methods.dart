import 'package:flutter/material.dart';

class GlobalMethods{
  Future<void> showDialogg( String title, String subtitle, Function fct, BuildContext context, ) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl1pnlgTN51xoAni23E1MHpS6kdhItU3K-y7Q2TcRZgVUuunf0r4WoqwbCMQ&s',
                    height: 20,
                    width: 20,
                  ),
                ),
                Text(title),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    fct();
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
   Future<void> authErrorhandle(  String subtitle, BuildContext context, ) async {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQl1pnlgTN51xoAni23E1MHpS6kdhItU3K-y7Q2TcRZgVUuunf0r4WoqwbCMQ&s',
                    height: 20,
                    width: 20,
                  ),
                ),
                Text('Error Occured'),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}