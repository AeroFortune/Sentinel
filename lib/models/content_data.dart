class ContentData {
  AdultStories? adultStories;
  KidStories? kidStories;

  ContentData({this.adultStories, this.kidStories});

  ContentData.fromJson(Map<String, dynamic> json) {
    adultStories = json['adult_stories'] != null
        ? new AdultStories.fromJson(json['adult_stories'])
        : null;
    kidStories = json['kid_stories'] != null
        ? new KidStories.fromJson(json['kid_stories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.adultStories != null) {
      data['adult_stories'] = this.adultStories!.toJson();
    }
    if (this.kidStories != null) {
      data['kid_stories'] = this.kidStories!.toJson();
    }
    return data;
  }
}

class AdultStories {
  AdultPart1? adultPart1;
  AdultPart1? adultPart1Alt;
  AdultPart1? adultPart2;
  AdultPart1? adultPart2Alt;
  AdultPart1? adultPart3;
  AdultPart1? adultPart3Alt;
  AdultPart1? adultEpilogue;

  AdultStories(
      {this.adultPart1,
        this.adultPart1Alt,
        this.adultPart2,
        this.adultPart2Alt,
        this.adultPart3,
        this.adultPart3Alt,
        this.adultEpilogue});

  AdultStories.fromJson(Map<String, dynamic> json) {
    adultPart1 = json['adult_part1'] != null
        ? new AdultPart1.fromJson(json['adult_part1'])
        : null;
    adultPart1Alt = json['adult_part1_alt'] != null
        ? new AdultPart1.fromJson(json['adult_part1_alt'])
        : null;
    adultPart2 = json['adult_part2'] != null
        ? new AdultPart1.fromJson(json['adult_part2'])
        : null;
    adultPart2Alt = json['adult_part2_alt'] != null
        ? new AdultPart1.fromJson(json['adult_part2_alt'])
        : null;
    adultPart3 = json['adult_part3'] != null
        ? new AdultPart1.fromJson(json['adult_part3'])
        : null;
    adultPart3Alt = json['adult_part3_alt'] != null
        ? new AdultPart1.fromJson(json['adult_part3_alt'])
        : null;
    adultEpilogue = json['adult_epilogue'] != null
        ? new AdultPart1.fromJson(json['adult_epilogue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.adultPart1 != null) {
      data['adult_part1'] = this.adultPart1!.toJson();
    }
    if (this.adultPart1Alt != null) {
      data['adult_part1_alt'] = this.adultPart1Alt!.toJson();
    }
    if (this.adultPart2 != null) {
      data['adult_part2'] = this.adultPart2!.toJson();
    }
    if (this.adultPart2Alt != null) {
      data['adult_part2_alt'] = this.adultPart2Alt!.toJson();
    }
    if (this.adultPart3 != null) {
      data['adult_part3'] = this.adultPart3!.toJson();
    }
    if (this.adultPart3Alt != null) {
      data['adult_part3_alt'] = this.adultPart3Alt!.toJson();
    }
    if (this.adultEpilogue != null) {
      data['adult_epilogue'] = this.adultEpilogue!.toJson();
    }
    return data;
  }
}

class AdultPart1 {
  String? id;
  String? storyChapterTitle;
  String? storyIntermissionDesc;
  String? storySelectionDesc;
  List<String>? choices;
  int? choiceSelected;
  bool? unlocked;

  AdultPart1(
      {this.id,
        this.storyChapterTitle,
        this.storyIntermissionDesc,
        this.storySelectionDesc,
        this.choices,
        this.choiceSelected,
        this.unlocked});

  AdultPart1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storyChapterTitle = json['story_chapter_title'];
    storyIntermissionDesc = json['story_intermission_desc'];
    storySelectionDesc = json['story_selection_desc'];
    choices = json['choices'].cast<String>();
    choiceSelected = json['choice_selected'];
    unlocked = json['unlocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['story_chapter_title'] = this.storyChapterTitle;
    data['story_intermission_desc'] = this.storyIntermissionDesc;
    data['story_selection_desc'] = this.storySelectionDesc;
    data['choices'] = this.choices;
    data['choice_selected'] = this.choiceSelected;
    data['unlocked'] = this.unlocked;
    return data;
  }
}

class KidStories {
  AdultPart1? kidPart1;
  AdultPart1? kidPart1Alt;
  AdultPart1? kidPart2;
  AdultPart1? kidPart2Alt;
  AdultPart1? kidPart3;
  AdultPart1? kidPart3Alt;
  AdultPart1? kidEpilogue;

  KidStories(
      {this.kidPart1,
        this.kidPart1Alt,
        this.kidPart2,
        this.kidPart2Alt,
        this.kidPart3,
        this.kidPart3Alt,
        this.kidEpilogue});

  KidStories.fromJson(Map<String, dynamic> json) {
    kidPart1 = json['kid_part1'] != null
        ? new AdultPart1.fromJson(json['kid_part1'])
        : null;
    kidPart1Alt = json['kid_part1_alt'] != null
        ? new AdultPart1.fromJson(json['kid_part1_alt'])
        : null;
    kidPart2 = json['kid_part2'] != null
        ? new AdultPart1.fromJson(json['kid_part2'])
        : null;
    kidPart2Alt = json['kid_part2_alt'] != null
        ? new AdultPart1.fromJson(json['kid_part2_alt'])
        : null;
    kidPart3 = json['kid_part3'] != null
        ? new AdultPart1.fromJson(json['kid_part3'])
        : null;
    kidPart3Alt = json['kid_part3_alt'] != null
        ? new AdultPart1.fromJson(json['kid_part3_alt'])
        : null;
    kidEpilogue = json['kid_epilogue'] != null
        ? new AdultPart1.fromJson(json['kid_epilogue'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kidPart1 != null) {
      data['kid_part1'] = this.kidPart1!.toJson();
    }
    if (this.kidPart1Alt != null) {
      data['kid_part1_alt'] = this.kidPart1Alt!.toJson();
    }
    if (this.kidPart2 != null) {
      data['kid_part2'] = this.kidPart2!.toJson();
    }
    if (this.kidPart2Alt != null) {
      data['kid_part2_alt'] = this.kidPart2Alt!.toJson();
    }
    if (this.kidPart3 != null) {
      data['kid_part3'] = this.kidPart3!.toJson();
    }
    if (this.kidPart3Alt != null) {
      data['kid_part3_alt'] = this.kidPart3Alt!.toJson();
    }
    if (this.kidEpilogue != null) {
      data['kid_epilogue'] = this.kidEpilogue!.toJson();
    }
    return data;
  }
}

