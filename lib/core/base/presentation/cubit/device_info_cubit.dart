import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'device_info_state.dart';

class DeviceInfoCubit extends Cubit<DeviceInfoState> {
  DeviceInfoCubit() : super(DeviceInfoInitial());

  void getVersionBuildInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      String versionName = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      emit(
        DeviceInfoSuccess(
          versionName: versionName,
          buildNumber: buildNumber,
        ),
      );
    } catch (e) {
      emit(DeviceInfoFailed());
    }
  }
}
