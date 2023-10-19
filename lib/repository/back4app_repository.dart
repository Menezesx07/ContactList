import 'dart:convert';

import 'package:dio/dio.dart';
import '../model/contact_back4app_model.dart';

class ContactBack4AppRepository {

  var _dio = Dio();

  //criando a base do Rest com o url necessario
  //ao executar qualquer função com o _dio, ele vai cair nessa função
  //e anexar esses itens
  ContactBack4AppRepository () {
    _dio = Dio();
    //passando os cabeçarios necessarios do back4app
    _dio.options.headers["X-Parse-Application-Id"] = "m6RFt3k9iFNP7dAuYLyeuJcc74wTc6Pvg9qO2M6K";
    _dio.options.headers["X-Parse-REST-API-Key"] = "KCeEt8RCQMew7vZdq55QyyB4gdbnCA0Ikeol3ihh";
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes/";
  }

  //lembrando que o retorno vem no "results" e dentro do card que é feito o destructuring
  Future<ContactBack4AppModel> getContacts() async {

    // contra barra para não da erro por conta das "" do check conflitar com as "" pra formar a string
    //lembrando que ele tá concatenando o "_dio.options.baseUrl" com a string "url"
    var url = "/contact/";

    //metodo Get do dio
    var res = await _dio.get(url);

    return ContactBack4AppModel.fromJson(res.data);
  }

  Future checkUserExist(ContactItem contactItem) async {

    try {
      //fazendo uma chamada usando apenas o numero, para verificar se o mesmo já existe,
      //é usado o json.encode para colocar as "" no objeto
      var numberJson = json.encode(ContactItem(number: contactItem.number).toJsonJustNumber());

      var res = await _dio.get("/contact/?where=$numberJson");

      //convertendo para objeto para verificar se houve um retorno valido ou não
      var resData = ContactBack4AppModel.fromJson(res.data);

      if (resData.results.isEmpty) {
        //chamando a função de salvar
        var res = save(contactItem);
        return res;

      } else {
        //se a consulta existir algo,
        //é retornado o numero para alteração
        return contactItem.number;
      }
    } catch (e) {
      return "erro";
    }
  }


  Future save (ContactItem contactItem) async {

    try {
        await _dio.post("/contact", data: contactItem.toJson());
        //se o salvar der certo, "setContact" retorna como "salvo"
        return "salvo";
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete (String id) async {

    try {
      await _dio.delete("/contact/$id");
    } catch (e) {
      rethrow;
    }

  }


}
