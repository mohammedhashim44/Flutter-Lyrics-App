import 'package:dio/dio.dart';
import 'package:flutter_lyrics/src/models/song_data.dart';
import 'package:flutter_lyrics/src/models/song_search_result.dart';

import 'dart:convert';
import 'package:html/parser.dart' as parser;

const GENIUS_BASE_URL = "https://api.genius.com/";
const GENIUS_WEB_URL = "https://genius.com";

const GENIUS_SEARCH_URL = GENIUS_BASE_URL + "search/";
const GENIUS_SONG_URL = GENIUS_BASE_URL + "songs/";

const GENIUS_TOKEN = "YOUR_TOKEN_HERE";

// in milliseconds = 20 seconds
const requestTimeoutDurationInMilliseconds = 20 * 1000;

abstract class SongsRepository {
  Future<SongSearchResult> getSearchResults(String songName);

  Future<SongData> fetchSongDataFromIdentifier(String link);
}

class APISongsRepository extends SongsRepository {
  Dio _dio;
  var apiHeaders;

  APISongsRepository() {
    if (_dio == null) {
      String authHeader = 'Bearer ' + GENIUS_TOKEN;
      apiHeaders = {
        'authorization': authHeader,
      };

      BaseOptions options = new BaseOptions(
        connectTimeout: requestTimeoutDurationInMilliseconds,
        receiveTimeout: requestTimeoutDurationInMilliseconds,
      );
      _dio = new Dio(options);
    }
  }

  @override
  Future<SongSearchResult> getSearchResults(String songName) async {
    String searchUrl = GENIUS_SEARCH_URL + "?q=$songName";
    var response = await _dio.get(searchUrl,options: Options(
      headers: apiHeaders,
    ));

    var songsData = response.data["response"];
    return SongSearchResult.fromJson(songsData);
  }

  @override
  Future<SongData> fetchSongDataFromIdentifier(String identifier) async {
    String songUrl = GENIUS_SONG_URL + "$identifier";
    songUrl = "$songUrl?text_format=plain";

    print("FETCH SONG DATA : IDENTIFIER => $identifier");
    print(songUrl);

    var response = await _dio.get(songUrl,options: Options(
      headers: apiHeaders,
    ));
    var jsonData = response.data["response"]["song"];

    var songLink = response.data["response"]["song"]["path"];
    String lyrics = await getSongLyricsFromLink(songLink);

    var songData = SongData.fromJson(jsonData);
    songData.lyrics = lyrics;

    return songData;
  }

  // Helper function
  Future<String> getSongLyricsFromLink(String link) async {
    String songUrl = GENIUS_WEB_URL + "$link";
    print(songUrl);
    var response = await _dio.get(songUrl);
    String htmlText = response.data;
    var parsedDoc = parser.parse(htmlText);

    var lyricsElement = parsedDoc.getElementsByClassName("lyrics");
    print("ELEMENTS FOUND : ${lyricsElement.length}");
    if (lyricsElement.length == 1) {
      String lyricsText = lyricsElement.first.text;
      lyricsText = lyricsText.replaceAll("<br/>", "\n").replaceAll("<br>", "\n");
      lyricsText = lyricsText.trim();
      return lyricsText;
    } else {
      throw Exception("No Lyrics Found");
    }
  }
}

class FakeSongsRepository extends SongsRepository {
  @override
  Future<SongSearchResult> getSearchResults(String songName) async {
    await Future.delayed(Duration(seconds: 1));
    return SongSearchResult.fromJson(jsonDecode(getFakeSearchResults()));
  }

  @override
  Future<SongData> fetchSongDataFromIdentifier(String link) async {
    return SongData(
        "identifier", "songTitle", "singer", "image", "description", "lyrics");
  }

