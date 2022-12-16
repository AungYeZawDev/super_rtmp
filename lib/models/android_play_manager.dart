enum PlayerFactory {
  exo2PlayerManager(0),

  systemPlayerManager(1),

  ijkPlayerManager(2);
  const PlayerFactory(this.mode);
  final int mode;
}