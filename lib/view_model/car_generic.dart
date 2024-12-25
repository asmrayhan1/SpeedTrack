import 'package:speed_track/model/car_model.dart';

class CarGeneric {
  List<Pair<int, CarModel>> carList;
  CarGeneric({this.carList = const []});

  CarGeneric update({List<Pair<int, CarModel>>? currentList}) {
    return CarGeneric(
      carList: currentList?? this.carList
    );
  }
}