 import 'package:VeteBacin/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:VeteBacin/helper/colorpalatte.dart';

class UsersAgreement extends StatefulWidget {
  const UsersAgreement({super.key});

  @override
  _UsersAgreement createState() => _UsersAgreement();
}

class _UsersAgreement extends State<UsersAgreement> {

  final ColorPalette colors = ColorPalette();


  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(

        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Users Agreement',
            style: TextStyle(fontSize: 16.0),
          ),
          centerTitle: true,
          toolbarHeight: 60.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            },

          ),
          backgroundColor:colors.primaryAppBar,

        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: const BoxDecoration(
            color: const Color.fromRGBO(24, 24, 27, 1)
          ),

            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),

               child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: const [
                  const SizedBox(height: 20.0),
               Text(
               'USER AGREEMENT\n\n'
               'This User Agreement ("Agreement") is a legal agreement between you ("User") and VeteBacin for the use of the VeteBacin mobile application ("App"). By using the App, you agree to be bound by the terms of this Agreement.\n\n'
               '1. License Grant. VeteBacin hereby grants User a non-exclusive, non-transferable license to use the App for personal, non-commercial use only. User may not copy, modify, distribute, sell, or transfer the App or any portion thereof.\n\n'
               '2. Privacy Policy. User acknowledges that they have read and agree to VeteBacin\'s Privacy Policy, which is incorporated herein by reference.\n\n'
               '3. User Content. User may upload, transmit or otherwise make available information, text, images, videos, or other content ("User Content") through the App. User retains ownership of all User Content, but grants VeteBacin a worldwide, royalty-free, non-exclusive license to use, copy, modify, distribute, and display User Content for the purpose of operating the App.\n\n'
               '4. User Conduct. User agrees to use the App in compliance with all applicable laws and regulations, and to not use the App to:\n'
               '- Harass, abuse, or harm any person or entity;\n'
               '- Post or transmit any User Content that is illegal, offensive, or infringes upon the rights of any third party;\n'
               '- Interfere with or disrupt the App or servers or networks connected to the App;\n'
                 '- Use the App for any commercial purpose.\n\n'
                 '5. Intellectual Property. The App and all intellectual property rights therein, including but not limited to copyrights, trademarks, and patents, are owned by VeteBacin. User may not use any of VeteBacin\'s intellectual property without the prior written consent of VeteBacin.\n\n'
                 '6. Disclaimer of Warranties. The App is provided "as is" without warranty of any kind, either express or implied, including but not limited to the implied warranties of merchantability and fitness for a particular purpose.\n\n'
                 '7. Limitation of Liability. In no event shall VeteBacin be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use of the App, including but not limited to damages for loss of profits, use, data, or other intangible losses.\n\n'
               '8. Indemnification. User agrees to indemnify and hold VeteBacin, its affiliates, and their respective officers, directors, employees, and agents harmless from and against any claims, actions, suits, or proceedings, as well as any and all losses, liabilities, damages, costs, and expenses (including reasonable attorneys\' fees) arising out of or in connection with User\'s use of the App or any User Content.\n\n'
               '9. Termination. VeteBacin may terminate this Agreement at any time without notice, and User may also terminate this Agreement by deleting the App from their device.\n\n'
               '10. Governing Law. This Agreement shall be governed by and construed in accordance with the laws of Albania and Kosovo, without giving effect to any principles of conflicts of law.\n\n'
                 '11. Entire Agreement. This Agreement constitutes the entire agreement between User and VeteBacin and supersedes all prior agreements or understandings, whether written or oral, relating to the subject matter hereof.\n\n'
                 'By using the App, User acknowledges that they have read and agree to be bound by the terms of this Agreement. If User does not agree to the terms of this Agreement, they may not use the App.\n\n'
                   'If any provision of this Agreement is found to be unlawful, void, or unenforceable, then that provision shall be deemed severable from this Agreement and shall not affect the validity and enforceability of any remaining provisions.\n\n'
                   'Any failure by VeteBacin to enforce any right or provision of this Agreement shall not be deemed a waiver of such right or provision.\n\n'
                   'VeteBacin reserves the right to modify this Agreement at any time. Users continued use of the App after any such modifications shall constitute their acceptance of the modified Agreement.\n\n'
                 'If User has any questions or concerns regarding this Agreement, they may contact VeteBacin at info@vetebacin.de.\n\n',
                 style: TextStyle(fontSize: 16, color: Colors.white),
               ),
                  const SizedBox(height: 20.0),



                 ],
              ),
            ),

        ),
      ),
    );
  }
}
