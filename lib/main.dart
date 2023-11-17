import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() {
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
