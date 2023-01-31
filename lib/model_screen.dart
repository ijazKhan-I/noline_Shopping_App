class Registeration {
  int? id;
  late String name;
  late String email;
  late String password;
  late int Role;

  Registeration({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.Role,
  });

  Map<String, dynamic> map(){
    return{
      "id":id,
      "name":name,
      "email":email,
      "password":password,
      "Role":Role,
    };
  }
}
