import 'package:craftsiliconweather/core/common/utils/app_utils.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_bloc.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_event.dart';
import 'package:craftsiliconweather/features/home/presentation/bloc/location_permission_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationPermissionView extends StatefulWidget {
  const LocationPermissionView({
    super.key,
  });

  @override
  State<LocationPermissionView> createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> {
  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationPermissionBloc, LocationPermissionState>(
      listener: (context, state) {
        if (state is LocationPermissionDenied) {
          showPermissionDialog(context);
        } else if (state is LocationPermissionPermanentlyDenied) {
          showPermanentDenialDialog(context);
        }
      },
      child: BlocBuilder<LocationPermissionBloc, LocationPermissionState>(
        builder: (context, state) {
          if (state is LocationPermissionInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LocationPermissionDenied) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<LocationPermissionBloc>()
                      .add(RequestLocationPermission());
                },
                child: Text('Request Permission'),
              ),
            );
          } else if (state is LocationPermissionPermanentlyDenied) {
            return Center(
              child: Text(
                'Permission permanently denied. Please enable it in settings.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  void _checkLocationPermission() {
    // Check location permission
    context.read<LocationPermissionBloc>().add(CheckLocationPermission());
  }
}
