class Employer {
  String? id;
  late String name;
  String? email;
  String? siape;
  String? sector;

  Employer(
      {required this.name,
      this.email,
      this.siape,
      this.sector,
      this.id,});

  //método para converter formato json em objetos
  Employer.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'],
        siape = map['siape'],
        sector = map['sector'];

  //permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'siape': siape,
      'sector': sector,
    };
  }
}
