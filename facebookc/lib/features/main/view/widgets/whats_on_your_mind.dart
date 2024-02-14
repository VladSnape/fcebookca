import 'package:flutter/material.dart';

class WhatsOnYourMindWidget extends StatelessWidget {
  final String? avatar;
  final void Function()? onPressed;
  const WhatsOnYourMindWidget({
    super.key,
    this.onPressed,
    this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).primaryColor,
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              radius: 20,
              child: ClipOval(
                child: avatar != null
                    ? Image.network(
                        avatar!,
                        fit: BoxFit
                            .cover, // Ensure the image covers the entire CircleAvatar
                        width: 40, // Adjust width as needed
                        height: 40, // Adjust height as needed
                      )
                    : null, // Set child to null if avatarImage is null
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: onPressed,
                child: Text(
                  "What's on your mind",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
          IconButton(onPressed: onPressed, icon: const Icon(Icons.photo))
        ],
      ),
    );
  }
}
