import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppImage extends StatelessWidget {
  final String image;
  final double imageSize;
  double? width;
  double? height;
  final bool square;
  final bool circle;
  final double roundness;
  final Color backgroundColor;

  AppImage(
    this.image, {
    Key? key,
    this.imageSize = 70,
    this.width,
    this.height,
    this.square = true,
    this.circle = false,
    this.roundness = 5.0,
    this.backgroundColor = const Color(0xffe7e7e7e),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (square) {
      width = imageSize;
      height = imageSize;
    }

    if (image == "null") {
      return getImageErrorWidget();
    }

    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: image,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          getProgressWidget(downloadProgress.progress),
      imageBuilder: (context, imageProvider) =>
          getLoadedImageWidget(imageProvider),
      errorWidget: (context, url, error) => getImageErrorWidget(),
    );
  }

  Widget getProgressWidget(double? progress) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        borderRadius: circle
            ? BorderRadius.all(Radius.circular(imageSize))
            : BorderRadius.all(Radius.circular(roundness)),
        color: backgroundColor,
      ),
      child: Center(
        child: CircularProgressIndicator(
          value: progress,
        ),
      ),
    );
  }

  Widget getImageErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: circle
            ? BorderRadius.all(Radius.circular(imageSize))
            : BorderRadius.all(Radius.circular(roundness)),
      ),
    );
  }

  Widget getLoadedImageWidget(ImageProvider imageProvider) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        borderRadius: circle
            ? BorderRadius.all(Radius.circular(imageSize))
            : BorderRadius.all(Radius.circular(roundness)),
      ),
    );
  }
}