  String getFakeSearchResults() {
    return """{ "success": true, "songs": [ { "song_name": "Perfect", "singer": "Ed Sheeran", "link": "https://www.lyricsmode.com/lyrics/e/ed_sheeran/perfect.html" }, { "song_name": "Perfect", "singer": "Simple Plan", "link": "https://www.lyricsmode.com/lyrics/s/simple_plan/perfect.html" }, { "song_name": "Perfect", "singer": "Juice WRLD", "link": "https://www.lyricsmode.com/juice_wrld-perfect-1676857.html" }, { "song_name": "Perfect", "singer": "Cousin Stizz", "link": "https://www.lyricsmode.com/cousin_stizz-perfect-1671425.html" }, { "song_name": "Perfect", "singer": "Depeche Mode", "link": "https://www.lyricsmode.com/lyrics/d/depeche_mode/perfect.html" }, { "song_name": "Perfect", "singer": "Lady Gaga", "link": "https://www.lyricsmode.com/lyrics/l/lady_gaga/perfect.html" }, { "song_name": "Perfect", "singer": "A Rain Soaked Romance", "link": "https://www.lyricsmode.com/lyrics/a/a_rain_soaked_romance/perfect.html" }, { "song_name": "Perfect", "singer": "Aaa", "link": "https://www.lyricsmode.com/lyrics/a/aaa/perfect.html" }, { "song_name": "Perfect", "singer": "Acroma", "link": "https://www.lyricsmode.com/lyrics/a/acroma/perfect.html" }, { "song_name": "Perfect", "singer": "Adam Cappa", "link": "https://www.lyricsmode.com/lyrics/a/adam_cappa/perfect.html" }, { "song_name": "Perfect", "singer": "Alanis Morissette", "link": "https://www.lyricsmode.com/lyrics/a/alanis_morissette/perfect.html" }, { "song_name": "Perfect", "singer": "Alexandra Burke", "link": "https://www.lyricsmode.com/lyrics/a/alexandra_burke/perfect.html" }, { "song_name": "Perfect", "singer": "Alexz Johnson", "link": "https://www.lyricsmode.com/lyrics/a/alexz_johnson/perfect.html" }, { "song_name": "Perfect", "singer": "Alice Cooper", "link": "https://www.lyricsmode.com/lyrics/a/alice_cooper/perfect.html" }, { "song_name": "Perfect", "singer": "All-4-One", "link": "https://www.lyricsmode.com/lyrics/a/all_4_one/perfect.html" }, { "song_name": "Perfect", "singer": "Amber Run", "link": "https://www.lyricsmode.com/lyrics/a/amber_run/perfect.html" }, { "song_name": "Perfect", "singer": "Angie Stone", "link": "https://www.lyricsmode.com/angie_stone-perfect-1672601.html" }, { "song_name": "Perfect", "singer": "Anne-Marie", "link": "https://www.lyricsmode.com/lyrics/a/anne_marie/perfect.html" }, { "song_name": "Perfect", "singer": "Ant & Dec", "link": "https://www.lyricsmode.com/lyrics/a/ant_dec/perfect.html" }, { "song_name": "Perfect", "singer": "Army Of Me", "link": "https://www.lyricsmode.com/lyrics/a/army_of_me/perfect.html" }, { "song_name": "Perfect", "singer": "Atmosphere", "link": "https://www.lyricsmode.com/lyrics/a/atmosphere/perfect.html" }, { "song_name": "Perfect", "singer": "Berman", "link": "https://www.lyricsmode.com/lyrics/b/berman/perfect.html" }, { "song_name": "Perfect", "singer": "Billy Redfield", "link": "https://www.lyricsmode.com/lyrics/b/billy_redfield/perfect.html" }, { "song_name": "Perfect", "singer": "Blitz Kids", "link": "https://www.lyricsmode.com/lyrics/b/blitz_kids/perfect.html" }, { "song_name": "Perfect", "singer": "Britton Buchanan", "link": "https://www.lyricsmode.com/lyrics/b/britton_buchanan/perfect.html" }, { "song_name": "Perfect", "singer": "Burn Season", "link": "https://www.lyricsmode.com/lyrics/b/burn_season/perfect.html" }, { "song_name": "Perfect", "singer": "By The Tree", "link": "https://www.lyricsmode.com/lyrics/b/by_the_tree/perfect.html" }, { "song_name": "Perfect", "singer": "Cam Meekins", "link": "https://www.lyricsmode.com/cam_meekins-perfect-1686603.html" }, { "song_name": "Perfect", "singer": "Camouflage", "link": "https://www.lyricsmode.com/lyrics/c/camouflage/perfect.html" }, { "song_name": "Perfect", "singer": "Christina Milian", "link": "https://www.lyricsmode.com/lyrics/c/christina_milian/perfect.html" }, { "song_name": "Perfect", "singer": "Cody Simpson", "link": "https://www.lyricsmode.com/lyrics/c/cody_simpson/perfect.html" }, { "song_name": "Perfect", "singer": "Cult To Follow", "link": "https://www.lyricsmode.com/lyrics/c/cult_to_follow/perfect.html" }, { "song_name": "Perfect", "singer": "Dance Gavin Dance", "link": "https://www.lyricsmode.com/lyrics/d/dance_gavin_dance/perfect.html" }, { "song_name": "Perfect", "singer": "Danny Michel", "link": "https://www.lyricsmode.com/lyrics/d/danny_michel/perfect.html" }, { "song_name": "Perfect", "singer": "Darin", "link": "https://www.lyricsmode.com/lyrics/d/darin/perfect.html" }, { "song_name": "Perfect", "singer": "Darius Rucker", "link": "https://www.lyricsmode.com/lyrics/d/darius_rucker/perfect.html" }, { "song_name": "Perfect", "singer": "Darren Hayes", "link": "https://www.lyricsmode.com/lyrics/d/darren_hayes/perfect.html" }, { "song_name": "Perfect", "singer": "Dave East", "link": "https://www.lyricsmode.com/lyrics/d/dave_east/perfect.html" }, { "song_name": "Perfect", "singer": "Daville", "link": "https://www.lyricsmode.com/lyrics/d/daville/perfect.html" }, { "song_name": "Perfect", "singer": "Deborah Campioni", "link": "https://www.lyricsmode.com/lyrics/d/deborah_campioni/perfect.html" }, { "song_name": "Perfect", "singer": "Devon", "link": "https://www.lyricsmode.com/lyrics/d/devon/perfect.html" }, { "song_name": "Perfect", "singer": "Diamond Efsane", "link": "https://www.lyricsmode.com/lyrics/d/diamond_efsane/perfect.html" }, { "song_name": "Perfect", "singer": "Die Happy", "link": "https://www.lyricsmode.com/lyrics/d/die_happy/perfect.html" }, { "song_name": "Perfect", "singer": "Dilba", "link": "https://www.lyricsmode.com/lyrics/d/dilba/perfect.html" }, { "song_name": "Perfect", "singer": "Doria Roberts", "link": "https://www.lyricsmode.com/lyrics/d/doria_roberts/perfect.html" }, { "song_name": "Perfect", "singer": "Drew Seeley", "link": "https://www.lyricsmode.com/lyrics/d/drew_seeley/perfect.html" }, { "song_name": "Perfect", "singer": "Eddi Reader", "link": "https://www.lyricsmode.com/lyrics/e/eddi_reader/perfect.html" }, { "song_name": "Perfect", "singer": "Emma Blackery", "link": "https://www.lyricsmode.com/lyrics/e/emma_blackery/perfect.html" }, { "song_name": "Perfect", "singer": "Fairground Attraction", "link": "https://www.lyricsmode.com/lyrics/f/fairground_attraction/perfect.html" }, { "song_name": "Perfect", "singer": "Flyleaf", "link": "https://www.lyricsmode.com/lyrics/f/flyleaf/perfect.html" } ] }""";
  }

