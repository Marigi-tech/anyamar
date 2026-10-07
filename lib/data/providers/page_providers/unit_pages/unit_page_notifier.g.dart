// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_page_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UnitPageNotifier)
const unitPageProvider = UnitPageNotifierProvider._();

final class UnitPageNotifierProvider
    extends $NotifierProvider<UnitPageNotifier, UnitPageState> {
  const UnitPageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unitPageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unitPageNotifierHash();

  @$internal
  @override
  UnitPageNotifier create() => UnitPageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnitPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnitPageState>(value),
    );
  }
}

String _$unitPageNotifierHash() => r'3f5cc28a581145508641a482090e104414bf0d00';

abstract class _$UnitPageNotifier extends $Notifier<UnitPageState> {
  UnitPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UnitPageState, UnitPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UnitPageState, UnitPageState>,
              UnitPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
