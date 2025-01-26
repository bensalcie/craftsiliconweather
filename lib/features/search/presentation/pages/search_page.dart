import 'package:craftsiliconweather/core/common/constants/app_strings.dart';
import 'package:craftsiliconweather/core/common/constants/dimens.dart';
import 'package:craftsiliconweather/core/common/presentation/widgets/app_textview_medium.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: true,
          title: SizedBox(
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: app_padding,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 34,
                      width: 34,
                    ),
                    const SizedBox(
                      width: app_padding,
                    ),
                    const AppTextViewMedium(
                      text: app_title,
                      padding: 4,
                      fontSize: 20,
                      weight: FontWeight.w800,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(size: 24),
          titleSpacing: 20,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Section
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  // Background Gradient
                  Ink(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF645AFF),
                          Color(0xFF8A77FF),
                        ],
                      ),
                    ),
                  ),
                  // Main Weather Info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Pasuruan",
                        // style: GoogleFonts.poppins(
                        //   color: Colors.white,
                        //   fontSize: 24,
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "17:45 PM",
                        // style: GoogleFonts.poppins(
                        //   color: Colors.white70,
                        //   fontSize: 16,
                        // ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 60,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "23°",
                              // style: GoogleFonts.poppins(
                              //   color: Colors.white,
                              //   fontSize: 50,
                              //   fontWeight: FontWeight.bold,
                              // ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Moon Cloud Fast Wind",
                              // style: GoogleFonts.poppins(
                              //   color: Colors.white70,
                              //   fontSize: 16,
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom Section
            Expanded(
              flex: 3,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Today's Weather
                    Text(
                      "Today",
                      // style: GoogleFonts.poppins(
                      //   fontSize: 18,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        WeatherTimeCard(
                            time: "06:00 AM", temp: "24°", icon: Icons.cloud),
                        WeatherTimeCard(
                            time: "08:00 AM",
                            temp: "26°",
                            icon: Icons.wb_sunny),
                        WeatherTimeCard(
                            time: "10:00 AM",
                            temp: "23°",
                            icon: Icons.umbrella),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Future Weather
                    Text(
                      "Next 7 Days",
                      // style: GoogleFonts.poppins(
                      //   fontSize: 18,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          WeatherFutureCard(
                              day: "Monday", temp: "29°", icon: Icons.wb_sunny),
                          WeatherFutureCard(
                              day: "Tuesday", temp: "22°", icon: Icons.cloud),
                          WeatherFutureCard(
                              day: "Wednesday",
                              temp: "19°",
                              icon: Icons.umbrella),
                          WeatherFutureCard(
                              day: "Thursday",
                              temp: "28°",
                              icon: Icons.wb_sunny),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class WeatherTimeCard extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;

  const WeatherTimeCard({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 10),
        Text(
          time,
          // style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Text(
          temp,
          // style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class WeatherFutureCard extends StatelessWidget {
  final String day;
  final String temp;
  final IconData icon;

  const WeatherFutureCard({
    super.key,
    required this.day,
    required this.temp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            // style: GoogleFonts.poppins(fontSize: 16),
          ),
          Row(
            children: [
              Icon(icon, size: 25, color: Colors.blue),
              const SizedBox(width: 10),
              Text(
                temp,
                // style: GoogleFonts.poppins(
                //   fontSize: 16,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
