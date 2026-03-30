// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_record_nature_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FinancialRecordNatureNotifier)
const financialRecordNatureProvider = FinancialRecordNatureNotifierProvider._();

final class FinancialRecordNatureNotifierProvider
    extends
        $NotifierProvider<
          FinancialRecordNatureNotifier,
          FinancialRecordNature?
        > {
  const FinancialRecordNatureNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'financialRecordNatureProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$financialRecordNatureNotifierHash();

  @$internal
  @override
  FinancialRecordNatureNotifier create() => FinancialRecordNatureNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FinancialRecordNature? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FinancialRecordNature?>(value),
    );
  }
}

String _$financialRecordNatureNotifierHash() =>
    r'8a02788f48137817d1ddbda67dc28bbf80adc06c';

abstract class _$FinancialRecordNatureNotifier
    extends $Notifier<FinancialRecordNature?> {
  FinancialRecordNature? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<FinancialRecordNature?, FinancialRecordNature?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FinancialRecordNature?, FinancialRecordNature?>,
              FinancialRecordNature?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
