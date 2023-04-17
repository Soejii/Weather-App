import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weathe_app/api/data_api.dart';
import 'package:weathe_app/model/CuacaModel.dart';
import 'package:weathe_app/model/DaerahModel.dart';
import 'package:weathe_app/widget/WeatherAndTimeCard.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool clickToday = true;
  bool clickTomorrow = false;
  bool isLoading = true;

  DateFormat? x = DateFormat.Hm();
  DateFormat? y = DateFormat.yMMMMEEEEd();

  String? firstDropDown;

  List<DaerahModel>? listDaerah;
  List<CuacaModel>? listCuaca;
  List<CuacaModel>? listCuacaToday;
  List<CuacaModel>? listCuacaTomorrow;

  List daerahList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    listDaerah = await ApiData.GetAllDaerah();
    firstDropDown = listDaerah![0].kota;
    for (var i = 0; i < listDaerah!.length; i++) {
      daerahList.add(listDaerah![i].kota);
    }
    listCuaca = await ApiData.GetCuacaDaerah(listDaerah![0].id);
    listCuacaToday = listCuaca?.sublist(0, 4);
    listCuacaTomorrow = listCuaca?.sublist(4, 8);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    DropdownButton(
                      value: firstDropDown,
                      items: daerahList
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) async {
                        String? id;

                        for (var i = 0; i < listDaerah!.length; i++) {
                          if (listDaerah![i].kota == value) {
                            id = listDaerah?[i].id ?? '0';
                          }
                        }

                        listCuaca = await ApiData.GetCuacaDaerah(id);
                        listCuacaToday = listCuaca?.sublist(0, 4);
                        listCuacaTomorrow = listCuaca?.sublist(4, 8);

                        setState(() {
                          firstDropDown = value as String?;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      (listCuaca?[0].tempC ?? '') + '°',
                      style: GoogleFonts.poppins(
                          fontSize: 45, color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      y!.format(DateTime.parse(
                          listCuaca?[0].jamCuaca.toString() ?? '')),
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.black),
                    ),
                    Text(
                      listCuaca?[0].cuaca ?? '',
                      style: GoogleFonts.poppins(
                          fontSize: 24, color: Colors.black),
                    ),
                    Image.network(
                      'https://ibnux.github.io/BMKG-importer/icon/${listCuaca![0].kodeCuaca}.png',
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  clickToday = true;
                                  clickTomorrow = false;
                                });
                              },
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: clickToday == true
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: clickToday == true ? 1 : 0),
                                  ),
                                ),
                                duration: Duration(milliseconds: 300),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Today',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  clickToday = false;
                                  clickTomorrow = true;
                                });
                              },
                              child: AnimatedContainer(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: clickTomorrow == true
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: clickTomorrow == true ? 1 : 0),
                                  ),
                                ),
                                duration: Duration(milliseconds: 300),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Tomorrow',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: clickToday == true
                                ? listCuacaToday?.length
                                : listCuacaTomorrow?.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (clickToday == true) {
                                return WeatTimeCard(
                                    url:
                                        'https://ibnux.github.io/BMKG-importer/icon/${listCuacaToday![index].kodeCuaca}.png',
                                    time: x!.format(
                                      DateTime.parse(
                                          listCuacaToday?[index].jamCuaca ??
                                              ''),
                                    ),
                                    degrees:
                                        (listCuacaToday?[index].tempC ?? '') +
                                            '°');
                              } else {
                                return WeatTimeCard(
                                    url:
                                        'https://ibnux.github.io/BMKG-importer/icon/${listCuacaTomorrow![index].kodeCuaca}.png',
                                    time: x!.format(
                                      DateTime.parse(
                                          listCuacaTomorrow?[index].jamCuaca ??
                                              ''),
                                    ),
                                    degrees: (listCuacaTomorrow?[index].tempC ??
                                            '') +
                                        '°');
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
