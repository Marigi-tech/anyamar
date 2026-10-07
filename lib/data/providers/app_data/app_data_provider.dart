import 'package:anyamar/commons/exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_data_provider.g.dart';

@riverpod
AppData appData(Ref ref) {
  final userInformation = ref.watch(userInformationProvider);

  return AppData(
    properties: userInformation.properties,
    tenants: userInformation.tenants,
    activeTenants: userInformation.tenants
        .where((tenant) => tenant.endOfLease == null)
        .toList(),
    finances: userInformation.finances,

    units: userInformation.units,
    appUser: userInformation.appUser,
    rentRecords: userInformation.rentalRecords,
  );
}
