import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sembast/sembast.dart';
import 'package:speed_track/model/car_model.dart';
import 'package:speed_track/view_model/car_generic.dart';

import '../database/database_helper.dart';

final carProvider = StateNotifierProvider<CarController, CarGeneric> ((ref) => CarController());

class CarController extends StateNotifier<CarGeneric> {
  CarController() : super(CarGeneric());

  static final _store = intMapStoreFactory.store('my_store');

  // Get all records from the store
  Future<void> getAllData() async {
    final db = await DatabaseHelper.getDatabase();
    final finder = Finder();  // You can customize the Finder if needed (for filtering, sorting, etc.)
    final data =  await _store.find(db, finder: finder);

    // Convert each record into a Pair<int, CarModel>
    List<Pair<int, CarModel>> carList = data.map((e) {
      // Converting the Map<String, dynamic> (e.value) into CarModel using fromJson
      CarModel car = CarModel.fromJson(e.value);
      return Pair<int, CarModel>(e.key, car);  // Creating a Pair with key and CarModel
    }).toList();

    state = state.update(currentList: carList);
  }

  Future<void> saveData(Map<String, dynamic> data) async {
    final db = await DatabaseHelper.getDatabase();
    await _store.add(db, data);  // Add a new record
    getAllData();
  }

  Future<void> updateRecordByKey(int index, Map<String, dynamic> updatedData) async {
    final db = await DatabaseHelper.getDatabase();
    await _store.record(state.carList[index].first).update(db, updatedData);  // Update record by key
    await getAllData();
  }

  Future<void> deleteRecordByKey(int key) async {
    final db = await DatabaseHelper.getDatabase();
    await _store.record(key).delete(db);  // Delete record by key
    getAllData();
  }
}