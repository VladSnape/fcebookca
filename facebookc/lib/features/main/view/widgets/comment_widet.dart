import 'package:facebookc/features/main/view/pages/hidden/profile_page.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final String userName;
  final String commentText;
  final String? avatar;
  final String userId;
  const CommentWidget({
    super.key,
    required this.userName,
    required this.commentText,
    this.avatar,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePgae(
                userId: userId,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).secondaryHeaderColor),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          commentText,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
