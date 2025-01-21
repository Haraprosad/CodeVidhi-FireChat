import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:codevidhi_firechat/core/constants/asset_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImageView extends StatelessWidget {
  /// [imagePath] is required for showing the image
  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final String placeHolder;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;

  /// A [CustomImageView] that can display different types of images.
  /// If the image is not found, it shows the placeholder image.
  const CustomImageView({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.radius,
    this.margin,
    this.border,
    this.placeHolder = AssetConstants.imageNotFound,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = _buildImageView();

    if (alignment != null) {
      imageWidget = Align(
        alignment: alignment!,
        child: imageWidget,
      );
    }

    if (margin != null) {
      imageWidget = Padding(
        padding: margin!,
        child: imageWidget,
      );
    }

    return InkWell(
      onTap: onTap,
      child: imageWidget,
    );
  }

  Widget _buildImageView() {
    if (imagePath != null && imagePath!.isNotEmpty) {
      switch (imagePath!.imageType) {
        case ImageType.svg:
          return SvgPicture.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            color: color,
          );
        case ImageType.file:
          return Image.file(
            File(imagePath!),
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
        case ImageType.network:
          return CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: imagePath!,
            color: color,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (_, __, ___) => Image.asset(
              placeHolder,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
          );
        case ImageType.png:
        default:
          return Image.asset(
            imagePath!,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
            color: color,
          );
      }
    }

    return Image.asset(
      placeHolder,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }
}

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }
