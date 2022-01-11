// To parse this JSON data, do
//
//     final enableXModel = enableXModelFromJson(jsonString);

import 'dart:convert';

EnableXModel enableXModelFromJson(String str) =>
    EnableXModel.fromJson(json.decode(str));

String enableXModelToJson(EnableXModel data) => json.encode(data.toJson());

class EnableXModel {
  EnableXModel({
    this.result = 0,
    this.room,
  });

  int result;
  Room? room;

  factory EnableXModel.fromJson(Map<String, dynamic> json) => EnableXModel(
        result: json["result"],
        room: Room.fromJson(json["room"] ?? ''),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "room": room!.toJson(),
      };
}

class Room {
  Room({
    this.name = '',
    this.serviceId = '',
    this.ownerRef = '',
    this.settings,
    this.sip,
    this.created,
    this.roomId = '',
  });

  String name;
  String serviceId;
  String ownerRef;
  Settings? settings;
  Sip? sip;
  DateTime? created;
  String roomId;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        name: json["name"],
        serviceId: json["service_id"],
        ownerRef: json["owner_ref"],
        settings: Settings.fromJson(json["settings"]),
        sip: Sip.fromJson(json["sip"]),
        created: DateTime.parse(json["created"]),
        roomId: json["room_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "service_id": serviceId,
        "owner_ref": ownerRef,
        "settings": settings!.toJson(),
        "sip": sip!.toJson(),
        "created": created!.toIso8601String(),
        "room_id": roomId,
      };
}

class Settings {
  Settings({
    this.description = '',
    this.mode = '',
    this.scheduled = false,
    this.adhoc = false,
    this.duration = '',
    this.participants = '',
    this.autoRecording = false,
    this.screenShare = false,
    this.canvas = false,
    this.mediaConfiguration = '',
    this.quality = '',
    this.moderators = 0,
    this.activeTalker = false,
    this.maxActiveTalkers = 0,
    this.encryption = false,
    this.watermark = false,
    this.singleFileRecording = false,
    this.mediaZone = '',
  });

  String description;
  String mode;
  bool scheduled;
  bool adhoc;
  String duration;
  String participants;
  bool autoRecording;
  bool screenShare;
  bool canvas;
  String mediaConfiguration;
  String quality;
  int moderators;
  bool activeTalker;
  int maxActiveTalkers;
  bool encryption;
  bool watermark;
  bool singleFileRecording;
  String mediaZone;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        description: json["description"],
        mode: json["mode"],
        scheduled: json["scheduled"],
        adhoc: json["adhoc"],
        duration: json["duration"],
        participants: json["participants"],
        autoRecording: json["auto_recording"],
        screenShare: json["screen_share"],
        canvas: json["canvas"],
        mediaConfiguration: json["media_configuration"],
        quality: json["quality"],
        moderators: json["moderators"],
        activeTalker: json["active_talker"],
        maxActiveTalkers: json["max_active_talkers"],
        encryption: json["encryption"],
        watermark: json["watermark"],
        singleFileRecording: json["single_file_recording"],
        mediaZone: json["media_zone"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "mode": mode,
        "scheduled": scheduled,
        "adhoc": adhoc,
        "duration": duration,
        "participants": participants,
        "auto_recording": autoRecording,
        "screen_share": screenShare,
        "canvas": canvas,
        "media_configuration": mediaConfiguration,
        "quality": quality,
        "moderators": moderators,
        "active_talker": activeTalker,
        "max_active_talkers": maxActiveTalkers,
        "encryption": encryption,
        "watermark": watermark,
        "single_file_recording": singleFileRecording,
        "media_zone": mediaZone,
      };
}

class Sip {
  Sip({
    this.enabled = false,
  });

  bool enabled;

  factory Sip.fromJson(Map<String, dynamic> json) => Sip(
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "enabled": enabled,
      };
}
