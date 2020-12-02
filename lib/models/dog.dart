class Dog {
  String name;
  int age;
  int id;

  Dog({this.id, this.name, this.age});

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
