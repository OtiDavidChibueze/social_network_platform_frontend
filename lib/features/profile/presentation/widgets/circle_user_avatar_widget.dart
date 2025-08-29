import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleUserAvatarWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? url;

  const CircleUserAvatarWidget({super.key, this.width, this.height, this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: CachedNetworkImageProvider(url ?? ''),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
