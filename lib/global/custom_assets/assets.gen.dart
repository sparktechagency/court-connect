/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:lottie/lottie.dart' as _lottie;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/about.svg
  SvgGenImage get about => const SvgGenImage('assets/icons/about.svg');

  /// File path: assets/icons/booking_error.svg
  SvgGenImage get bookingError =>
      const SvgGenImage('assets/icons/booking_error.svg');

  /// File path: assets/icons/booking_success.svg
  SvgGenImage get bookingSuccess =>
      const SvgGenImage('assets/icons/booking_success.svg');

  /// File path: assets/icons/comment.svg
  SvgGenImage get comment => const SvgGenImage('assets/icons/comment.svg');

  /// File path: assets/icons/date.svg
  SvgGenImage get date => const SvgGenImage('assets/icons/date.svg');

  /// File path: assets/icons/details_icons.svg
  SvgGenImage get detailsIcons =>
      const SvgGenImage('assets/icons/details_icons.svg');

  /// File path: assets/icons/group_bottom.svg
  SvgGenImage get groupBottom =>
      const SvgGenImage('assets/icons/group_bottom.svg');

  /// File path: assets/icons/homeBottom.svg
  SvgGenImage get homeBottom =>
      const SvgGenImage('assets/icons/homeBottom.svg');

  /// File path: assets/icons/location.svg
  SvgGenImage get location => const SvgGenImage('assets/icons/location.svg');

  /// File path: assets/icons/log_out.svg
  SvgGenImage get logOut => const SvgGenImage('assets/icons/log_out.svg');

  /// File path: assets/icons/menu.svg
  SvgGenImage get menu => const SvgGenImage('assets/icons/menu.svg');

  /// File path: assets/icons/message.svg
  SvgGenImage get message => const SvgGenImage('assets/icons/message.svg');

  /// File path: assets/icons/message_icons.svg
  SvgGenImage get messageIcons =>
      const SvgGenImage('assets/icons/message_icons.svg');

  /// File path: assets/icons/money.svg
  SvgGenImage get money => const SvgGenImage('assets/icons/money.svg');

  /// File path: assets/icons/my_book.svg
  SvgGenImage get myBook => const SvgGenImage('assets/icons/my_book.svg');

  /// File path: assets/icons/privacy.svg
  SvgGenImage get privacy => const SvgGenImage('assets/icons/privacy.svg');

  /// File path: assets/icons/profile_edit.svg
  SvgGenImage get profileEdit =>
      const SvgGenImage('assets/icons/profile_edit.svg');

  /// File path: assets/icons/profile_nav.svg
  SvgGenImage get profileNav =>
      const SvgGenImage('assets/icons/profile_nav.svg');

  /// File path: assets/icons/remove_photo.svg
  SvgGenImage get removePhoto =>
      const SvgGenImage('assets/icons/remove_photo.svg');

  /// File path: assets/icons/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/icons/settings.svg');

  /// File path: assets/icons/support.svg
  SvgGenImage get support => const SvgGenImage('assets/icons/support.svg');

  /// File path: assets/icons/terms.svg
  SvgGenImage get terms => const SvgGenImage('assets/icons/terms.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        about,
        bookingError,
        bookingSuccess,
        comment,
        date,
        detailsIcons,
        groupBottom,
        homeBottom,
        location,
        logOut,
        menu,
        message,
        messageIcons,
        money,
        myBook,
        privacy,
        profileEdit,
        profileNav,
        removePhoto,
        settings,
        support,
        terms
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/coin.png
  AssetGenImage get coin => const AssetGenImage('assets/images/coin.png');

  /// File path: assets/images/group.png
  AssetGenImage get group => const AssetGenImage('assets/images/group.png');

  /// File path: assets/images/home_image.png
  AssetGenImage get homeImage =>
      const AssetGenImage('assets/images/home_image.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/man.png
  AssetGenImage get man => const AssetGenImage('assets/images/man.png');

  /// File path: assets/images/other_profile_cover.png
  AssetGenImage get otherProfileCover =>
      const AssetGenImage('assets/images/other_profile_cover.png');

  /// File path: assets/images/photo_upload.png
  AssetGenImage get photoUpload =>
      const AssetGenImage('assets/images/photo_upload.png');

  /// File path: assets/images/splash_bottom.png
  AssetGenImage get splashBottom =>
      const AssetGenImage('assets/images/splash_bottom.png');

  /// File path: assets/images/splash_top.png
  AssetGenImage get splashTop =>
      const AssetGenImage('assets/images/splash_top.png');

  /// File path: assets/images/support_logo.png
  AssetGenImage get supportLogo =>
      const AssetGenImage('assets/images/support_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        coin,
        group,
        homeImage,
        logo,
        man,
        otherProfileCover,
        photoUpload,
        splashBottom,
        splashTop,
        supportLogo
      ];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/buttonLoading.json
  LottieGenImage get buttonLoading =>
      const LottieGenImage('assets/lottie/buttonLoading.json');

  /// File path: assets/lottie/no_internet.json
  LottieGenImage get noInternet =>
      const LottieGenImage('assets/lottie/no_internet.json');

  /// List of all assets
  List<LottieGenImage> get values => [buttonLoading, noInternet];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(
      BuildContext,
      Widget,
      _lottie.LottieComposition?,
    )? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
