// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appData)
const appDataProvider = AppDataProvider._();

final class AppDataProvider
    extends $FunctionalProvider<AppData, AppData, AppData>
    with $Provider<AppData> {
  const AppDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDataHash();

  @$internal
  @override
  $ProviderElement<AppData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppData create(Ref ref) {
    return appData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppData>(value),
    );
  }
}

String _$appDataHash() => r'fc2d7766bb4687428307f01fee4b320b734fea9e';