  String getFakeLyrics() {
    String fakeLyrics = """{
                            "success": true, 
                            "lyrics": "$perfectLyrics" 
                              }""";
    return fakeLyrics;
  }
}

var perfectLyrics = """
I found a love for me
Darling, just dive right in and follow my lead
Well, I found a girl, beautiful and sweet
Oh, I never knew you were the someone waiting for me

'Cause we were just kids when we fell in love
Not knowing what it was
I will not give you up this time
But darling, just kiss me slow
Your heart is all I own
And in your eyes you're holding mine

Baby, I'm dancing in the dark
With you between my arms
Barefoot on the grass
Listening to our favourite song
When you said you looked a mess
I whispered underneath my breath
But you heard it,
Darling, you look perfect tonight

Well, I found a woman, stronger than anyone I know
She shares my dreams, I hope that someday I'll share her home
I found a love to carry more than just my secrets
To carry love, to carry children of our own

We are still kids but we're so in love
Fighting against all odds
I know we'll be alright this time
Darling, just hold my hand
Be my girl, I'll be your man
I see my future in your eyes

Baby, I'm dancing in the dark
With you between my arms
Barefoot on the grass
Listening to our favourite song
When I saw you in that dress
Looking so beautiful
I don't deserve this
Darling, you look perfect tonight

No, no, no

Baby, I'm dancing in the dark
With you between my arms
Barefoot on the grass
Listening to our favourite song
I have faith in what I see
Now I know I have met an angel in person
And she looks perfect
I don't deserve this
You look perfect tonight
""";
