// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkspaceNotifier)
const workspaceProvider = WorkspaceNotifierProvider._();

final class WorkspaceNotifierProvider
    extends $NotifierProvider<WorkspaceNotifier, WorkspaceView?> {
  const WorkspaceNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workspaceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workspaceNotifierHash();

  @$internal
  @override
  WorkspaceNotifier create() => WorkspaceNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkspaceView? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkspaceView?>(value),
    );
  }
}

String _$workspaceNotifierHash() => r'ca734cd8adb3bd48050eee1be2c9c62f35bccfc0';

abstract class _$WorkspaceNotifier extends $Notifier<WorkspaceView?> {
  WorkspaceView? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WorkspaceView?, WorkspaceView?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WorkspaceView?, WorkspaceView?>,
              WorkspaceView?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
