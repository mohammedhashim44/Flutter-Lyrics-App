
  
Flutter Lyrics App 
-------------    
 #### Flutter Version Used : 1.22.4
 The app uses [Genius API]("https://docs.genius.com/") to fetch song data and get lyrics.  

 ## Screenshots   
<p float="left">  
 <img src="screenshots/1.jpg" width="200" />  
 <img src="screenshots/2.jpg" width="200" />   
  <img src="screenshots/3.jpg" width="200" />  
 <img src="screenshots/4.jpg" width="200" />  
 <img src="screenshots/5.jpg" width="200" />   
</p>  

-------------    

#### App Features:  
- Search for songs by name,artist or lyrics.
- View lyrics.
- Save songs lyrics for offline use.
- Animation for loading and error screens.
- Multiple themes and dynamic font size.
- Cached images.
-------------    
#### NOTE:  
- To build and run the app successfully you need to get access token from Genius.
- **It's free**, just create an account  in [Genius API]("https://docs.genius.com/")  and generate new token.
- After you get the token, put it in:
	- In the file : `lib/src/repositories/songs_repository.dart`
	- In the line: `const GENIUS_TOKEN = "YOUR_TOKEN_HERE";`
	- Put your token here.
-------------   
