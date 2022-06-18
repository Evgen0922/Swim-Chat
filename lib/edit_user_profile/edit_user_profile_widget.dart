import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import '../login/login_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditUserProfileWidget extends StatefulWidget {
  const EditUserProfileWidget({Key key}) : super(key: key);

  @override
  _EditUserProfileWidgetState createState() => _EditUserProfileWidgetState();
}

class _EditUserProfileWidgetState extends State<EditUserProfileWidget> {
  String uploadedFileUrl = '';
  TextEditingController yourNameController;
  TextEditingController userNameController;
  TextEditingController bioController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryColor,
              ),
            ),
          );
        }
        final editUserProfileUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xFF090F13),
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 46,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).background,
                size: 24,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Твой профиль',
              style: FlutterFlowTheme.of(context).title2.override(
                    fontFamily: 'Lexend Deca',
                    color: FlutterFlowTheme.of(context).gray200,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: Color(0xFF090F13),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                            child: InkWell(
                              onTap: () async {
                                final selectedMedia =
                                    await selectMediaWithSourceBottomSheet(
                                  context: context,
                                  allowPhoto: true,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .tertiaryColor,
                                  textColor:
                                      FlutterFlowTheme.of(context).primaryDark,
                                  pickerFontFamily: 'Lexend Deca',
                                );
                                if (selectedMedia != null &&
                                    selectedMedia.every((m) =>
                                        validateFileFormat(
                                            m.storagePath, context))) {
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  final downloadUrls = (await Future.wait(
                                          selectedMedia.map((m) async =>
                                              await uploadData(
                                                  m.storagePath, m.bytes))))
                                      .where((u) => u != null)
                                      .toList();
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if (downloadUrls != null &&
                                      downloadUrls.length ==
                                          selectedMedia.length) {
                                    setState(() =>
                                        uploadedFileUrl = downloadUrls.first);
                                    showUploadMessage(
                                      context,
                                      'Success!',
                                    );
                                  } else {
                                    showUploadMessage(
                                      context,
                                      'Failed to upload media',
                                    );
                                    return;
                                  }
                                }
                              },
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).gray200,
                                  image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: Image.network(
                                      valueOrDefault<String>(
                                        uploadedFileUrl,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-social-app-tx2kqp/assets/7dvyeuxvy2dg/addUser@2x.png',
                                      ),
                                    ).image,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: yourNameController ??=
                                        TextEditingController(
                                      text: editUserProfileUsersRecord
                                          .displayName,
                                    ),
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Твоё имя',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .subtitle1,
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .title2
                                        .override(
                                          fontFamily: 'Lexend Deca',
                                          color: FlutterFlowTheme.of(context)
                                              .background,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: TextFormField(
                                      controller: userNameController ??=
                                          TextEditingController(
                                        text:
                                            editUserProfileUsersRecord.userName,
                                      ),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'НикНейм',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .title3
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: FlutterFlowTheme.of(context)
                                                .background,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 12, 0, 0),
                                    child: TextFormField(
                                      controller: bioController ??=
                                          TextEditingController(
                                        text: editUserProfileUsersRecord.bio,
                                      ),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                        hintText: 'О себе',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyText1,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .gray200,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .gray200,
                                            width: 1,
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 8, 0, 0),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText2
                                          .override(
                                            fontFamily: 'Lexend Deca',
                                            color: FlutterFlowTheme.of(context)
                                                .gray200,
                                          ),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 40),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final usersUpdateData = createUsersRecordData(
                                    displayName: yourNameController?.text ?? '',
                                    userName: userNameController?.text ?? '',
                                    photoUrl: uploadedFileUrl,
                                    bio: bioController?.text ?? '',
                                  );
                                  await currentUserReference
                                      .update(usersUpdateData);
                                  Navigator.pop(context);
                                },
                                text: 'Сохранить',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .title3
                                      .override(
                                        fontFamily: 'Lexend Deca',
                                        color: FlutterFlowTheme.of(context)
                                            .gray200,
                                      ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(100, 120, 100, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await deleteUser(context);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginWidget(),
                              ),
                            );
                          },
                          text: 'Удалить аккаунт',
                          options: FFButtonOptions(
                            width: 130,
                            height: 40,
                            color: Color(0xFFC62828),
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Lexend Deca',
                                      color: Colors.white,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
