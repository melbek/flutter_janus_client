part of janus_client;

class PushToTalkPlugin extends JanusPlugin {
  StreamController<TypedEvent>? _typedMessagesStreamController;
  StreamSink? get _typedMessagesSink => _typedMessagesStreamController?.sink;
  
  PushToTalkPlugin({
    super.handleId,
    required super.context,
    required super.transport,
    required super.session,
  }) : super(plugin: 'janus.plugin.pushtotalk');

  /// you use a join request to join an audio room, and wait for the joined event; this event will also include a list of the other participants, if any;<br><br>
  ///[roomId] : numeric ID of the room to join<br>
  ///[id] : unique ID to assign to the participant; optional, assigned by the plugin if missing<br>
  ///[group] : "group to assign to this participant (for forwarding purposes only; optional, mandatory if enabled in the room)<br>
  ///[pin] : "password required to join the room, if any; optional<br>
  ///[display] : "display name to have in the room; optional<br>
  ///[token] : "invitation token, in case the room has an ACL; optional<br>
  ///[muted] : true|false, whether to start unmuted or muted<br>
  ///[codec] : "codec to use, among opus (default), pcma (A-Law) or pcmu (mu-Law)<br>
  ///[preBuffer] : number of packets to buffer before decoding this participant (default=room value, or DEFAULT_PREBUFFERING)<br>
  ///[bitrate] : bitrate to use for the Opus stream in bps; optional, default=0 (libopus decides)<br>
  ///[quality] : 0-10, Opus-related complexity to use, the higher the value, the better the quality (but more CPU); optional, default is 4<br>
  ///[expectedLoss] : 0-20, a percentage of the expected loss (capped at 20%), only needed in case FEC is used; optional, default is 0 (FEC disabled even when negotiated) or the room default<br>
  ///[volume] : percent value, <100 reduces volume, >100 increases volume; optional, default is 100 (no volume change)<br>
  ///[spatialPosition] : in case spatial audio is enabled for the room, panning of this participant (0=left, 50=center, 100=right)<br>
  ///[secret] : "room management password; optional, if provided the user is an admin and can't be globally muted with mute_room<br>
  ///[audioLevelAverage] : "if provided, overrides the room audioLevelAverage for this user; optional<br>
  ///[audioActivePackets] : "if provided, overrides the room audioActivePackets for this user; optional<br>
  ///[record] : true|false, whether to record this user's contribution to a .mjr file (mixer not involved)<br>
  ///[filename] : "basename of the file to record to, -audio.mjr will be added by the plugin<br>
  ///
  Future<void> joinRoom(dynamic roomId,
      {//dynamic id,
      String? group,
      String? pin,
      int? expectedLoss,
      String? display,
      String? token,
      bool? muted,
      String? codec,
      int? preBuffer,
      int? quality,
      int? volume,
      int? spatialPosition,
      String? secret,
      String? audioLevelAverage,
      String? audioActivePackets,
      bool? record,
      Map<String, dynamic>? json,
      String? filename}) async {
    Map<String, dynamic> payload = {
      "request": "join",
      "room": roomId,
      //"id": id,
      "group": group,
      "pin": pin,
      "display": display,
      "token": token,
      "muted": muted,
      "codec": codec,
      "prebuffer": preBuffer,
      "expected_loss": expectedLoss,
      "quality": quality,
      "volume": volume,
      "spatial_position": spatialPosition,
      "secret": secret,
      "audio_level_average": audioLevelAverage,
      "audioActivePackets": audioActivePackets,
      "record": record,
      "filename": filename,


      "id": handleId,
      if (json != null)
      ...json,
    }..removeWhere((key, value) => value == null);
    //_handleRoomIdTypeDifference(payload);
    JanusEvent response = JanusEvent.fromJson(await send(data: payload));
    JanusError.throwErrorFromEvent(response);
  }

