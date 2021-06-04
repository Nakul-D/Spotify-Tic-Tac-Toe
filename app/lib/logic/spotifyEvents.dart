abstract class SpotifyEvents {}

class ConnectToSpotify extends SpotifyEvents {}

class Resume extends SpotifyEvents {}

class Pause extends SpotifyEvents {}

class SkipNext extends SpotifyEvents {}

class SkipPrevious extends SpotifyEvents {}

class ToggleShuffle extends SpotifyEvents {}

class PlayAlbum extends SpotifyEvents {
  String uri;
  PlayAlbum ({required this.uri});
}
