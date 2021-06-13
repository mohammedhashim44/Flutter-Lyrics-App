import 'package:flutter/material.dart';

class LyricsTextWidget extends StatelessWidget {
  final String lyrics;

  const LyricsTextWidget(this.lyrics) : assert(lyrics != null);

  @override
  Widget build(BuildContext context) {
    var textSpans = getTextSpans(context);

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: RichText(
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textAlign: TextAlign.center,
          text: TextSpan(
            children: textSpans,
          ),
        ),
      ),
    );
  }

  List<TextSpan> getTextSpans(BuildContext context) {
    List<String> texts = lyrics.split("\n");
    List<TextSpan> textSpans = [];

    TextStyle lyricsTextStyle = TextStyle(
      fontSize: 18,
      fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
    );

    TextStyle verseTextStyle = lyricsTextStyle.copyWith(
      color: Theme.of(context).accentColor,
      fontWeight: FontWeight.w800,
    );

    texts.forEach((element) {
      bool isTextVerse = false;
      try {
        var trimmedString = element.trim();
        var n = trimmedString.length;
        bool startWithBracket = trimmedString[0] == "[";
        bool endWithBracket = trimmedString[n - 1] == "]";
        isTextVerse = startWithBracket && endWithBracket;
      } catch (e) {}

      textSpans.add(
        TextSpan(
          text: element + "\n",
          style: isTextVerse ? verseTextStyle : lyricsTextStyle,
        ),
      );
    });
    return textSpans;
  }
}

