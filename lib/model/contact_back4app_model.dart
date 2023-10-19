class ContactBack4AppModel {

  //results vem do retorno do Json do back4app
  //all conteudo vem dentro do objeto "results"
  //tem de iniciar essa lista com [] para facilitar comparação no builder.view
  List<ContactItem> results = [];

  ContactBack4AppModel(this.results);

  ContactBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ContactItem>[];
      json['results'].forEach((v) {
        results.add(ContactItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(contactItem) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
      return data;
  }
}

//classe que vai ser usada dentro do card para o "destructuring"
class ContactItem {
  String? objectId;
  String? name;
  String? number;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? photo;

  ContactItem(
      {this.objectId,
        this.name,
        this.number,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.photo});

  ContactItem.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['email'] = email;
    data['photo'] = photo;
    return data;
  }

  Map<String, dynamic> toJsonJustNumber() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    return data;
  }
}