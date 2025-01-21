import 'package:codevidhi_firechat/core/theme/colors/color_scheme_ext.dart';
import 'package:codevidhi_firechat/features/chats/domain/entities/chats_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:codevidhi_firechat/core/widgets/custom_image_view.dart';

class ChatItem extends StatelessWidget {
  final ChatsEntity chatEntity;

  const ChatItem({super.key, required this.chatEntity});

  @override
  Widget build(BuildContext context) {
    final formattedTimestamp =
        DateFormat('hh:mm a').format(chatEntity.timestamp);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        children: [
          // Profile Picture
          ClipRRect(
            borderRadius: BorderRadius.circular(28.r),
            child: CustomImageView(
              imagePath: chatEntity.profileImageUrl,
              height: 56.r,
              width: 56.r,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 12.w),
          // User details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Name
                Text(
                  chatEntity.userName,
                  style: chatEntity.isUnread
                      ? Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)
                      : Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 4.h),
                // Last Message
                Text(
                  chatEntity.lastMessage,
                  style: chatEntity.isUnread
                      ? Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)
                      : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              context.colorScheme.onSurface.withOpacity(0.6)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          // Timestamp and Unread Indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Timestamp
              Text(
                formattedTimestamp,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 8.h),
              // Unread Indicator
              if (chatEntity.isUnread)
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

extension ColorOpacity on Color {
  Color withOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0,
        'Opacity must be between 0.0 and 1.0');
    return this.withAlpha((opacity * 255).toInt());
  }
}
