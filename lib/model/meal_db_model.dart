class MealDBModel {
  int id;
  String _name, _picture, _uid,_date;

  MealDBModel(
      this._name,
      this._picture,
      this._uid,
      this._date,
      );

  MealDBModel.map(dynamic obj) {
    this._name = obj["name"];
    this._picture = obj["pict"];
    this._uid = obj["uid"];
    this._date = obj["date"];
  }

  String get name => _name;
  String get picture => _picture;
  String get uid => _uid;
  String get date => _date;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["name"] = _name;
    map["picture"] = _picture;
    map["uid"] = _uid;
    map["date"] = _date;

    return map;
  }

  void setMealId(int id) {
    this.id = id;
  }
}