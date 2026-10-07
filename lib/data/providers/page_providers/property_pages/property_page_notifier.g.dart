// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_page_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PropertyPageNotifier)
const propertyPageProvider = PropertyPageNotifierProvider._();

final class PropertyPageNotifierProvider
    extends $NotifierProvider<PropertyPageNotifier, PropertyPageState> {
  const PropertyPageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'propertyPageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$propertyPageNotifierHash();

  @$internal
  @override
  PropertyPageNotifier create() => PropertyPageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PropertyPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PropertyPageState>(value),
    );
  }
}

String _$propertyPageNotifierHash() =>
    r'db7bebc5e5cb79a25bc4285895b52b5898cf2b8f';

abstract class _$PropertyPageNotifier extends $Notifier<PropertyPageState> {
  PropertyPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PropertyPageState, PropertyPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PropertyPageState, PropertyPageState>,
              PropertyPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
