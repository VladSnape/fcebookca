import 'package:facebookc/features/main/view/widgets/mycontainer.dart';
import 'package:facebookc/features/main/view/widgets/myicon_widget.dart';
import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

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
                  "Marketplace",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyContainer(
                  text: 'sell',
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: 20,
                  width: 140,
                  isWhite: false,
                ),
                const SizedBox(
                  width: 10,
                ),
                MyContainer(
                  text: 'Categories',
                  color: Theme.of(context).secondaryHeaderColor,
                  borderRadius: 20,
                  width: 140,
                  isWhite: false,
                ),
              ],
            ),
            listHeader(context),
            allProducts()
          ],
        ),
      ),
    ));
  }
}

Row listHeader(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        ' Todays picks',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      TextButton(
          onPressed: () {},
          child: const Text(
            'location',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                color: Color.fromARGB(255, 0, 140, 255),
                fontSize: 20),
          )),
    ],
  );
}

SizedBox allProducts() {
  return SizedBox(
    height: 600,
    child: GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '90 da  ',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'macBook ',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                ],
              ),
            ));
      },
    ),
  );
}
