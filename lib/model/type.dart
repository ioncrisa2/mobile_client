class Types {
  List<Type> items;

  Types({this.items});

  Types.fromJson(json) {
    items = new List<Type>();
    json.forEach((item) {
      items.add(Type.fromJson(item));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['types'] = this.items.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Type {
  int id;
  String name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
