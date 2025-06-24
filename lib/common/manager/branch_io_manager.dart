import 'package:flutter/material.dart';
import 'package:shortzz/model/post_story/post_model.dart';
import 'package:shortzz/model/user_model/user_model.dart';

enum ShareBranchType { post, user, qr }

// Temporarily disabled Branch SDK for simulator testing
class BranchIoManager {
  BranchIoManager._();

  static final BranchIoManager instance = BranchIoManager._();

  // All methods temporarily disabled for simulator testing
  Future<CustomBranchResponse?> init({
    required ShareBranchType type,
    User? user,
    Post? post,
    VoidCallback? onShareSuccess,
  }) async {
    return null;
  }

  Future<CustomBranchResponse?> generateLink({
    required ShareBranchType type,
    User? user,
    Post? post,
  }) async {
    return null;
  }

  Future<void> shareContent({
    required ShareBranchType type,
    User? user,
    Post? post,
    VoidCallback? onShareSuccess,
  }) async {
    // Temporarily disabled
  }

  String getUserTitle({required String fullname, required String username}) {
    return '$fullname (@$username)';
  }
}

// Temporarily disabled classes
class CustomBranchResponse {
  final String link;
  final dynamic branchObject;
  final dynamic linkProperties;
  final BranchShareData shareData;

  CustomBranchResponse(
      this.link, this.branchObject, this.linkProperties, this.shareData);
}

class BranchShareData {
  final String title;
  final String imageUrl;
  final String metadataKey;
  final String metadataValue;
  final String deepLinkUrl;

  BranchShareData({
    required this.title,
    required this.imageUrl,
    required this.metadataKey,
    required this.metadataValue,
    required this.deepLinkUrl,
  });
}
