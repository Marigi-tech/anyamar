// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finances_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FinancesPageNotifier)
const financesPageProvider = FinancesPageNotifierProvider._();

final class FinancesPageNotifierProvider
    extends $NotifierProvider<FinancesPageNotifier, FinancesPageState> {
  const FinancesPageNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financesPageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financesPageNotifierHash();

  @$internal
  @override
  FinancesPageNotifier create() => FinancesPageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinancesPageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinancesPageState>(value),
    );
  }
}

String _$financesPageNotifierHash() =>
    r'9a4dc0a396089085f462e1ecc5f09996e51e81a1';

abstract class _$FinancesPageNotifier extends $Notifier<FinancesPageState> {
  FinancesPageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FinancesPageState, FinancesPageState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FinancesPageState, FinancesPageState>,
              FinancesPageState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
