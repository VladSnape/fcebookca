import 'package:facebookc/features/main/view/widgets/mycontainer.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteWidget extends StatelessWidget {
  final void Function()? onTap;
  const ConfirmDeleteWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 50,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  child: Text(
                    "potential friend",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyContainer(
                      text: 'Confirm',
                      borderRadius: 10,
                      color: Colors.blue,
                      width: 100,
                      isWhite: true,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MyContainer(
                      text: 'Delete',
                      borderRadius: 10,
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 100,
                      isWhite: false,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
