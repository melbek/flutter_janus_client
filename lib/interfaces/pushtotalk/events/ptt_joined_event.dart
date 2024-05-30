part of janus_client;

class PTTJoinedEvent extends PTTEvent {
  PTTJoinedEvent({
    pushtotalk,
    room,
    this.id,
    this.display,
    this.timestamp,
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
    timestamp = json['mic_timestamp'];
    if (json['participants'] != null) {
      participants = [];
      json['participants'].forEach((v) {
        participants?.add(PTTParticipants.fromJson(v));
      });
    }
  }
  dynamic id;
  String? display;
  int? timestamp;
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
  int? customId;
  String? display;
  String? firstName;
  String? lastName;
  String? image;
  String? userType;
  bool? setup;
  bool muted;
  bool isBanned;
  bool? talking;
  bool status;
  int? spatialPosition;
  double? latitude;
  double? longitude;

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
    this.status = false,
    this.spatialPosition,
    this.latitude,
    this.longitude,
  });

  PTTParticipants.fromJson(dynamic json): 
    this.muted = true, this.status = false, this.isBanned = false {
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
    status = json['status'] != null ? json['status'] : status;
    spatialPosition = json['spatial_position'];
    if (json['latitude'] != null) {
      latitude = double.parse(json['latitude']);
    }
    if (json['longitude'] != null) {
      longitude = double.parse(json['longitude']);
    }
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
