// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/app_locale/app_localization.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  String id;

  String imageUrl;
  int duration;

  MealItem({
    required this.id,
    required this.imageUrl,
    required this.duration,
  });

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      //if(result != null) removeItem(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: id,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      getLang(context, "meal-$id")!.toString(),
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${getLang(context, "duration-$id")}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${getLang(context, "complexity-$id")}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "${getLang(context, "affordability-$id")}",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