  /// [configure]
  ///
  /// muted instructs the plugin to mute or unmute the participant; quality changes the complexity of the Opus encoder for the participant; record can be used to record this participant's contribution to a Janus .mjr file, and filename to provide a basename for the path to save the file to (notice that this is different from the recording of a whole room: this feature only records the packets this user is sending, and is not related to the mixer stuff). A successful request will result in a ok event:<br><br>
  ///[muted] : true|false, whether to unmute or mute<br>
  ///[display] : new display name to have in the room"<br>
  ///[preBuffer] : new number of packets to buffer before decoding this participant (see "join" for more info)<br>
  ///[bitrate] : new bitrate to use for the Opus stream (see "join" for more info)<br>
  ///[quality] : new Opus-related complexity to use (see "join" for more info)<br>
  ///[expectedLoss] : new value for the expected loss (see "join" for more info)<br>
  ///[volume] : new volume percent value (see "join" for more info)<br>
  ///[spatialPosition] : in case spatial audio is enabled for the room, new panning of this participant (0=left, 50=center, 100=right)<br>
  ///[record] : true|false, whether to record this user's contribution to a .mjr file (mixer not involved)<br>
  ///[filename] : basename of the file to record to, -audio.mjr will be added by the plugin<br>
  ///[group] : new group to assign to this participant, if enabled in the room (for forwarding purposes)<br>
  ///[offer]: provide your own webrtc offer by default sends with audiosendrecv only
  Future<void> configure(
      {bool? muted,
      int? bitrate,
      String? display,
      int? preBuffer,
      int? quality,
      int? volume,
      int? spatialPosition,
      bool? record,
      String? filename,
      String? group,
      RTCSessionDescription? offer}) async {
    var payload = {
      "request": "configure",
      "muted": muted,
      "display": display,
      "bitrate": bitrate,
      "prebuffer": preBuffer,
      "quality": quality,
      "volume": volume,
      "spatial_position": spatialPosition,
      "record": record,
      "filename": filename,
      "group": group
    }..removeWhere((key, value) => value == null);
    offer ??= await createOffer(videoRecv: false, audioRecv: true);
    JanusEvent response = JanusEvent.fromJson(await send(data: payload, jsep: offer));
    JanusError.throwErrorFromEvent(response);
  }

  /// [listParticipants]
  ///
  /// To get a list of the participants in a specific room of [roomId]
  ///
  Future<List<PTTParticipants>> listParticipants(dynamic roomId) async {
    var payload = {
      "request": "listparticipants",
      "room": roomId,
    };
    //_handleRoomIdTypeDifference(payload);
    JanusEvent response = JanusEvent.fromJson(await send(data: payload));
    JanusError.throwErrorFromEvent(response);
    return (response.plugindata?.data['participants'] as List<dynamic>?)?.map((e) => PTTParticipants.fromJson(e)).toList() ?? [];
  }

  bool _onCreated = false;

  @override
  Future<void> hangup() async {
    await super.hangup();
    await send(data: {"request": "leave"});
  }

  @override
  void onCreate() {
    super.onCreate();
    if (_onCreated) {
      return;
    }
    _onCreated = true;

    //typed source and stream for plugin level events
    _typedMessagesStreamController = StreamController<TypedEvent<JanusEvent>>();
    typedMessages = _typedMessagesStreamController!.stream.asBroadcastStream() as Stream<TypedEvent<JanusEvent>>?;

    messages?.listen((event) {
      TypedEvent<JanusEvent> typedEvent = TypedEvent<JanusEvent>(event: JanusEvent.fromJson(event.event), jsep: event.jsep);
      var data = typedEvent.event.plugindata?.data;
      if (data == null) return;
      if (data["pushtotalk"] == "joined" || data["pushtotalk"] == "joining") {
        typedEvent.event.plugindata?.data = PTTJoinedEvent.fromJson(data);
        _typedMessagesSink?.add(typedEvent);
      } else if (data["pushtotalk"] == "status_changed") {
        typedEvent.event.plugindata?.data = PTTStatusChangedEvent.fromJson(data);
        _typedMessagesSink?.add(typedEvent);
      } else if (data["pushtotalk"] == "event") {
        if (data["participants"] != null) {
          typedEvent.event.plugindata?.data = PTTNewParticipantsEvent.fromJson(data);
          _typedMessagesSink?.add(typedEvent);
        } else if (data["configured"] != null || data["result"] == "ok") {
          typedEvent.event.plugindata?.data = PTTConfiguredEvent.fromJson(data);
          _typedMessagesSink?.add(typedEvent);
        } else if (data["leaving"] != null) {
          typedEvent.event.plugindata?.data = PTTLeavingEvent.fromJson(data);
          _typedMessagesSink?.add(typedEvent);
        } else if (data['error_code'] != null || data['result']?['code'] != null) {
          _typedMessagesSink?.addError(JanusError.fromMap(data));
        }
      } else if (data["pushtotalk"] == "talker") {
        typedEvent.event.plugindata?.data = PTTTalkingEvent.fromJson(data);
        _typedMessagesSink?.add(typedEvent);
      } else if (data["pushtotalk"] == "destroyed") {
        typedEvent.event.plugindata?.data = PTTDestroyedEvent.fromJson(data);
        _typedMessagesSink?.add(typedEvent);
      } else if (data['pushtotalk'] == 'event' && (data['error_code'] != null || data['result']?['code'] != null)) {
        _typedMessagesSink?.addError(JanusError.fromMap(data));
      }
    });
  }
}