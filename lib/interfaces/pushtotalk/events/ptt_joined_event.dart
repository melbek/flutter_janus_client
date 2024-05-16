part of janus_client;

class PTTJoinedEvent extends PTTEvent {
  PTTJoinedEvent({
    pushtotalk,
    room,
    this.id,
    this.display,
    this.participants,
  }) {
    super.pushtotalk = pushtotalk;
    super.room = room;
  }

  PTTJoinedEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
    id = json['custom_id'];
    display = json['display'];
    if (json['participants'] != null) {
      participants = [];
      json['participants'].forEach((v) {
        participants?.add(PTTParticipants.fromJson(v));
      });
    }
  }
  dynamic id;
  String? display;
  List<PTTParticipants>? participants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushtotalk'] = pushtotalk;
    map['room'] = room;
    map['custom_id'] = id;
    map['display'] = display;
    if (participants != null) {
      map['participants'] = participants?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class PTTParticipants {
  dynamic id;
  String? customId;
  String? display;
  String? firstName;
  String? lastName;
  String? image;
  String? userType;
  bool? setup;
  bool? muted;
  bool? isBanned;
  bool? talking;
  int? spatialPosition;

  PTTParticipants({
    this.id,
    this.customId,
    this.display,
    this.firstName,
    this.lastName,
    this.image,
    this.userType,
    this.setup = false,
    this.muted = false,
    this.isBanned = false,
    this.talking = false,
    this.spatialPosition,
  });

  PTTParticipants.fromJson(dynamic json) {
    id = json['id'];
    customId = json['custom_id'];
    display = json['display'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    userType = json['user_type'];
    setup = json['setup'] != null ? json['setup'] : setup;
    muted = json['muted'] != null ? json['muted'] : muted;
    isBanned = json['is_banned'] != null ? json['is_banned'] : isBanned;
    talking = json['talking'] != null ? json['talking'] : talking;
    spatialPosition = json['spatial_position'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['custom_id'] = id;
    map['display'] = display;
    map['setup'] = setup;
    map['muted'] = muted;
    map['talking'] = talking;
    map['spatial_position'] = spatialPosition;
    return map;
  }

  PTTParticipants copyWith({
    int? id,
    String? display,
    bool? setup,
    bool? muted,
    bool? talking,
    int? spatialPosition,
  }) {
    return PTTParticipants(
      id: id ?? this.id,
      display: display ?? this.display,
      setup: setup ?? this.setup,
      muted: muted ?? this.muted,
      talking: talking ?? this.talking,
      spatialPosition: spatialPosition ?? this.spatialPosition,
    );
  }
}

class PTTNewParticipantsEvent extends PTTEvent {
  List<PTTParticipants>? participants;
  PTTNewParticipantsEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
    if (json['participants'] != null) {
      participants = [];
      json['participants'].forEach((v) {
        participants?.add(PTTParticipants.fromJson(v));
      });
    }
  }
}
