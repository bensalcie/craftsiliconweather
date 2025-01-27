import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [StorageUtils] Helper class to save and retrieve data to shared preferences.
@lazySingleton
class StorageUtils {
  SharedPreferences? storage;

  StorageUtils(this.storage);

// Getting saved data as a map

  Future<List<String>> getDataFor({required String key}) async {
    // storage = getIt<SharedPreferences>();

    final savedData = storage?.getStringList(key);

    return savedData ?? [];
  }

  // Getting saved data as a map

  Future<String> getDataForSingle({required String key}) async {
    final savedData = storage?.getString(key);

    return savedData ?? '';
  }

  ///  [saveDataFor] Saving data for key.

  Future<bool?> saveDataFor(
      {required String key, required List<String> dataToSave}) async {
    await storage?.setStringList(key, dataToSave);
    return true;
  }

  ///  [saveDataForSingle] Saving data for key.

  Future<bool?> saveDataForSingle(
      {required String key, required String dataToSave}) async {
    await storage?.setString(key, dataToSave);
    return true;
  }

  // Deleting data

  Future<bool?> deleteDataFor({required String key}) async {
    final storageLocation = await getDataFor(key: key);
    storageLocation.clear();
    await saveDataFor(key: key, dataToSave: []);
    return true;
  }

  // Deleting data

  Future<bool?> deleteDataForSingle({required String key}) async {
    await saveDataForSingle(key: key, dataToSave: '');
    return true;
  }

  ///[addAtIndex] adds a specific marker at given index if index exists in element,
  ///List must be having [index]< [getDataFor] length.
  ///or adds it when index doesnt exist.
//
  /// Adding item at Specific index data
  /// [key] is the identifier of the list.
  /// [item] is the Marker

  Future<bool?> addAtIndex(
      {required String key, required String item, required int index}) async {
    final storageLocation = await getDataFor(key: key);
    // Get total total items and check if index exists.
    final totalitemideces =
        storageLocation.isNotEmpty ? storageLocation.length - 1 : 0;

    if (index > totalitemideces || index < 0) {
      return false;
    } else {
      storageLocation.isNotEmpty
          ? storageLocation[index] = item
          : storageLocation.add(item);
      return await saveDataFor(key: key, dataToSave: storageLocation);
    }
  }

  /// Deletes item at Specific index data
  /// [key] is the identifier of the list.
  /// [index]  is the index of the item to be deleted.

  Future<bool?> deleteAtIndex({required String key, required int index}) async {
    final storageLocation = await getDataFor(key: key);
    // Get total total items and check if index exists.
    final totalitemideces =
        storageLocation.isNotEmpty ? storageLocation.length - 1 : 0;

    if (index > totalitemideces || index < 0) {
      return false;
    } else {
      final newMapLocations = storageLocation..removeAt(index);
      return await saveDataFor(key: key, dataToSave: newMapLocations);
    }
  }

  Future<bool> saveFavourite({
    required String key,
    required String mixId,
  }) async {
    // Fetch previous data for the given key
    final previousData = await getDataFor(key: key);

    // Add new data and ensure no duplicates
    previousData.insert(0, mixId);
    final cleanedData = previousData.toSet().toList();

    // Ensure the list doesn't exceed 10 items by removing the oldest one
    if (cleanedData.length > 10) {
      cleanedData.removeLast();
    }

    // Save the updated list back to storage
    await storage?.setStringList(key, cleanedData);

    return true;
  }

  Future<List<String>> deleteFavourite({
    required String key,
    required String mixId,
  }) async {
    // Fetch previous data for the given key
    final previousData = await getDataFor(key: key);

    // Create a set to ensure no duplicates
    final cleanedData = previousData.toSet().toList();

    // Remove the specified item, if it exists
    cleanedData.remove(mixId);

    // Save the updated list back to storage
    await storage?.setStringList(key, cleanedData);

    // Return the cleaned list (with or without the item)
    return cleanedData;
  }

  /// Save a class object as JSON string
  Future<bool> saveJsonData<T>(
      String key, Map<String, dynamic> Function() toJson) async {
    if (storage == null) return false;
    String jsonData = jsonEncode(toJson());
    return await storage!.setString(key, jsonData);
  }

  /// Retrieve data and map it back to the class object
  T? getJsonData<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    if (storage == null) return null;
    String? jsonData = storage!.getString(key);
    if (jsonData == null) return null;
    Map<String, dynamic> jsonMap = jsonDecode(jsonData);
    return fromJson(jsonMap);
  }
}
