part of 'gps_bloc.dart';

class GpsState extends Equatable {
  //Estados del GPS 
  final bool isGpsEnabled;
  final bool isGpsPermissionGranted;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});


//Copiar los estados
  GpsState copyWith({
    bool? isGpsEnabled,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
          isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  @override
  String toString() =>
      '\n{isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted}\n';
}

//class GpsInitial extends GpsState {}
