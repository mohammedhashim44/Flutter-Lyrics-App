import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class FavoriteIconWidget extends StatefulWidget {
  final double size;
  final bool isSaved;
  final Function onIconClicked;

  const FavoriteIconWidget(this.isSaved, this.onIconClicked,{this.size = 28,})
      : assert(isSaved != null);

  @override
  _FavoriteIconWidgetState createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends State<FavoriteIconWidget> {
  String favoriteAnimation = "Favorite";
  String unFavoriteAnimation = "Unfavorite";
  String animation;
  double size ;

  @override
  void initState() {
    super.initState();
    size = widget.size;
    animation = widget.isSaved ? favoriteAnimation : unFavoriteAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeAnimation,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Container(
          height: size,
          width: size,
          child: FlareActor(
            "assets/flare_animations/favorite_and_unfavorite.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: animation,
            shouldClip: false,
            color: Colors.white,
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
