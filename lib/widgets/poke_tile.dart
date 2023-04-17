import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/constants/colors.dart' as type_colors;
import 'package:pokedex/constants/background_colors.dart' as bg_colors;

class PokeTile extends StatelessWidget {
  final String name;
  final int id;
  final String image;
  final String type_1;
  final String? type_2;

  String _convertId(int id) {
    var idString = id.toString();

    if (idString.length == 1) return '#00$id';
    if (idString.length == 2) return '#0$id';

    return '#$id';
  }

  PokeTile(
      {required this.name,
      required this.id,
      required this.image,
      required this.type_1,
      this.type_2});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height: 150,
      decoration: BoxDecoration(
          color: bg_colors.colors[type_1],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      padding: EdgeInsets.all(20),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _convertId(id),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  StringUtils.capitalize(name),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: type_colors.colors[type_1],
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.leaderboard,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              type_1,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                    if (type_2 != null)
                      Container(
                          decoration: BoxDecoration(
                              color: type_colors.colors[type_2],
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(left: 10),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.leaderboard,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                type_2 ?? '',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ))
                  ],
                ),
              )
            ],
          ),
        ),
        Image.network(image),
      ]),
    );
  }
}
