import 'package:flutter/material.dart';

class ProfileInSeeAllProfilePage extends StatelessWidget {
  final String? avatar;
  final String? userName;
  final void Function()? onTap;
  const ProfileInSeeAllProfilePage({
    super.key,
    this.onTap,
    this.avatar,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 2.0,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                radius: 30,
                child: ClipOval(
                  child: avatar != null
                      ? Image.network(
                          avatar!,
                          fit: BoxFit
                              .cover, // Ensure the image covers the entire CircleAvatar
                          width: 60, // Adjust width as needed
                          height: 60, // Adjust height as needed
                        )
                      : null, // Set child to null if avatarImage is null
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Text(
                    userName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
