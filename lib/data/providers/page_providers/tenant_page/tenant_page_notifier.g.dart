// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_page_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TenantPageNotifier)
const tenantPageProvider = TenantPageNotifierProvider._();

final class TenantPageNotifierProvider
    extends $NotifierProvider<TenantPageNotifier, TenantsPageState> {
  const TenantPageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tenantPageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tenantPageNotifierHash();

  @$internal
  @override
  TenantPageNotifier create() => TenantPageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TenantsPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TenantsPageState>(value),
    );
  }
}

String _$tenantPageNotifierHash() =>
    r'db8bd392b471be135d67b0a9785a2399e0437b71';

abstract class _$TenantPageNotifier extends $Notifier<TenantsPageState> {
  TenantsPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TenantsPageState, TenantsPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TenantsPageState, TenantsPageState>,
              TenantsPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
