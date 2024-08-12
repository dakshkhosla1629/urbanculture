import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urbanculture/provider/imageuploadingprovider.dart';
import 'package:urbanculture/utills/comman_widgets.dart';
import '../provider/skincareprovider.dart';

class Dailyscreen extends StatefulWidget {
  const Dailyscreen({super.key});

  @override
  State<Dailyscreen> createState() => _DailyscreenState();
}

class _DailyscreenState extends State<Dailyscreen> {
  final steps = [
    {
      'step': 'cleanser',
      'name': 'Cleanser',
      'product': 'Cetaphil Gentle Skin Cleanser'
    },
    {'step': 'toner', 'name': 'Toner', 'product': 'Thayers Witch Hazel Toner'},
    {
      'step': 'moisturizer',
      'name': 'Moisturizer',
      'product': "Kiehl's Ultra Facial Cream"
    },
    {
      'step': 'sunscreen',
      'name': 'Sunscreen',
      'product': 'Supergoop Unseen Sunscreen SPF 40'
    },
    {
      'step': 'lipBalm',
      'name': 'Lip Balm',
      'product': 'Glossier Birthday Balm Dotcom'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<Imageuploadingprovider>(context);
    final skincareProvider = Provider.of<SkincareProvider>(context);

    return Scaffold(
      backgroundColor: CommanWidgets.backgroundcolor,
      appBar: CommanWidgets.myAppBar("Daily Skincare", context),
      body: ListView.builder(
        itemCount: steps.length,
        itemBuilder: (context, index) {
          final step = steps[index];
          final isLoading = imageProvider.isUploading(step['step']!);

          return ListTile(
            minTileHeight: 72,
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: CommanWidgets.boxbackgroundcolor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {
                  skincareProvider.checkboxstepvalue(step['step']!, context);
                  print(
                      "Current Streak: ${skincareProvider.streak.currentStreak}");
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: CommanWidgets.boxbackgroundcolor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: skincareProvider.getStepStatus(step['step']!)
                      ? Image.asset(
                          "assets/tick.png",
                        )
                      : Icon(
                          Icons.check_box_outline_blank_outlined,
                          size: 50,
                          color: CommanWidgets.boxbackgroundcolor,
                        ),
                ),
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['name']!,
                        style: GoogleFonts.epilogue(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: CommanWidgets.textheadingcolor,
                        ),
                      ),
                      Text(
                        step['product']!,
                        style: GoogleFonts.epilogue(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: CommanWidgets.textsubheadingcolor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (!isLoading) {
                        imageProvider.pickImage(context, step['step']!);
                      }
                    },
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: 27,
                            child: Image.asset("assets/camera.jpeg")),
                  ),
                ),
              ],
            ),
            trailing: Text(
              DateFormat('h a').format(DateTime.now()),
              style: GoogleFonts.epilogue(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: CommanWidgets.textsubheadingcolor,
              ),
            ),
          );
        },
      ),
    );
  }
}
