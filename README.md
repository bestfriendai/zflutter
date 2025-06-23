# Shortzz 2.0

# Date: 20 June 2025

## Summary

- fixed horizontal reel issue
- Fixed "App last used at" not updating for users
- Added Branch key in const_res.dart
- Fixed "Access Denied" error for some images (wrong URL)
- fixed Reel issue
- link preview UI change
- Added loader to music sheet & Follow button & block button
- Fixed reply comment not sending
- Set `setLooping(true)` for livestream demo video player
- Fixed notification: tapping it should go to the post, and tapping a photo should go to the user
  profile
- Fixed removed stories older than 24 hours
- fixed the issue where notifications were not being sent in the localized language.

#### Updated Files

- [activity_notification_page.dart](lib/screen/notification_screen/widget/activity_notification_page.dart)
- [api_service.dart](lib/common/service/api/api_service.dart)
- [auth_screen_controller.dart](lib/screen/auth_screen/auth_screen_controller.dart)
- [block_user_controller.dart](lib/screen/blocked_user_screen/block_user_controller.dart)
- [blocked_user_screen.dart](lib/screen/blocked_user_screen/blocked_user_screen.dart)
- [camera_edit_screen_controller.dart](lib/screen/camera_edit_screen/camera_edit_screen_controller.dart)
- [camera_screen_controller.dart](lib/screen/camera_screen/camera_screen_controller.dart)
- [chat_screen_controller.dart](lib/screen/chat_screen/chat_screen_controller.dart)
- [chat_story_reply_message.dart](lib/screen/chat_screen/message_type_widget/chat_story_reply_message.dart)
- [chat_thread.dart](lib/model/chat/chat_thread.dart)
- [comment_card.dart](lib/screen/comment_sheet/widget/comment_card.dart)
- [comment_helper.dart](lib/screen/comment_sheet/helper/comment_helper.dart)
- [comment_sheet_controller.dart](lib/screen/comment_sheet/comment_sheet_controller.dart)
- [const_res.dart](lib/utilities/const_res.dart)
- [create_feed_screen_controller.dart](lib/screen/create_feed_screen/create_feed_screen_controller.dart)
- [dashboard_screen.dart](lib/screen/dashboard_screen/dashboard_screen.dart)
- [dashboard_screen_controller.dart](lib/screen/dashboard_screen/dashboard_screen_controller.dart)
- [firebase_firestore_controller.dart](lib/common/controller/firebase_firestore_controller.dart)
- [firebase_notification_manager.dart](lib/common/manager/firebase_notification_manager.dart)
- [follow_controller.dart](lib/common/controller/follow_controller.dart)
- [follow_following_screen.dart](lib/screen/follow_following_screen/follow_following_screen.dart)
- [follow_following_screen_controller.dart](lib/screen/follow_following_screen/follow_following_screen_controller.dart)
- [home_screen_controller.dart](lib/screen/home_screen/home_screen_controller.dart)
- [Info.plist](ios/Runner/Info.plist)
- [live_stream_search_screen_controller.dart](lib/screen/live_stream/live_stream_search_screen/live_stream_search_screen_controller.dart)
- [live_video_player.dart](lib/screen/live_stream/livestream_screen/view/live_video_player.dart)
- [livestream_comment_view.dart](lib/screen/live_stream/livestream_screen/view/livestream_comment_view.dart)
- [livestream_screen_controller.dart](lib/screen/live_stream/livestream_screen/livestream_screen_controller.dart)
- [main.dart](lib/main.dart)
- [members_sheet.dart](lib/screen/live_stream/livestream_screen/widget/members_sheet.dart)
- [message_screen.dart](lib/screen/message_screen/message_screen.dart)
- [music_sheet.dart](lib/screen/music_sheet/music_sheet.dart)
- [notification_screen.dart](lib/screen/notification_screen/notification_screen.dart)
- [notification_screen_controller.dart](lib/screen/notification_screen/notification_screen_controller.dart)
- [Podfile.lock](ios/Podfile.lock)
- [post_screen_controller.dart](lib/screen/post_screen/post_screen_controller.dart)
- [post_view_center.dart](lib/screen/post_screen/widget/post_view_center.dart)
- [profile_screen_controller.dart](lib/screen/profile_screen/profile_screen_controller.dart)
- [profile_user_header.dart](lib/screen/profile_screen/widget/profile_user_header.dart)
- [pubspec.yaml](pubspec.yaml)
- [qr_code_screen.dart](lib/screen/qr_code_screen/qr_code_screen.dart)
- [qr_code_screen_controller.dart](lib/screen/qr_code_screen/qr_code_screen_controller.dart)
- [reel_page.dart](lib/screen/reels_screen/reel/reel_page.dart)
- [reel_page_controller.dart](lib/screen/reels_screen/reel/reel_page_controller.dart)
- [reel_seek_bar.dart](lib/screen/reels_screen/reel/widget/reel_seek_bar.dart)
- [reels_screen.dart](lib/screen/reels_screen/reels_screen.dart)
- [reels_screen_controller.dart](lib/screen/reels_screen/reels_screen_controller.dart)
- [scan_qr_code_screen.dart](lib/screen/scan_qr_code_screen/scan_qr_code_screen.dart)
- [selected_music_sheet_controller.dart](lib/screen/selected_music_sheet/selected_music_sheet_controller.dart)
- [send_gift_sheet_controller.dart](lib/screen/gift_sheet/send_gift_sheet_controller.dart)
- [session_manager.dart](lib/common/manager/session_manager.dart)
- [settings_screen_controller.dart](lib/screen/settings_screen/settings_screen_controller.dart)
- [splash_screen_controller.dart](lib/screen/splash_screen/splash_screen_controller.dart)
- [text_button_custom.dart](lib/common/widget/text_button_custom.dart)
- [url_meta_data_card.dart](lib/screen/create_feed_screen/widget/url_meta_data_card.dart)
- [user_information.dart](lib/screen/reels_screen/reel/widget/user_information.dart)
- [user_service.dart](lib/common/service/api/user_service.dart)
- [web_service.dart](lib/common/service/utils/web_service.dart)
- README.md

