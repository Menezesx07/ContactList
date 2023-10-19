import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/contact_back4app_model.dart';

class ContactCardDetail extends StatefulWidget {
  const ContactCardDetail({super.key, this.contactItem});

  final contactItem;

  @override
  State<ContactCardDetail> createState() => _ContactCardDetailState();
}

class _ContactCardDetailState extends State<ContactCardDetail> {

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

    //90% da tela do celular
    //precisam estar dentro do build para pegar o context
    double screenWidth = MediaQuery.of(context).size.width;
    double desiredWidth = screenWidth * 0.9;

    //35% da tela do celular
    double screenHeight = MediaQuery.of(context).size.width;
    double desiredHeight = screenHeight * 0.32;

    return  Card(
      elevation: 10,
      child: SizedBox(
        height: desiredHeight,
        width: desiredWidth,
        child:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Dados de Contato", style: TextStyle(fontSize: 20)),

              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone),
                      const SizedBox(width: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${contactItemDestructured.number}"),
                          const Text("Casa")
                        ],
                      ),
                    ],
                  ),



                  Row(
                    children: [
                      InkWell(
                          onTap: () =>  launchUrl(Uri(scheme: "tel", path: contactItemDestructured.number)),
                          child: const Icon(Icons.phone)),

                      const SizedBox(width: 25),

                      InkWell(
                          onTap: () =>  launchUrl(Uri(scheme: "sms", path: contactItemDestructured.number)),
                          child: const Icon(Icons.message)),
                    ],
                  ),


                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
