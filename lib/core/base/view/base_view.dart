import 'package:flutter/material.dart';
export '../../../civciv/appbar.dart';
import '../../../civciv/appbar.dart';
import '../../../civciv/loader.dart';
import '../state/base_state.dart';

class BaseView extends StatefulWidget {
  final CivcivAppBar? appBar;
  final Widget? body;
  final bool transparent;
  final bool bottombarActive;
  final bool gradient;
  final bool darkGradient;
  final bool resizeToAvoidBottomInset;
  final bool isLoading;
  final Color? backgroundColor;
  final bool fieldActive;
  final bool logoActive;
  final bool? extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const BaseView({
    super.key,
    this.appBar,
    this.body,
    this.transparent = false,
    this.bottombarActive = false,
    this.gradient = true,
    this.darkGradient = false,
    this.resizeToAvoidBottomInset = false,
    this.isLoading = false,
    this.backgroundColor,
    this.fieldActive = false,
    this.logoActive = false,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar,
    this.floatingActionButton,
  });

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends BaseState<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: widget.appBar,
      extendBody: widget.extendBodyBehindAppBar ?? false,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? widget.transparent,
      backgroundColor: widget.backgroundColor ?? themeData.scaffoldBackgroundColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () => widget.fieldActive ? FocusScope.of(context).unfocus() : null,
        child: Visibility(visible: !widget.isLoading, replacement: const CivcivLoader(), child: widget.body ?? const SizedBox()),
      ),
    );
  }
}
