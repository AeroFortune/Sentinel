import 'package:flutter/material.dart';

class EventsTemplate extends StatelessWidget {
  const EventsTemplate({
    super.key,
    required this.imageEvent,
    required this.titleEvent,
    required this.descEvent,
    required this.horaEvent,
    required this.color,
    this.onTap,
  });

  final String imageEvent;
  final String titleEvent;
  final String descEvent;
  final String horaEvent;
  final Color color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 185,
        height: 232,
        child: Card(
          margin: const EdgeInsets.all(5.0),
          color: color,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(imageEvent),
                    width: 100,
                    height: 100,
                  ),
                ),
                Text(
                  titleEvent,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Text(
                  descEvent,
                  style: TextStyle(fontSize: 13,),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Icons.access_time_outlined),
                      Text(
                        " ${horaEvent}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
