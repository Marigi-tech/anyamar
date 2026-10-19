// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_page_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPageNotifier)
const selectedPageProvider = SelectedPageNotifierProvider._();

final class SelectedPageNotifierProvider
    extends $NotifierProvider<SelectedPageNotifier, int> {
  const SelectedPageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPageNotifierHash();

  @$internal
  @override
  SelectedPageNotifier create() => SelectedPageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedPageNotifierHash() =>
    r'03d4036edb7685ec2391722dfc49eb7ff9097371';

abstract class _$SelectedPageNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
