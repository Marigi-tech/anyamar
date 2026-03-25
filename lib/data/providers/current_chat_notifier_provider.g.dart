// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_chat_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentChatNotifier)
const currentChatProvider = CurrentChatNotifierProvider._();

final class CurrentChatNotifierProvider
    extends $NotifierProvider<CurrentChatNotifier, Chat?> {
  const CurrentChatNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentChatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentChatNotifierHash();

  @$internal
  @override
  CurrentChatNotifier create() => CurrentChatNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Chat? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Chat?>(value),
    );
  }
}

String _$currentChatNotifierHash() =>
    r'76cad03ac38621460a4baa280b8761c15dc3c906';

abstract class _$CurrentChatNotifier extends $Notifier<Chat?> {
  Chat? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Chat?, Chat?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Chat?, Chat?>,
              Chat?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
