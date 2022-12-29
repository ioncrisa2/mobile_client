class Location {
  int id;
  int companyId;
  String address;
  String country;
  String state;
  String city;
  String zipcode;

  Location({
    this.id,
    this.companyId,
    this.address,
    this.country,
    this.state,
    this.city,
    this.zipcode,
  });

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    address = json['street_address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['street_address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipcode;
    return data;
  }
}
