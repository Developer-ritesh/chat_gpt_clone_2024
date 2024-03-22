import 'package:client/design/app_colors.dart';
import 'package:client/features/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnbaordingPage extends StatelessWidget {
  const OnbaordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenBgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset(
                "assets/openai.svg",
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Welcome to ChatGPT",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pinkBgColor),
            ),
            const SizedBox(height: 10),
            Text(
              "Our work to create safe and beneficial AI requires a deep understanding of the potential risks and benefits, as well as careful consideration of the impact.",
              style: TextStyle(fontSize: 18, color: AppColors.pinkBgColor),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.pinkBgColor)))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Try ChatGPT",
                        style: TextStyle(
                            fontSize: 18, color: AppColors.pinkBgColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: AppColors.pinkBgColor)
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        )),
      ),
    );
  }
}
