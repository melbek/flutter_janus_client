part of janus_client;

class PTTTalkingEvent extends PTTEvent {
  dynamic userId;
  bool? isTalking;
  PTTTalkingEvent({pushtotalk, room, this.userId, this.isTalking}) {
    super.pushtotalk = pushtotalk;
    super.room = room;
  }

  PTTTalkingEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
    userId = json['custom_id'];
    isTalking = json['pushtotalk'] == 'talking' || json['pushtotalk'] == 'talker'
        ? true
        : json['pushtotalk'] == 'stopped-talking'
            ? false
            : false;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['audiobridge'] = pushtotalk;
    map['room'] = room;
    map['custom_id'] = userId;
    map['isTalking'] = isTalking;
    return map;
  }
}
