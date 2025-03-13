part of 'generics.dart';

extension NavigationExtension on BuildContext {
  void pushPage(Widget page) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => page));
  }

  void pushReplacementPage(Widget page, Function()? fun) {
    Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (context) => page)).then((c) {
      if (fun != null) {
        fun();
      }
    });
  }

  void pushAndRemoveUntilPage(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  void popUntilPage() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void popPage() {
    Navigator.of(this).pop();
  }
}

extension MediaQueryValues on BuildContext {
  double get mWidth => MediaQuery.of(this).size.width;
  double get mHeight => MediaQuery.of(this).size.height;
}

extension BuildContextUtils on BuildContext {
  bool get isDarkTheme {
    return select((AppCubit cubit) => cubit.state.isDarkTheme);
  }

  bool get showOnboarding {
    return select((AppCubit cubit) => cubit.state.showOnboarding);
  }

  bool get isAuthenticated {
    return select((AppCubit cubit) => cubit.state.isAuthenticated);
  }

  Locale get locale {
    return select((AppCubit cubit) => cubit.state.locale);
  }

  Color get monochromeColor {
    return isDarkTheme
        ? KineticEnergyColorTheme().white
        : KineticEnergyColorTheme().black;
  }

  Color get shimmerBaseColor {
    return isDarkTheme
        ? KineticEnergyColorTheme().darkShimmerBaseColor
        : KineticEnergyColorTheme().lightShimmerBaseColor;
  }

  Color get shimmerHighlightColor {
    return isDarkTheme
        ? KineticEnergyColorTheme().darkShimmerHighlightColor
        : KineticEnergyColorTheme().lightShimmerHighlightColor;
  }

  TextStyle get headingText =>
      KineticEnergyTextTheme().headingText.copyWith(color: monochromeColor);

  TextStyle get bodyText =>
      KineticEnergyTextTheme().bodyText.copyWith(color: monochromeColor);

  TextStyle get lightText =>
      KineticEnergyTextTheme().lightText.copyWith(color: monochromeColor);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String timeAgo() {
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(this).toLocal();
    Duration diff = now.difference(dateTime);

    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else if (diff.inDays < 30) {
      return '${(diff.inDays / 7).floor()}w ago';
    } else if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()}mo ago';
    } else {
      return '${(diff.inDays / 365).floor()}y ago';
    }
  }
}

extension SnackbarExtension on BuildContext {
  void showSnackbar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    final bgColor = backgroundColor ?? KineticEnergyColorTheme().primary;
    final txtStyle =
        textStyle ??
        KineticEnergyTextTheme().lightText.copyWith(
          color: KineticEnergyColorTheme().white,
        );

    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: bgColor,
          content: Text(message, style: txtStyle),
          duration: duration,
        ),
      );
  }
}

extension ToBitDescription on Widget {
  Future<Uint8List> _createImageFromWidget(
    Widget widget, {
    Size? logicalSize,
    required Duration waitToRender,
    required ui.FlutterView view,
    Size? imageSize,
  }) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    logicalSize ??= view.physicalSize / view.devicePixelRatio;
    imageSize ??= view.physicalSize;
    final RenderView renderView = RenderView(
      view: view,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        physicalConstraints:
            BoxConstraints.tight(logicalSize) * view.devicePixelRatio,
        logicalConstraints: BoxConstraints.tight(logicalSize),
        devicePixelRatio: view.devicePixelRatio,
      ),
    );
    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();
    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
          container: repaintBoundary,
          child: widget,
        ).attachToRenderTree(buildOwner);
    buildOwner.buildScope(rootElement);
    await Future.delayed(waitToRender);
    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();
    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();
    ui.Image image = await repaintBoundary.toImage(
      pixelRatio: imageSize.width / logicalSize.width,
    );

    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  // Future<BitmapDescriptor> toBitmapDescriptor({
  //   Size? logicalSize,
  //   Size? imageSize,
  //   Duration waitToRender = const Duration(milliseconds: 300),
  //   TextDirection textDirection = TextDirection.ltr,
  // }) async {
  //   final widget = RepaintBoundary(
  //     child: MediaQuery(
  //       data: const MediaQueryData(),
  //       child: Directionality(textDirection: TextDirection.ltr, child: this),
  //     ),
  //   );
  //   final view = ui.PlatformDispatcher.instance.views.first;
  //   final pngBytes = await _createImageFromWidget(
  //     widget,
  //     waitToRender: waitToRender,
  //     view: view,
  //     logicalSize: logicalSize,
  //     imageSize: imageSize,
  //   );
  //   return BitmapDescriptor.bytes(
  //     pngBytes,
  //     imagePixelRatio: view.devicePixelRatio,
  //   );
  // }
}

extension KineticEnergyFontWeight on FontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}
