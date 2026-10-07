// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SideBarNotifier)
const sideBarProvider = SideBarNotifierProvider._();

final class SideBarNotifierProvider
    extends $NotifierProvider<SideBarNotifier, bool> {
  const SideBarNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sideBarProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sideBarNotifierHash();

  @$internal
  @override
  SideBarNotifier create() => SideBarNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$sideBarNotifierHash() => r'3fb9c63c37ef6009fdd9837874e535151aed678a';

abstract class _$SideBarNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
