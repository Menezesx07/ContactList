import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/contact_back4app_model.dart';

class IconGroup extends StatefulWidget {
  const IconGroup({super.key, this.contactItem});

  final contactItem;

  @override
  State<IconGroup> createState() => _IconGroupState();
}

class _IconGroupState extends State<IconGroup> {

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

     return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            InkWell(
              onTap: () =>  launchUrl(Uri(scheme: "tel", path: contactItemDestructured.number)),
              child: const Column(
                children: [
                  Icon(Icons.call),
                  SizedBox(height: 10),
                  Text("Ligar"),
                ],
              ),
            ),

            const SizedBox(width: 60),

            InkWell(
              onTap: () =>  launchUrl(Uri(scheme: "sms", path: contactItemDestructured.number)),
              child: const Column(
                children: [
                  Icon(Icons.message),
                  SizedBox(height: 10),
                  Text("Mensagem"),
                ],
              ),
            ),

            const SizedBox(width: 60),

            InkWell(
              onTap: () => launchUrl(Uri(scheme: "mailTo", path: contactItemDestructured.email)),
              child: const Column(
                children: [
                  Icon(Icons.mail),
                  SizedBox(height: 10),
                  Text("Email"),
                ],
              ),
            ),
          ],
        ),

      ],
    );
  }
}
