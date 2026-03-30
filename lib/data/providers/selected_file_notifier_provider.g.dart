// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_file_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedFileNotifier)
const selectedFileProvider = SelectedFileNotifierProvider._();

final class SelectedFileNotifierProvider
    extends $NotifierProvider<SelectedFileNotifier, PlatformFile?> {
  const SelectedFileNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFileNotifierHash();

  @$internal
  @override
  SelectedFileNotifier create() => SelectedFileNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlatformFile? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlatformFile?>(value),
    );
  }
}

String _$selectedFileNotifierHash() =>
    r'dbb7f8da2fa5cca47d87b6439cd810dd962896ff';

abstract class _$SelectedFileNotifier extends $Notifier<PlatformFile?> {
  PlatformFile? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PlatformFile?, PlatformFile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlatformFile?, PlatformFile?>,
              PlatformFile?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
