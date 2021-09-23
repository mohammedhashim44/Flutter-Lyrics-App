import 'package:flutter/material.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';
import 'package:flutter_lyrics/src/widgets/app_image.dart';

class SongListItemWidget extends StatelessWidget {
  final SongDetails songDetails;

  const SongListItemWidget(this.songDetails);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Hero(
            tag: songDetails.identifier+"image",
            child: AppImage(
              songDetails.songImage,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: songDetails.identifier+"song_name",
                  child: Text(
                    songDetails.songName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Hero(
                  tag: songDetails.identifier+"singer",
                  child: Text(
                    songDetails.singer,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle1.apply(
                          color: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .color
                              .withOpacity(0.7),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    songDetails.songName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    songDetails.singer,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ],
      ),
    );
  }
}
