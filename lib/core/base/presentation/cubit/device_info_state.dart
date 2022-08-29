part of 'device_info_cubit.dart';

@immutable
abstract class DeviceInfoState {}

class DeviceInfoInitial extends DeviceInfoState {}

class DeviceInfoSuccess extends DeviceInfoState {
  final String versionName;

  final String buildNumber;

  DeviceInfoSuccess({
    required this.versionName,
    required this.buildNumber,
  });

  List<String> get props => [versionName, buildNumber];
}

class DeviceInfoFailed extends DeviceInfoState {
  DeviceInfoFailed();

  List<Object> get props => [];
}
