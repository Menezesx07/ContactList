import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:contactlist/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//LEMBRETE: para usar esses packages, precisa mexer no minSdk no android/build.grandle
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../controller/home_controller.dart';
import '../model/contact_back4app_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//LEMBRETE: para usar esses packages, precisa mexer no minSdk no android/build.grandle
class _RegisterPageState extends State<RegisterPage> {

  //variaveis onde vão ser salvas as fotos selecionada
  //lembrando que o que vem do retorno do bd vai ser o "photo.path"
  XFile? photo;
  //vai receber o photo.path, foi criado para ser enviado de forma "nula para o back4app",
  //caso o usuario não escolher uma imagem
  String photoPath = "";

  //variavel que é responsavel pelo salvamento da foto na galeria do aparelho
  String? photoName;

  TextEditingController nameController = TextEditingController();
  final numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //variaveis foram iniciadas para evitar o erro de null do back4app
  String name = "";
  String number = "";
  String email = "";


  void homeNavigator (context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {

    //90% da tela do celular
    //precisam estar dentro do build para pegar o context
    double screenWidth = MediaQuery.of(context).size.width;
    double desiredWidth = screenWidth * 0.8;

    return Consumer<HomeController>(builder: (context, value, child) => Scaffold(

      appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context)
          ),
          title: const Text("Register")),

      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

             Container(
               margin: const EdgeInsets.all(8.0),
               height: 550,
               child:  Padding(
                 padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),

                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [

                     Center(
                         child: InkWell(
                           child: photo != null ?
                           //importar o dart:io, se for o dart:html da erro
                           ClipRRect(
                               borderRadius: BorderRadius.circular(50.0),

                               child: Image.file(File(photo!.path),
                                   height: 150,
                                   width: 150,
                                   fit: BoxFit.cover,
                               )) :

                            Image.asset("assets/images/icon.png", width: 100),

                           onTap: () {

                       showModalBottomSheet(context: context, builder: (_) {

                         return Wrap(
                           children: [

                             //LEMBRETE: para usar esses packages, precisa mexer no minSdk no android/build.grandle
                             ListTile(leading: const Icon(Icons.camera), title: const Text("Camera"),
                                 onTap: () async {
                                   //instanciando a função da camera, e chamando ela
                                   final ImagePicker picker0 = ImagePicker();
                                   //o que foi tirando é salvo na variavel "photo"
                                   photo = await picker0.pickImage(source: ImageSource.camera);
                                   //se a photo existir, é salva no caminho da aplicação com o path_provider
                                   if(photo != null) {
                                     String path = (await path_provider.getApplicationDocumentsDirectory()).path;
                                     //importar o path, não o path_provider, só o path
                                     //pegando o nome da foto para salvar na pasta
                                     photoName = basename(photo!.path);
                                     //salvando a foto na pasta do arquivo, concatenando com o nome da mesma
                                     await photo!.saveTo("$path/$photoName");

                                     //salvando a imagem na galeria de fotos,
                                     //importar o GALLERYsAVER (não image gallery saver)
                                     await GallerySaver.saveImage(photo!.path);
                                     //preenchendo a variavel que vai ser enviada ao back4app
                                     photoPath = photo!.path;
                                     setState(() { });
                                     Navigator.pop(context);
                                   }
                                 }),

                             const Divider(),

                             ListTile(leading: const Icon(Icons.image_rounded), title: const Text("Galeria"),
                                 onTap: () async {
                                   final ImagePicker picker = ImagePicker();
                                   photo = await picker.pickImage(source: ImageSource.gallery);
                                   //preenchendo a variavel que vai ser enviada ao back4app
                                   photoPath = photo!.path;
                                   setState(() { });
                                   Navigator.pop(context);
                                 }),
                           ],
                         );
                       });

                     },)),
                     const SizedBox(height: 50),

                     Row(
                       children: [
                         const Icon(Icons.person),
                         const SizedBox(width: 20),
                         SizedBox(
                           width: desiredWidth,
                           child: TextField(
                             decoration: const InputDecoration(
                               border: OutlineInputBorder(),
                               labelText: 'Nome',
                             ),
                             controller: nameController,
                             onChanged: (nameController) {
                               name = nameController;
                             },
                           ),
                         ),
                       ],
                     ),

                     const SizedBox(height: 30),

                     Row(
                       children: [
                         const Icon(Icons.phone),
                         const SizedBox(width: 20),
                         SizedBox(
                           width: desiredWidth,
                           child: TextField(
                             decoration: const InputDecoration(
                               border: OutlineInputBorder(),
                               labelText: 'Numero',
                             ),
                             keyboardType: TextInputType.number,
                             inputFormatters: [
                               //package de padrões brasileiros do flutter
                               FilteringTextInputFormatter.digitsOnly,
                               TelefoneInputFormatter(),
                             ],
                             controller: numberController,
                             onChanged: (numberController) {
                               number = numberController;
                             },
                           ),
                         ),
                       ],
                     ),

                     const SizedBox(height: 30),

                     Row(
                       children: [
                         const Icon(Icons.mail),
                         const SizedBox(width: 20),
                         SizedBox(
                           width: desiredWidth,
                           child: TextField(
                             decoration: const InputDecoration(
                               border: OutlineInputBorder(),
                               labelText: 'Email',
                             ),
                             keyboardType: TextInputType.emailAddress,
                             controller: emailController,
                             onChanged: (emailController) {
                               email = emailController;
                             },
                           ),
                         ),
                       ],
                     ),
                    ],
                  ),
               ),
             ),


            //----CANCELAR E SALVAR-----
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  TextButton(onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar")),

                  FilledButton(onPressed: () async {


                   if(name.length >= 4 && number.length > 13) {
                     final controller = context.read<HomeController>();

                     var res = await controller.setContact(ContactItem(name: name, number: number, email: email, photo: photoPath));
                     res == "salvo" ?
                     Navigator.pop(context) :
                     _showSnackBar(context);
                     //a chamada do getData ficou aqui por conta de um delay se for chamado no home controller
                     controller.getData();
                   } else {
                     return;
                   }


                  },
                      child: const Text("Salvar"))

                ],
              ),
            )
          ],
        ),
      )
    )
    );
  }

  Future<void> _showSnackBar(BuildContext context) async {

    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () { },
        ),
        content: const Text('Esse contato já existe !'),
        duration: const Duration(milliseconds: 1500),
        width: 280.0, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

  }

}
