class Flag {
  bool meetWumpus = false;
  bool meetWumpusDead = false;
  bool meetDeadBody = false;
  bool meetBreeze = false;
  bool meetStench = false;
  bool meetSound = false;
  bool meetPit = false;
  bool meetGoal = false;
  bool meetStartToMove = false;
  bool activeWumpus = false;
  bool activeWumpusNear = false;

  Flag();

  void reset(
      {bool wumpus = false,
      bool wumpusDead = false,
      bool deadBody = false,
      bool breeze = false,
      bool stench = false,
      bool sound = false,
      bool pit = false,
      bool goal = false,
      bool startMove = false,
      bool activeWumpus = false,
      bool activeWumpusNear = false}) {
    this.meetWumpus = wumpus;
    this.meetWumpusDead = wumpusDead;
    this.meetDeadBody = deadBody;
    this.meetBreeze = breeze;
    this.meetStench = stench;
    this.meetSound = sound;
    this.meetPit = pit;
    this.meetGoal = goal;
    this.meetStartToMove = startMove;
    this.activeWumpus = activeWumpus;
    this.activeWumpusNear = activeWumpusNear;
  }

  String getSituationPlayer() {
    String res = '';
    if (this.meetWumpus) {
      return 'I-I have never see any monsters this huge!';
    }

    if (this.meetWumpusDead) {
      if (res != '') res = res + '\n';
      res = res + 'Erhh! A dead body of a huge monster!';
    }

    if (this.meetDeadBody) {
      if (res != '') res = res + '\n';
      res = res + 'Erhh! A dead body of a monster!';
    }

    if (!(this.meetDeadBody || this.meetWumpusDead)) {
      if (this.meetStench) {
        if (res != '') res = res + '\n';
        res = res + 'It smells so bad!';
      }
    }

    if (this.meetBreeze) {
      if (res != '') res = res + '\n';
      res = res + 'A gentle breeze...';
    }

    if (this.meetSound) {
      if (res != '') res = res + '\n';
      res = res +
          'Some rocks are falling from ceiling! The lound voice resounds.';
    }

    if (this.meetPit) {
      if (res != '') res = res + '\n';
      res = res + 'Aaaargh!!!';
    }

    if (this.meetGoal) {
      if (res != '') res = res + '\n';
      res = res +
          'Woah! The treasure is shining! Better take it and return to the initial point.';
    }

    if (this.meetStartToMove) {
      if (res != '') res = res + '\n';
      res = res + 'Something has just started to move!';
    }

    return res;
  }

  String getSituationWumpus() {
    String res = '';

    if (this.meetSound) {
      if (res != '') res = res + '\n';
      res = res +
          'Some rocks are falling from ceiling! The lound voice resounds.';
    }

    if (this.activeWumpus && !this.activeWumpusNear) {
      if (res != '') res = res + '\n';
      res = res + 'Something is moving around. The ground is shaking a little.';
    }

    if (this.activeWumpusNear) {
      if (res != '') res = res + '\n';
      res =
          res + 'Something big must be near! The ground is shaking violently!';
    }

    return res;
  }
}
