import 'package:domain/models/tag.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_button/custom_button.dart';
import 'package:presentation/components/horizontal_divider/horizontal_divider.dart';

class TagComponent extends StatelessWidget {
  final Function? callback;
  final Tag tag;
  const TagComponent({super.key, required this.tag, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ThemeStyles.mainColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 5,
            child: CustomButton(
              callback: () => callback != null ? callback!.call() : () {},
              widget: Icon(
                tag.isLocked ? Icons.lock : Icons.lock_open_rounded,
                color: ThemeStyles.secondAccent,
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_pin,
                      color: ThemeStyles.secondAccent,
                    ),
                    Text(
                      tag.name.split(":").last,
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.secondAccent,
                        size: 15,
                        weight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: ThemeStyles.secondAccent,
                    ),
                    Text(
                      tag.number.split(":").last,
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.secondAccent,
                        size: 15,
                        weight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      color: ThemeStyles.secondAccent,
                    ),
                    Text(
                      tag.address.split(":").last,
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.secondAccent,
                        size: 15,
                        weight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              if (tag.note != null)
                Container(
                  padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.note,
                        color: ThemeStyles.secondAccent,
                      ),
                      Flexible(
                        child: Text(
                          tag.note!.split(":").last,
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.secondAccent,
                            size: 15,
                            weight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              HorizontalDivider(),
              Container(
                padding: EdgeInsets.fromLTRB(40, 8, 40, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.pets,
                      color: ThemeStyles.secondAccent,
                    ),
                    Text(
                      tag.petName.split(":").last,
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.secondAccent,
                        size: 15,
                        weight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
