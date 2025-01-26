import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/data/datasources/local/storage_utils.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_event.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

@injectable
class LocationPermissionBloc
    extends Bloc<LocationPermissionEvent, LocationPermissionState> {
  StorageUtils storageUtils;
  LocationPermissionBloc(this.storageUtils)
      : super(LocationPermissionInitial()) {
    on<CheckLocationPermission>((event, emit) async {
      var status = await Permission.location.status;
      if (status.isGranted) {
        fetchLocationAndSave();
        emit(LocationPermissionGranted());
      } else if (status.isDenied || status.isRestricted) {
        emit(LocationPermissionDenied());
      } else if (status.isPermanentlyDenied) {
        emit(LocationPermissionPermanentlyDenied());
      }
    });

    on<RequestLocationPermission>((event, emit) async {
      var result = await Permission.location.request();

      if (result.isGranted) {
        emit(LocationPermissionGranted());
      } else if (result.isPermanentlyDenied) {
        emit(LocationPermissionPermanentlyDenied());
      } else {
        emit(LocationPermissionDenied());
      }
    });
  }

  void fetchLocationAndSave() async {
    Position? position = await getCurrentLocation();

    if (position != null) {
      print(
          "Location Coordinates ==>  ${position.latitude},${position.longitude}");

      storageUtils.saveDataForSingle(
          dataToSave: '${position.latitude},${position.longitude}',
          key: locationskey);
    } else {
      if (kDebugMode) {
        print("Unable to fetch location.");
      }
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Return null if services are not enabled
        return null;
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      // Retrieve the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      return null;
    }
  }
}
