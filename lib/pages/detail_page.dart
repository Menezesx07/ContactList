import 'dart:io';

import 'package:contactlist/components/contact_detail_card.dart';
import 'package:contactlist/components/icon_group.dart';
import 'package:contactlist/model/contact_back4app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';
import 'home_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.contactItem});

  final contactItem;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

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
    return  Scaffold(

      appBar: AppBar(
          title: const Text("Detalhes"),
          actions: [

            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                onTap: () => _dialogDelete(context, contactItemDestructured.objectId.toString()),
                child: const Icon(Icons.restore_from_trash_outlined),
              ),
            ),
          ],
      ),

      body: Center(
        child: Column(

          children: [
            const SizedBox(height: 40),

            Container(
              child: contactItemDestructured.photo == "" ?
              ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset(('assets/images/icon.png'),
                      height: 140, width: 140, fit: BoxFit.cover)) :
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.file(File(contactItemDestructured.photo.toString()),
                    height: 200, width: 200, fit: BoxFit.cover),
              ),
            ),

            const SizedBox(height: 30),
            
            Text("${contactItemDestructured.name}", style: const TextStyle(fontSize: 32)),

            const SizedBox(height: 30),

            IconGroup(contactItem: contactItemDestructured),

            const SizedBox(height: 20),

            ContactCardDetail(contactItem: contactItemDestructured)


          ],
        ),
      )

    );
  }
}


//não, eu não sei componentizar Dialog :c
Future<void> _dialogDelete(BuildContext context, String id) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Excluir Contato ?'),
        content: const Text(
          "Este contato será excluido permanentemente do seu telefone"
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FilledButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirmar'),
            onPressed: () async {
              final controller = context.read<HomeController>();

              await controller.deleteContact(id);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const HomePage()));

             // return Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
