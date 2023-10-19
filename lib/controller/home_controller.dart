import 'package:flutter/material.dart';

import '../model/contact_back4app_model.dart';
import '../repository/back4app_repository.dart';

class HomeController extends ChangeNotifier {

  ContactBack4AppRepository contactBack4AppRepository = ContactBack4AppRepository();

  var _contactList = ContactBack4AppModel([]);
  //lembrar de deixar o Getter do mesmo tipo da variavel inicial
  ContactBack4AppModel get contactList => _contactList;

  //fazendo a chamada http do repository,
  //para preencher a tela inicial com o "contactList"
  Future<void> getData() async {
   _contactList = await contactBack4AppRepository.getContacts();
   //notificando os ouvintes desse controller para as mudanças (atualizar a lista)
   notifyListeners();
  }

  //recebe a classe que monta o objeto da model, não a classe que controla tudo (da model)
   setContact(ContactItem contactItem) async {
    var res = await contactBack4AppRepository.checkUserExist(contactItem);
  //  getData();
    //retornando o status do cadastramento do usuario
    return res;
  }

  deleteContact(String id) async {
    await contactBack4AppRepository.delete(id);
    getData();
  }

}