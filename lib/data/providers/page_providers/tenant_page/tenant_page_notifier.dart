import 'package:anyamar/commons/exports.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tenant_page_notifier.g.dart';

@riverpod
class TenantPageNotifier extends _$TenantPageNotifier {
  @override
  TenantsPageState build() {
    return const TenantsTablePageState();
  }

  // ------------------------------------------------------------
  // Tenants list
  // ------------------------------------------------------------

  void showTenantsList() {
    state = const TenantsTablePageState();
  }

  // ------------------------------------------------------------
  // Add Tenant form
  // ------------------------------------------------------------

  void showAddTenantForm() {
    state = const AddTenantPageState();
  }

  // ------------------------------------------------------------
  // View Tenant page
  // ------------------------------------------------------------

  void viewTenantInformation(Tenant tenant) {
    state = ViewTenantPageState(tenant: tenant);
  }

  // ------------------------------------------------------------
  // Update Tenant
  // ------------------------------------------------------------

  void updateTenant(Tenant tenant) {
    state = UpdateTenantPageState(tenant: tenant);
  }

  // ------------------------------------------------------------
  // Add rent Entry
  // ------------------------------------------------------------
  void addRentEntry(Tenant tenant) {
    state = AddRentEntryState(tenant: tenant);
  }

  //-------------------------------------------------------------
  // View Rental Month
  //--------------------------------------------------------------
  void viewRentalMonth(RentalMonth rentalMonth, Tenant tenant) {
    state = ViewRentalMonthState(tenant: tenant, rentalMonth: rentalMonth);
  }
}
