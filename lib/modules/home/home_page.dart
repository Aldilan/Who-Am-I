import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:who_am_i/modules/history/widgets/history_card.dart';
import 'package:who_am_i/modules/home/controller/home_controller.dart';
import 'package:who_am_i/modules/home/widgets/clippath_widget.dart';
import 'package:who_am_i/modules/home/widgets/non_user_card_widget.dart';
import 'package:who_am_i/modules/home/widgets/profile_card_widget.dart';
import 'package:who_am_i/modules/home/widgets/status_card_widget.dart';
import 'package:who_am_i/modules/home/widgets/user_card_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController c = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              items: c.dropdownItems,
              onChanged: (value) {
                c.dropdownRespond(value, context);
              },
              customButton: const Icon(
                Icons.list,
                size: 46,
                color: Colors.white,
              ),
              dropdownStyleData: DropdownStyleData(
                width: 160,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.deepPurple,
                ),
                offset: const Offset(0, 8),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
        toolbarHeight: 80,
        backgroundColor: Colors.purple[800],
        title: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Obx(
              () => Expanded(
                child: Text(
                  c.myData.isEmpty ? 'Hallo' : "Hallo, ${c.myData[0]['name']}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          c.loadData();
        },
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  child: ClipPath(
                    clipper: ClipPathClass(),
                    child: Container(
                      color: Colors.purple[800], // Set the desired color
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                    ),
                  ),
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      c.myData.isEmpty
                          ? NonUserCard()
                          : ProfileCard(
                              myData: c.myData,
                            ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Color.fromARGB(255, 239, 239, 239),
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Other User',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 129,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: c.usersData.length,
                        itemBuilder: (context, index) {
                          return UserCard(userData: c.usersData[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 129,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: c.statusData.length,
                        itemBuilder: (context, index) {
                          return StatusCard(statusData: c.statusData[index]);
                        },
                      ),
                    ),
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
