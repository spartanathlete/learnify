library signup_screen;

import 'dart:developer';
import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnify/components/custom_button.dart';
import 'package:learnify/components/custom_text_field.dart';
import 'package:learnify/components/responsive_builder.dart';
import 'package:learnify/constans/app_constants.dart';
import 'package:learnify/controllers/data_controller.dart';
import 'package:learnify/models/user_model.dart';
import 'package:learnify/providers/theme_provider.dart';
import 'package:learnify/screens/auth/auth_repo.dart';
import 'package:learnify/screens/shared_ui_functions.dart';
import 'package:learnify/utils/size_config.dart';

class SignupScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final SizeConfig sizeConfig;

  const SignupScreen({
    super.key,
    required this.themeProvider,
    required this.sizeConfig,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final DashboardController controller = DashboardController();
  final AuthRepo authRepo = AuthRepo();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confPass = TextEditingController();

  SharedUiFunctions sharedUiFunctions = SharedUiFunctions();

  Uint8List? _profilePic;

  final _formKey = GlobalKey<FormState>();

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    return null;
  }

  selectImage() async {
    Uint8List? image = await pickImage(ImageSource.gallery);
    setState(() {
      _profilePic = image;
      log('Image picked as Unis8List: $_profilePic');
    });
  }

  void openDrawer() {
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    confPass.dispose();
    super.dispose();
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color(0xFF21899C),
        resizeToAvoidBottomInset: false,
        body: mob(
          context: context,
          constraints: constraints,
          config: widget.sizeConfig,
          themeProvider: widget.themeProvider,
          firstname: firstname,
          lastname: lastname,
          username: username,
          email: email,
          password: password,
          confPass: confPass,
        ),
      );
    });
  }

  Widget mob({
    required BuildContext context,
    required BoxConstraints constraints,
    required SizeConfig config,
    required ThemeProvider themeProvider,
    required TextEditingController firstname,
    required TextEditingController lastname,
    required TextEditingController username,
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController confPass,
  }) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //bg design, we use 3 svg img
          Positioned(
            left: -26,
            top: 51.0,
            child: SvgPicture.string(
              '<svg viewBox="-26.0 51.0 91.92 91.92" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -26.0, 96.96)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -10.83, 105.24)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 16.51, 93.51)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 91.92,
              height: 91.92,
            ),
          ),
          Positioned(
            right: 43.0,
            top: -103,
            child: SvgPicture.string(
              '<svg viewBox="63.0 -103.0 268.27 268.27" ><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 63.0, 67.08)" d="M 147.2896423339844 0 L 196.3861999511719 98.19309997558594 L 147.2896423339844 196.3861999511719 L 49.09654235839844 196.3861999511719 L 0 98.19309234619141 L 49.09656143188477 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 113.73, 79.36)" d="M 0 0 L 83.46413421630859 33.38565444946289 L 166.9282684326172 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 184.38, 23.77)" d="M 0 111.9401321411133 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 268.27,
              height: 268.27,
            ),
          ),
          Positioned(
            right: -19,
            top: 31.0,
            child: SvgPicture.string(
              '<svg viewBox="329.0 31.0 65.0 65.0" ><path transform="translate(329.0, 31.0)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(333.88, 47.58)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(361.5, 58.63)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              width: 65.0,
              height: 65.0,
            ),
          ),

          //card and footer ui
          Positioned(
            bottom: 20.0,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: widget.sizeConfig.pixSize.width * 0.9,
                  height: widget.sizeConfig.pixSize.height * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: widget.sizeConfig.pixSize.height * 0.01,
                          ),
                          SizedBox(
                            height: widget.sizeConfig.pixSize.height * 0.05,
                          ),
                          Stack(
                            children: [
                              _profilePic == null
                                  ? const CircleAvatar(
                                      radius: 64,
                                      backgroundImage:
                                          AssetImage(ImageRasterPath.avatar1),
                                    )
                                  : CircleAvatar(
                                      radius: 64,
                                      backgroundImage:
                                          MemoryImage(_profilePic!),
                                    ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: widget.sizeConfig.pixSize.height * 0.03,
                          ),
                          //email & password textField
                          CustomTextField(
                            size: widget.sizeConfig.pixSize,
                            controller: firstname,
                            hint: 'Enter your firstname',
                            textInputType: TextInputType.text,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Firstname is required, please enter it.';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            size: widget.sizeConfig.pixSize,
                            controller: lastname,
                            hint: 'Enter your lastname',
                            textInputType: TextInputType.text,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Lastname is required, please enter it.';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            size: widget.sizeConfig.pixSize,
                            controller: username,
                            hint: 'Pick a username',
                            textInputType: TextInputType.text,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Username is required, please enter it.';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            size: widget.sizeConfig.pixSize,
                            controller: email,
                            hint: 'Enter your email',
                            textInputType: TextInputType.emailAddress,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required, please enter it.';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Enter a valid email please.';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            size: widget.sizeConfig.pixSize,
                            controller: password,
                            hint: 'Create a strong password',
                            textInputType: TextInputType.visiblePassword,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required, please enter it.';
                              } else if (value.length < 6) {
                                return 'Password is too short.';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            size: widget.sizeConfig.pixSize,
                            controller: confPass,
                            hint: 'Confirm password',
                            textInputType: TextInputType.visiblePassword,
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm your password please enter it.';
                              } else if (value != password.text) {
                                return 'Confirmation failed.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: widget.sizeConfig.pixSize.height * 0.03,
                          ),
                          CustomButton(
                              sizeConfig: widget.sizeConfig,
                              value: 'Sign Up',
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  authRepo.userSignup(UserModel(
                                    photo: _profilePic,
                                    firstname: firstname.text,
                                    lastname: lastname.text,
                                    username: username.text,
                                    email: email.text,
                                    password: password.text,
                                  ));
                                  // Show a success message or navigate to the next screen
                                  _showSuccessSnackBar(
                                      'Signed up successfully');
                                  context.goNamed('home');
                                }
                              }),
                          SizedBox(
                            height: widget.sizeConfig.pixSize.height * 0.04,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                buildFooter(config.pixSize),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tab(context, constraints, themeProvider) {
    return const SingleChildScrollView(
      child: Row(
        children: [],
      ),
    );
  }

  Widget buildFooter(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          height: size.height * 0.04,
        ),
        SizedBox(
          width: size.width * 0.6,
          height: 44.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: SvgPicture.string(
                  '<svg viewBox="0.3 0.27 22.44 22.44" ><defs><linearGradient id="gradient" x1="0.500031" y1="0.970054" x2="0.500031" y2="0.0"><stop offset="0.0" stop-color="#ff0062e0"  /><stop offset="1.0" stop-color="#ff19afff"  /></linearGradient></defs><path transform="translate(0.3, 0.27)" d="M 9.369577407836914 22.32988739013672 C 4.039577960968018 21.3760986328125 0 16.77546882629395 0 11.22104930877686 C 0 5.049472332000732 5.049472808837891 0 11.22105026245117 0 C 17.39262962341309 0 22.44210624694824 5.049472332000732 22.44210624694824 11.22104930877686 C 22.44210624694824 16.77546882629395 18.40252304077148 21.3760986328125 13.07252502441406 22.32988739013672 L 12.45536518096924 21.8249397277832 L 9.986735343933105 21.8249397277832 L 9.369577407836914 22.32988739013672 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(6.93, 4.65)" d="M 8.976840972900391 9.986734390258789 L 9.481786727905273 6.844839572906494 L 6.508208274841309 6.844839572906494 L 6.508208274841309 4.656734466552734 C 6.508208274841309 3.759051322937012 6.844841003417969 3.085787773132324 8.191367149353027 3.085787773132324 L 9.650103569030762 3.085787773132324 L 9.650103569030762 0.2244201600551605 C 8.864629745483398 0.1122027561068535 7.966946125030518 0 7.181471347808838 0 C 4.600629806518555 0 2.805262804031372 1.570946097373962 2.805262804031372 4.376209735870361 L 2.805262804031372 6.844839572906494 L 0 6.844839572906494 L 0 9.986734390258789 L 2.805262804031372 9.986734390258789 L 2.805262804031372 17.8975715637207 C 3.422420024871826 18.00978851318359 4.039577484130859 18.06587600708008 4.656735897064209 18.06587600708008 C 5.273893356323242 18.06587600708008 5.89105224609375 18.009765625 6.508208274841309 17.8975715637207 L 6.508208274841309 9.986734390258789 L 8.976840972900391 9.986734390258789 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 22.44,
                  height: 22.44,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                alignment: Alignment.center,
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: SvgPicture.string(
                  // Group 59
                  '<svg viewBox="11.0 11.0 22.92 22.92" ><path transform="translate(11.0, 11.0)" d="M 22.6936149597168 9.214142799377441 L 21.77065277099609 9.214142799377441 L 21.77065277099609 9.166590690612793 L 11.45823860168457 9.166590690612793 L 11.45823860168457 13.74988651275635 L 17.93386268615723 13.74988651275635 C 16.98913192749023 16.41793632507324 14.45055770874023 18.33318138122559 11.45823860168457 18.33318138122559 C 7.661551475524902 18.33318138122559 4.583295345306396 15.25492572784424 4.583295345306396 11.45823860168457 C 4.583295345306396 7.661551475524902 7.661551475524902 4.583295345306396 11.45823860168457 4.583295345306396 C 13.21077632904053 4.583295345306396 14.80519008636475 5.244435787200928 16.01918983459473 6.324374675750732 L 19.26015281677246 3.083411931991577 C 17.21371269226074 1.176188230514526 14.47633838653564 0 11.45823860168457 0 C 5.130426406860352 0 0 5.130426406860352 0 11.45823860168457 C 0 17.78605079650879 5.130426406860352 22.91647720336914 11.45823860168457 22.91647720336914 C 17.78605079650879 22.91647720336914 22.91647720336914 17.78605079650879 22.91647720336914 11.45823860168457 C 22.91647720336914 10.68996334075928 22.83741569519043 9.940022468566895 22.6936149597168 9.214142799377441 Z" fill="#ffc107" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(12.32, 11.0)" d="M 0 6.125000953674316 L 3.764603137969971 8.885863304138184 C 4.78324031829834 6.363905429840088 7.250198841094971 4.583294868469238 10.13710117340088 4.583294868469238 C 11.88963890075684 4.583294868469238 13.48405265808105 5.244434833526611 14.69805240631104 6.324373722076416 L 17.93901443481445 3.083411693572998 C 15.89257335662842 1.176188111305237 13.15520095825195 0 10.13710117340088 0 C 5.735992908477783 0 1.919254422187805 2.484718799591064 0 6.125000953674316 Z" fill="#ff3d00" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(12.26, 24.78)" d="M 10.20069408416748 9.135653495788574 C 13.16035556793213 9.135653495788574 15.8496036529541 8.003005981445312 17.88286781311035 6.161093711853027 L 14.33654403686523 3.160181760787964 C 13.14749050140381 4.064460277557373 11.69453620910645 4.553541660308838 10.20069408416748 4.55235767364502 C 7.220407009124756 4.55235767364502 4.689855575561523 2.6520094871521 3.736530303955078 0 L 0 2.878881216049194 C 1.896337866783142 6.589632034301758 5.747450828552246 9.135653495788574 10.20069408416748 9.135653495788574 Z" fill="#4caf50" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(22.46, 20.17)" d="M 11.23537635803223 0.04755179211497307 L 10.31241607666016 0.04755179211497307 L 10.31241607666016 0 L 0 0 L 0 4.583295345306396 L 6.475625038146973 4.583295345306396 C 6.023715496063232 5.853105068206787 5.209692478179932 6.962699413299561 4.134132385253906 7.774986743927002 L 4.135851383209229 7.773841857910156 L 7.682177066802979 10.77475357055664 C 7.431241512298584 11.00277233123779 11.45823955535889 8.020766258239746 11.45823955535889 2.291647672653198 C 11.45823955535889 1.523372769355774 11.37917804718018 0.773431122303009 11.23537635803223 0.04755179211497307 Z" fill="#1976d2" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 22.92,
                  height: 22.92,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                alignment: const Alignment(0.02, 0.04),
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: SvgPicture.string(
                  // Vector
                  '<svg viewBox="13.0 11.0 18.62 22.92" ><path transform="translate(13.0, 11.0)" d="M 13.86734199523926 0.01146837882697582 C 13.81864452362061 -0.04295870289206505 12.0640869140625 0.03295278549194336 10.53726387023926 1.690114140510559 C 9.010440826416016 3.345843315124512 9.245336532592773 5.245062351226807 9.279711723327637 5.293760299682617 C 9.3140869140625 5.34245777130127 11.45679569244385 5.418369293212891 12.82463455200195 3.491936922073364 C 14.19247245788574 1.565504670143127 13.91604042053223 0.06732775270938873 13.86734199523926 0.01146837882697582 L 13.86734199523926 0.01146837882697582 Z M 18.61395645141602 16.8165454864502 C 18.54520606994629 16.67904663085938 15.28387928009033 15.04909896850586 15.5875244140625 11.91524410247803 C 15.89117050170898 8.77995777130127 17.98661231994629 7.920583248138428 18.01955604553223 7.827484607696533 C 18.05249786376953 7.73438549041748 17.16447639465332 6.695973873138428 16.22346115112305 6.170322895050049 C 15.53254699707031 5.799720764160156 14.76786804199219 5.587391376495361 13.98478984832764 5.548707962036133 C 13.83010196685791 5.544411182403564 13.29299354553223 5.41264009475708 12.18869590759277 5.714853763580322 C 11.46109199523926 5.913942337036133 9.821117401123047 6.558474063873291 9.369945526123047 6.584255218505859 C 8.917341232299805 6.610036373138428 7.570987701416016 5.83659839630127 6.122940540313721 5.631780624389648 C 5.196248054504395 5.452744007110596 4.213696002960205 5.819411754608154 3.510440826416016 6.10157299041748 C 2.808617830276489 6.382302284240723 1.473721981048584 7.181520938873291 0.5398677587509155 9.305609703063965 C -0.3939864635467529 11.42826557159424 0.09442496299743652 14.79128551483154 0.4439041316509247 15.83685874938965 C 0.7933833003044128 16.8809986114502 1.339086413383484 18.59258651733398 2.267211437225342 19.84154510498047 C 3.092211484909058 21.25092124938965 4.186482429504395 22.22917556762695 4.643383502960205 22.56146812438965 C 5.100284576416016 22.89375877380371 6.389346599578857 23.11433219909668 7.283096790313721 22.65743255615234 C 8.002107620239258 22.21628570556641 9.299763679504395 21.96277046203613 9.81252384185791 21.98138999938965 C 10.32385158538818 22.00000953674316 11.33218574523926 22.20196151733398 12.3648681640625 22.75339508056641 C 13.18270683288574 23.03555679321289 13.95614337921143 22.9181079864502 14.73101329803467 22.60300445556641 C 15.50588321685791 22.28646850585938 16.62736701965332 21.08620643615723 17.93648147583008 18.65274429321289 C 18.43348693847656 17.52123260498047 18.6597900390625 16.90964508056641 18.61395645141602 16.8165454864502 L 18.61395645141602 16.8165454864502 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 18.62,
                  height: 22.92,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          children: [
            const Text(
              'Already have an account?',
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () => context.goNamed('login'),
              child: const Text(
                'Login here',
                style: TextStyle(
                  color: Color(0xFFFE9879),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
