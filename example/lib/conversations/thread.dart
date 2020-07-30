import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';

import '../conversation/conversation.dart';
import 'avatar.dart';
import 'badge.dart';

class Thread extends StatelessWidget {
  Thread(SmsThread thread, UserProfile userProfile)
      : thread = thread,
        userProfile = userProfile,
        super(key: new ObjectKey(thread));

  final SmsThread thread;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      dense: true,
      leading: new Avatar(thread.contact.thumbnail, 'K'),
      title: new Text(thread.contact.address),
      subtitle: new Text(
        thread.messages.first.body.trim(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: new Badge(thread.messages),
      onTap: () => _showConversation(context),
    );
  }

  void _showConversation(BuildContext context) {}
}
