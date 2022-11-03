class UserModel {
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.isAdmin,
  });
  late final String uid;
  late final String email;
  late final String name;
  late final bool isAdmin;

  UserModel.fromJson(Map<String, dynamic> json){
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['email'] = email;
    _data['name'] = name;
    _data['isAdmin'] = isAdmin;
    return _data;
  }
}