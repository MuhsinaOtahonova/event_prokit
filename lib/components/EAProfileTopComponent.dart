import 'package:event_prokit/screens/EASignInScreen.dart';
import 'package:event_prokit/utils/supabaseConnect.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:event_prokit/screens/EAConnectionScreen.dart';
import 'package:event_prokit/screens/EAIndexScreen.dart';
import 'package:event_prokit/screens/EARewardScreen.dart';
import 'package:event_prokit/utils/EAColors.dart';
import 'package:event_prokit/utils/EAImages.dart';
import 'package:event_prokit/utils/EAapp_widgets.dart';

class EAProfileTopComponent extends StatefulWidget {
  const EAProfileTopComponent({Key? key}) : super(key: key);

  @override
  _EAProfileTopComponentState createState() => _EAProfileTopComponentState();
}

class _EAProfileTopComponentState extends State<EAProfileTopComponent> {
  bool isExpand = false;
  String hashTag = "#art #festival #fashion #expo..#cultur #food&drink #sport #nightlife";
  String name = "m"; // Boş bir isim string'i
  String city = ""; // Boş bir şehir string'i

  @override
  void initState() {
    super.initState();
    // Kullanıcı bilgilerini çekme işlemini initState içinde yapalım
    fetchUserData();
  }

  // Kullanıcı bilgilerini çeken fonksiyon
  void fetchUserData() async {
    // Supabase'den kullanıcı detaylarını çek
    SupabaseService.fetchUserDetails().listen((event) {
      // Kullanıcı bilgisi geldiğinde setState ile state'i güncelle
      setState(() {
        // Eğer kullanıcı bilgisi varsa, isim ve şehir bilgisini güncelle
        if (currentUser.isNotEmpty) {
          name = currentUser[0] ?? ""; // Eğer isim bilgisi yoksa boş string ata
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Arka plan resmi
        commonCachedNetworkImage(event_ic_london, fit: BoxFit.cover, width: context.width(), height: 300),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16, left: 16, top: 200),
              padding: EdgeInsets.only(left: 16, right: 16),
              width: context.width(),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: context.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                boxShadow: defaultBoxShadow(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  16.height,
                  // İsim bilgisi
                  Text(name, style: boldTextStyle()),
                  4.height,
                  // Şehir bilgisi
                  Text(city, style: primaryTextStyle()),
                  8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: boxDecorationWithRoundedCorners(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: primaryColor1),
                              ),
                              child: Text("INBOX", style: primaryTextStyle(color: primaryColor1)),
                            ).onTap(() {
                              EAIndexScreen().launch(context);
                            }),
                            Positioned(
                              right: 5,
                              top: -5,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: primaryColor1),
                                child: Text('1', style: secondaryTextStyle(color: white)),
                              ),
                            )
                          ],
                        ),
                        height: 44,
                      ),
                      16.width,
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: boxDecorationWithRoundedCorners(
                          borderRadius: BorderRadius.circular(24),
                          backgroundColor: primaryColor1.withOpacity(0.8),
                        ),
                        child: Text("REWARDS - \$15", style: primaryTextStyle(color: white)),
                      ).onTap(() {
                        EARewardScreen().launch(context);
                      }),
                    ],
                  ),
                  16.height,
                  Divider(color: primaryColor1.withOpacity(0.3), height: 0.1, thickness: 0.2),
                  16.height,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          createRichText(
                            list: [
                              TextSpan(text: "1.5M ", style: boldTextStyle()),
                              TextSpan(text: "followers", style: secondaryTextStyle()),
                            ],
                          ).onTap(() {
                            EAConnectionScreen().launch(context);
                          }),
                          24.width,
                          createRichText(
                            list: [
                              TextSpan(text: "25 ", style: boldTextStyle()),
                              TextSpan(text: "following", style: secondaryTextStyle()),
                            ],
                          ).onTap(() {
                            EAConnectionScreen().launch(context);
                          })
                        ],
                      ),
                      8.height,
                      Text("Interested in:", style: secondaryTextStyle()),
                      8.height,
                      Row(
                        children: [
                          Text(
                            hashTag,
                            style: primaryTextStyle(),
                            maxLines: isExpand ? hashTag.length : 1,
                          ).expand(),
                          IconButton(
                              onPressed: () {
                                isExpand = !isExpand;
                                setState(() {});
                              },
                              icon: isExpand ? Icon(Icons.keyboard_arrow_up_outlined) : Icon(Icons.keyboard_arrow_down_sharp)),
                        ],
                      ).expand(),
                    ],
                  ).expand(),
                ],
              ).paddingTop(16),
            ),
            Positioned(
              top: 130,
              child: commonCachedNetworkImage(
                'https://assets.iqonic.design/old-themeforest-images/prokit/datingApp/Image.9.jpg',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(50),
            )
          ],
        ),
      ],
    );
  }
}



