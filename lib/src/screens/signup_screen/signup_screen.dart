import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingoassessment/src/core/app_styles.dart';
import 'package:provider/provider.dart';
import '../../core/app_constants.dart';
import '../widgets/app_bar.dart';
import 'signup_screen_vm.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(text:  'e-Shop', appBarColor: AppStyles.whiteColor, textColor: AppStyles.blueColor,),
      body: SingleChildScrollView(
        child: Consumer<SignUpScreenViewModel>(
          builder: (context, SignUpScreenVM, child) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                      ),
                      // Email Field
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Theme(
                              data: Theme.of(context)
                                  .copyWith(splashColor: Colors.transparent),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  hintText: 'Name',
                                  hintStyle: GoogleFonts.poppins(
                                      color: AppStyles.greyishBlueColor,
                                      fontSize: 12,
                                      fontWeight: AppFontWeight.mediumFont),
                                  border: InputBorder.none,
                                ),
                                validator: (value) =>
                                    SignUpScreenVM.validateField(value, 'Name'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Email Field
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
                                    SignUpScreenVM.validateField(value, 'Email'),
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
                                      vertical: 12, horizontal: 12),
                                  hintText: AppConstants.passwordHintText,
                                  hintStyle: GoogleFonts.poppins(
                                      color: AppStyles.greyishBlueColor,
                                      fontSize: 12,
                                      fontWeight: AppFontWeight.mediumFont),
                                  border: InputBorder.none,
                                ),
                                validator: (value) =>
                                    SignUpScreenVM.validateField(
                                        value, 'Password'),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                  SignUpScreenVM.validateUserFields(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                      context);
                                }
                              },
                              child: SignUpScreenVM.isLoading
                                  ? const Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child:  CircularProgressIndicator(color: Colors.white,),
                                  )
                                  : Text(
                                      'Signup',
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
                                    'Already have an account?',
                                    style: GoogleFonts.poppins(
                                      fontWeight: AppFontWeight.mediumFont,
                                      color: AppStyles.greyishBlueColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      SignUpScreenVM.navigateToLoginScreen(
                                          context);
                                    },
                                    child: Text(
                                      'Login',
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
