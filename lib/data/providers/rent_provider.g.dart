// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RentNotifier)
const rentProvider = RentNotifierFamily._();

final class RentNotifierProvider
    extends $AsyncNotifierProvider<RentNotifier, RentHistory?> {
  const RentNotifierProvider._({
    required RentNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'rentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rentNotifierHash();

  @override
  String toString() {
    return r'rentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RentNotifier create() => RentNotifier();

  @override
  bool operator ==(Object other) {
    return other is RentNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rentNotifierHash() => r'6e043ae2ad17ce4cc2c6b06b31500f5b43855259';

final class RentNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          RentNotifier,
          AsyncValue<RentHistory?>,
          RentHistory?,
          FutureOr<RentHistory?>,
          String
        > {
  const RentNotifierFamily._()
    : super(
        retry: null,
        name: r'rentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RentNotifierProvider call(String tenantId) =>
      RentNotifierProvider._(argument: tenantId, from: this);

  @override
  String toString() => r'rentProvider';
}

abstract class _$RentNotifier extends $AsyncNotifier<RentHistory?> {
  late final _$args = ref.$arg as String;
  String get tenantId => _$args;

  FutureOr<RentHistory?> build(String tenantId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<RentHistory?>, RentHistory?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RentHistory?>, RentHistory?>,
              AsyncValue<RentHistory?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