#### Added Files

- network_helper.dart
- url_card.dart
- video_cache_helper.dart

----------------------------------------------------------------------------------------------------

# Date: 17 June 2025

## Summary

- 🐞 Bug fixes and performance improvements.

#### Updated Files

- [ads_controller.dart](lib/common/controller/ads_controller.dart)
- [asset_res.dart](lib/utilities/asset_res.dart)
- [comment_bottom_text_field_view.dart](lib/screen/comment_sheet/widget/comment_bottom_text_field_view.dart)
- [comment_card.dart](lib/screen/comment_sheet/widget/comment_card.dart)
- [custom_drop_down.dart](lib/common/widget/custom_drop_down.dart)
- [explore_screen.dart](lib/screen/explore_screen/explore_screen.dart)
- [firebase_notification_manager.dart](lib/common/manager/firebase_notification_manager.dart)
- [gif_sheet.dart](lib/screen/gif_sheet/gif_sheet.dart)
- [home_screen.dart](lib/screen/home_screen/home_screen.dart)
- [home_screen_controller.dart](lib/screen/home_screen/home_screen_controller.dart))
- [languages_keys.dart](lib/languages/languages_keys.dart)
- [live_stream_search_screen_controller.dart](lib/screen/live_stream/live_stream_search_screen/live_stream_search_screen_controller.dart)
- [livestream_comment.dart](lib/model/livestream/livestream_comment.dart)
- [livestream_screen_controller.dart](lib/screen/live_stream/livestream_screen/livestream_screen_controller.dart)
- [main.dart](lib/main.dart))
- [more_user_sheet.dart](lib/screen/share_sheet_widget/widget/more_user_sheet.dart)
- [post_view_center.dart](lib/screen/post_screen/widget/post_view_center.dart)
- [profile_screen.dart](lib/screen/profile_screen/profile_screen.dart)
- [qr_code_screen.dart](lib/screen/qr_code_screen/qr_code_screen.dart)
- [reels_screen_controller.dart](lib/screen/reels_screen/reels_screen_controller.dart)
- [report_sheet.dart](lib/screen/report_sheet/report_sheet.dart)
- [report_sheet_controller.dart](lib/screen/report_sheet/report_sheet_controller.dart)
- [request_withdrawal_screen.dart](lib/screen/request_withdrawal_screen/request_withdrawal_screen.dart)
- [settings_screen.dart](lib/screen/settings_screen/settings_screen.dart)
- [share_sheet_widget.dart](lib/screen/share_sheet_widget/share_sheet_widget.dart)
- [system_notification_page.dart](lib/screen/notification_screen/widget/system_notification_page.dart)
- [user_information.dart](lib/screen/reels_screen/reel/widget/user_information.dart)
- [video_player_screen.dart](lib/screen/video_player_screen/video_player_screen.dart)

#### Added Files
- none

#### Deleted Files

- none

----------------------------------------------------------------------------------------------------

# Date: 16 June 2025

## Summary

- New Project

#### Updated Files

- none

#### Added Files

- none

#### Deleted Files

- none
