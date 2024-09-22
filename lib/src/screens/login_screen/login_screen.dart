import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoassessment/src/core/app_styles.dart';
import 'package:lingoassessment/src/screens/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import '../../core/app_constants.dart';
import 'login_screen_vm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginScreenViewModel>().setRemoteConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.whiteColor,
      appBar: const CustomAppBar(
        text: 'e-Shop',
        appBarColor: AppStyles.whiteColor,
        textColor: AppStyles.blueColor,
      ),
      body: SingleChildScrollView(
        child: Consumer<LoginScreenViewModel>(
          builder: (context, loginScreenVM, child) {
            return Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  hintText: AppConstants.emailHintText,
                                  hintStyle: GoogleFonts.poppins(
                                      color: AppStyles.greyishBlueColor,
                                      fontSize: 12,
                                      fontWeight: AppFontWeight.mediumFont),
                                  border: InputBorder.none,
                                ),
                                validator: (value) =>
                                    loginScreenVM.validateField(value, 'Email'),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Password Field
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 7),
                                  hintText: AppConstants.passwordHintText,
                                  hintStyle: GoogleFonts.poppins(
                                      color: AppStyles.greyishBlueColor,
                                      fontSize: 12,
                                      fontWeight: AppFontWeight.mediumFont),
                                  border: InputBorder.none,
                                ),
                                validator: (value) => loginScreenVM
                                    .validateField(value, 'Password'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Login Button
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: const Color(0xff6200EE),
                                  fixedSize: const Size(200, 50)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  loginScreenVM.validateUserFields(
                                      emailController.text,
                                      passwordController.text,
                                      context);
                                }
                              },
                              child: loginScreenVM.isLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Login',
                                      style: GoogleFonts.inter(
                                        fontWeight: AppFontWeight.boldFont,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 10),

                            // Signup Section
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New Here?',
                                    style: GoogleFonts.poppins(
                                      fontWeight: AppFontWeight.mediumFont,
                                      color: AppStyles.greyishBlueColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      loginScreenVM
                                          .navigateToSignUpScreen(context);
                                    },
                                    child: Text(
                                      'Signup',
                                      style: GoogleFonts.poppins(
                                        fontWeight: AppFontWeight.mediumFont,
                                        color: AppStyles.blueColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
