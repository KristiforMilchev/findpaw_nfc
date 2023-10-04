class Tag {
  String name;
  String number;
  String address;
  String petName;
  String? note;
  String password;

  Tag({
    required this.name,
    required this.number,
    required this.address,
    required this.petName,
    this.note,
    required this.password,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
      number: json['number'],
      address: json['address'],
      petName: json['petName'],
      note: json['note'],
      password: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'address': address,
      'petName': petName,
      'note': note,
    };
  }
}
