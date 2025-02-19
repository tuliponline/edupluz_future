// To parse this JSON data, do
//
//     final metricModel = metricModelFromJson(jsonString);

import 'dart:convert';

MetricModel metricModelFromJson(String str) =>
    MetricModel.fromJson(json.decode(str));

String metricModelToJson(MetricModel data) => json.encode(data.toJson());

class MetricModel {
  String event;
  Metric metric;

  MetricModel({
    required this.event,
    required this.metric,
  });

  factory MetricModel.fromJson(Map<String, dynamic> json) => MetricModel(
        event: json["event"],
        metric: Metric.fromJson(json["metric"]),
      );

  Map<String, dynamic> toJson() => {
        "event": event,
        "metric": metric.toJson(),
      };
}

class Metric {
  String sessionId;
  String eventType;
  String userId;
  String deviceId;
  String ipAddress;
  String city;
  String country;
  String contentId;
  String contentTitle;
  String streamType;
  String streamingFormat;
  String qualityResolution;
  int encodedBitrate;
  double bufferLength;
  double duration;
  int volume;
  bool muted;
  int playbackRate;
  double playbackPercentage;
  double playbackCurrentTime;
  double measuredThroughput;
  int topBitrate;
  String deviceModel;
  String deviceBrand;
  String browser;
  String browserVersion;
  String operatingSystem;
  String operatingSystemVersion;
  ExtraParams extraParams;

  Metric({
    required this.sessionId,
    required this.eventType,
    required this.userId,
    required this.deviceId,
    required this.ipAddress,
    required this.city,
    required this.country,
    required this.contentId,
    required this.contentTitle,
    required this.streamType,
    required this.streamingFormat,
    required this.qualityResolution,
    required this.encodedBitrate,
    required this.bufferLength,
    required this.duration,
    required this.volume,
    required this.muted,
    required this.playbackRate,
    required this.playbackPercentage,
    required this.playbackCurrentTime,
    required this.measuredThroughput,
    required this.topBitrate,
    required this.deviceModel,
    required this.deviceBrand,
    required this.browser,
    required this.browserVersion,
    required this.operatingSystem,
    required this.operatingSystemVersion,
    required this.extraParams,
  });

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        sessionId: json["session_id"],
        eventType: json["event_type"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        ipAddress: json["ip_address"],
        city: json["city"],
        country: json["country"],
        contentId: json["content_id"],
        contentTitle: json["content_title"],
        streamType: json["stream_type"],
        streamingFormat: json["streaming_format"],
        qualityResolution: json["quality_resolution"],
        encodedBitrate: json["encoded_bitrate"],
        bufferLength: json["buffer_length"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        volume: json["volume"],
        muted: json["muted"],
        playbackRate: json["playback_rate"],
        playbackPercentage: json["playback_percentage"]?.toDouble(),
        playbackCurrentTime: json["playback_current_time"]?.toDouble(),
        measuredThroughput: json["measured_throughput"]?.toDouble(),
        topBitrate: json["top_bitrate"],
        deviceModel: json["device_model"],
        deviceBrand: json["device_brand"],
        browser: json["browser"],
        browserVersion: json["browser_version"],
        operatingSystem: json["operating_system"],
        operatingSystemVersion: json["operating_system_version"],
        extraParams: ExtraParams.fromJson(json["extra_params"]),
      );

  Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "event_type": eventType,
        "user_id": userId,
        "device_id": deviceId,
        "ip_address": ipAddress,
        "city": city,
        "country": country,
        "content_id": contentId,
        "content_title": contentTitle,
        "stream_type": streamType,
        "streaming_format": streamingFormat,
        "quality_resolution": qualityResolution,
        "encoded_bitrate": encodedBitrate,
        "buffer_length": bufferLength,
        "duration": duration,
        "volume": volume,
        "muted": muted,
        "playback_rate": playbackRate,
        "playback_percentage": playbackPercentage,
        "playback_current_time": playbackCurrentTime,
        "measured_throughput": measuredThroughput,
        "top_bitrate": topBitrate,
        "device_model": deviceModel,
        "device_brand": deviceBrand,
        "browser": browser,
        "browser_version": browserVersion,
        "operating_system": operatingSystem,
        "operating_system_version": operatingSystemVersion,
        "extra_params": extraParams.toJson(),
      };
}

class ExtraParams {
  String chapterId;
  String courseId;
  String lessonId;

  ExtraParams({
    required this.chapterId,
    required this.courseId,
    required this.lessonId,
  });

  factory ExtraParams.fromJson(Map<String, dynamic> json) => ExtraParams(
        chapterId: json["chapter_id"],
        courseId: json["course_id"],
        lessonId: json["lesson_id"],
      );

  Map<String, dynamic> toJson() => {
        "chapter_id": chapterId,
        "course_id": courseId,
        "lesson_id": lessonId,
      };
}
