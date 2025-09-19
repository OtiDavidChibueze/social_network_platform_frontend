import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:social_network_platform/features/meet/presentation/pages/meet_page.dart';
import '../../../meet/domain/entities/meet_entity.dart';
import 'circle_user_avatar_widget.dart';

class LastMeetsWidget extends StatelessWidget {
  final MeetEntity meet;

  const LastMeetsWidget({super.key, required this.meet});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(MeetPage.route(meet.id));
      },

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              meet.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 6),

            Text(
              '${meet.date.hour}:${meet.date.minute}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontSize: 16),
            ),

            Spacer(),

            ...meet.attendees.map(
              (attendee) => Padding(
                padding: EdgeInsets.only(left: 4),
                child: CircleUserAvatarWidget(
                  width: 30,
                  height: 30,
                  url: attendee.avatar,
                ),
              ),
            ),

            SizedBox(width: 15),

            Text(DateFormat.yMMMd().format(meet.date).toString()),
          ],
        ),
      ),
    );
  }
}
