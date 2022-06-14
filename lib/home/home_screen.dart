import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/home/bloc/home_bloc.dart';
import 'package:practice/home/bloc/home_event.dart';
import 'package:practice/home/bloc/home_state.dart';
import 'package:practice/home/model/content_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();

  List<Content> groups = [];
  List<Content> teams = [];
  List<String> images = [
    "assets/csk.png",
    "assets/dc.png",
    "assets/kkr.png",
    "assets/lsg.jpeg",
    "assets/mi.jpeg",
    "assets/pk.jpeg",
    "assets/rcb.png",
    "assets/srh.png",
  ];
  List<String> amount = [
    "50.00",
    "25.00",
    "100.00",
    "55.15",
    "55.55",
    "85.41",
    "150.55",
    "115.00",
  ];

  @override
  void initState() {
    homeBloc.add(GetTeamEvent());
    homeBloc.add(GetGroupEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          title: const Text("Pick your own"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 0.5),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: MediaQuery.of(context).size.width * 0.20,
                    child: Container(
                      // padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 100),
                      decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))),
                      /* child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Team\nBreak",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500, wordSpacing: 0.5),
                          ),
                          RichText(
                            textAlign: TextAlign.right,
                            text: const TextSpan(children: [
                              TextSpan(text: "Team Amount\n", style: TextStyle(fontSize: 8, color: Colors.white)),
                              TextSpan(text: "\$ 204.00", style: TextStyle(fontSize: 20, color: Colors.white)),
                            ]),
                          )
                        ],
                      ),*/
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Team\nBreak",
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500, wordSpacing: 0.5),
                            ),
                            RichText(
                              textAlign: TextAlign.right,
                              text: const TextSpan(children: [
                                TextSpan(text: "Team Amount\n", style: TextStyle(fontSize: 8, color: Colors.white)),
                                TextSpan(text: "\$ 204.00", style: TextStyle(fontSize: 20, color: Colors.white)),
                              ]),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.30,
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is GetTeamState) {
                              teams = state.teams;
                            }

                            if (teams.isEmpty) {
                              return Container();
                            }

                            return ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    width: 10,
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: teams.length,
                                itemBuilder: (context, index) {
                                  final key = GlobalKey();
                                  return Container(
                                    width: MediaQuery.of(context).size.width * 0.25,
                                    padding: const EdgeInsets.all(8),
                                    key: key,
                                    margin: const EdgeInsets.all(3),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 2)]),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ImageWidget(
                                          size: MediaQuery.of(context).size.width * 0.12,
                                          asset: images[Random().nextInt(images.length)],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "Mumbai Indians",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: homeBloc,
              builder: (context, state) {
                if (state is GetGroupState) {
                  groups = state.groups;
                }

                if (groups.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: groups.length,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration:
                            const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            ImageWidget(
                              size: 60,
                              asset: images[Random().nextInt(images.length)],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                groups[index].name,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            const Text(
                              "＄",
                              style: TextStyle(color: Color(0xff001a50), fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3), border: Border.all(color: Colors.green, width: 1.5)),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                amount[Random().nextInt(amount.length)],
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  final double size;
  final String asset;

  const ImageWidget({Key? key, required this.size, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey, width: 0.5)),
      child: Image(
        image: AssetImage(asset),
        fit: BoxFit.contain,
      ),
    );
  }
}
