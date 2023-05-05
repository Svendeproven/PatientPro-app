import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Hologram model
class Hologram {
  String title;
  String filepath;
  IconData? icon;
  SvgPicture? image;

  /// Constructor for creating a new hologram
  Hologram({
    required this.title,
    required this.filepath,
    this.icon,
    this.image,
  });

  /// Converts a json object to a Hologram object
  factory Hologram.fromJson(Map<String, dynamic> json) {
    return Hologram(
      title: json['title'],
      filepath: json['filepath'],
      icon: json['icon'],
      image: json['image'],
    );
  }

  /// Converts a Hologram object to a json object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'filepath': filepath,
      'icon': icon,
      'image': image,
    };
  }
}
