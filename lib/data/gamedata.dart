class GameData {
  static int maxLevel;
  static int level;
  static void Function(void Function()) levelBar;

  static List<List<int>> levelData = [
    [4, 0, 1, 0],
    [5, 0, 1, 0],
    [5, 0, 3, 0],
    [5, 1, 4, 0],
    [6, 0, 5, 0],
    [6, 1, 5, 0],
    [6, 3, 5, 0],
    [6, 1, 10, 2],
    [7, 2, 10, 3],
    [7, 0, 10, 10],
    [7, 5, 10, 0],
    [8, 5, 20, 5],
    [8, 5, 20, 5],
    [9, 5, 20, 10],
    [9, 5, 20, 15],
    [9, 5, 20, 15],
    [10, 0, 20, 20],
    [10, 5, 20, 5],
    [10, 10, 20, 0],
    [10, 10, 20, 10],
  ];

  static List<List<String>> tutorialData(int level) {
    if (level == 1)
      return [
        [
          'assets/images/TutorialGoal.png',
          'A treasure is lying deep down underground. What are you waiting, adventurer?'
        ],
        [
          'assets/images/TutorialPit.png',
          'An unstable step can lead to doom! This death pit emits breeze around it. Try to avoid it at all cost!'
        ],
        [
          'assets/images/TutorialWumpus.png',
          'A deadly monster is roaming around! A bad smell would alert you whenever it is near!'
        ]
      ];
    if (level == 2)
      return [
        [
          'assets/images/TutorialArrow.png',
          'An adventurer must prepare for any emergency situations! You have poisonous arrows which is capable of killing anything, but just one! Use it carefully, or the result is not very sweet.'
        ]
      ];
    if (level == 3)
      return [
        [
          'assets/images/TutorialPit.png',
          'There won\'t be just one pit out there! But a wind never comes from two directions.'
        ]
      ];
    if (level == 4)
      return [
        [
          'assets/images/TutorialDeadBody.png',
          'The underground is full of monster corpses. They smell so bad! Maybe they are just preys of something much bigger.'
        ]
      ];
    if (level == 8)
      return [
        [
          'assets/images/TutorialSound.png',
          'This little underground civilian is timid! It would run away right after encountering something, causing a magnitude during the escape. The sound may wake something up.'
        ]
      ];
    return [];
  }
}
