import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FavoriteIconWidget extends StatefulWidget {
  final bool isSaved;
  final Function onIconClicked;

  const FavoriteIconWidget(this.isSaved, this.onIconClicked)
      : assert(isSaved != null);

  @override
  _FavoriteIconWidgetState createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  String favoriteAnimation = "Favorite";
  String unFavoriteAnimation = "Unfavorite";
  String animation;
  double size = 40;

  @override
  void initState() {
    super.initState();
    animation = widget.isSaved ? favoriteAnimation : unFavoriteAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeAnimation,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Container(
          height: size,
          width: size,
          child: FlareActor(
            "assets/flare_animations/favorite_and_unfavorite.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: animation,
            shouldClip: false,
          ),
        ),
      ),
    );
  }

  void changeAnimation() {
    setState(
          () {
        animation = (animation == favoriteAnimation)
            ? unFavoriteAnimation
            : favoriteAnimation;
        widget.onIconClicked();
      },
    );
  }
}
