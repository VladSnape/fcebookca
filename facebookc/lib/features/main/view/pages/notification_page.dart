import 'package:facebookc/features/main/view/widgets/myicon_widget.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const MyIconButton(
                  icon: Icons.search_outlined,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                ' Nothing to show here',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
