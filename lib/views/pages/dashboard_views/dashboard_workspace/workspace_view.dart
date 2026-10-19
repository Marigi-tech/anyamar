
import 'package:flutter/material.dart';

abstract class WorkspaceView {
  const WorkspaceView();
}

/// Displays one of the existing main pages.
class PageWorkspaceView extends WorkspaceView {
  final int pageIndex;

  const PageWorkspaceView(this.pageIndex);
}

/// Displays a form or another standalone widget.
class WidgetWorkspaceView extends WorkspaceView {
  final Widget child;

  const WidgetWorkspaceView(this.child);
}
