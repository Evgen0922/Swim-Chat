import '../edit_settings/edit_settings_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsWidget extends StatefulWidget {
  const TermsWidget({Key key}) : super(key: key);

  @override
  _TermsWidgetState createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF0E171D),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Text(
            'Условия использования',
            style: FlutterFlowTheme.of(context).title1.override(
                  fontFamily: 'Lexend Deca',
                  color: FlutterFlowTheme.of(context).background,
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color(0xFF090F14),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 20, 5, 0),
                child: Text(
                  'Данное приложение находится в бета версии!\nАккаунты и данные могут быть удалены в любое время.\n\nПриложение расчитано на выкладывание информации связанной с плавательной тематикой.\nВсе нецензурные и оскорбительные (посты, истории, сообщения), а также не связанные с плавательной тематикой будут удалены.',
                  style: FlutterFlowTheme.of(context).title3.override(
                        fontFamily: 'Lexend Deca',
                        color: FlutterFlowTheme.of(context).gray200,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 360, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(270, 0, 0, 0),
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 70,
                  icon: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditSettingsWidget(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
