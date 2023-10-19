import 'package:contactlist/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../model/contact_back4app_model.dart';

class cardHome extends StatefulWidget {
  const cardHome({super.key, this.contactItem});

  final contactItem;

  @override
  State<cardHome> createState() => _cardHomeState();
}

class _cardHomeState extends State<cardHome> {

  ContactItem contactItemDestructured = ContactItem();

  @override
  void initState() {
    super.initState();
    getContactItems(widget.contactItem);
  }

  getContactItems(contactItem) {
    contactItemDestructured = contactItem;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Material(
        child: ListTile(

        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
             DetailPage(contactItem: contactItemDestructured,))),

         leading: contactItemDestructured.photo == "" ?

          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(('assets/images/icon.png'),
              height: 40, width: 40, fit: BoxFit.cover,
            )) :

          ClipRRect(
           borderRadius: BorderRadius.circular(50.0),
           child: Image.file(File(contactItemDestructured.photo.toString()),
             height: 40, width: 40, fit: BoxFit.cover,
           ),
          ),


          title:  Text("${contactItemDestructured.name}"),
      )

        ),
      );
  }
}
