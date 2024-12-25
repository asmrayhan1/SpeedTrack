class CarModel {
  bool isSelected;
  String price;
  String? imgUrl;
  String? title;
  String? description;
  CarModel({this.isSelected = false, this.price = "0", this.imgUrl, this.title, this.description});

  // fromJson method to convert JSON to CategoryModel object
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
        isSelected: json['isSelected'],
        price: json['price'],
        imgUrl: json['imgUrl'],
        title: json['title'],
        description: json['description'],
    );
  }

  // toJson method to convert RegisterModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'isSelected' : isSelected,
      'price' : price,
      'imgUrl': imgUrl,
      'title': title,
      'description': description,
    };
  }
}

class Pair<T, U> {
  final T first;
  final U second;

  Pair(this.first, this.second);
}