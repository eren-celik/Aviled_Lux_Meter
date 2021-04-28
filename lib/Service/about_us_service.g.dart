// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_us_service.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AboutUsService on _AboutUsServiceBase, Store {
  final _$aboutUsShopInformationAtom = Atom(name: '_AboutUsServiceBase.aboutUsShopInformation');

  @override
  List<Location> get aboutUsShopInformation {
    _$aboutUsShopInformationAtom.reportRead();
    return super.aboutUsShopInformation;
  }

  @override
  set aboutUsShopInformation(List<Location> value) {
    _$aboutUsShopInformationAtom.reportWrite(value, super.aboutUsShopInformation, () {
      super.aboutUsShopInformation = value;
    });
  }

  final _$aboutUsGeneralInformationAtom = Atom(name: '_AboutUsServiceBase.aboutUsGeneralInformation');

  @override
  List<Aboutus> get aboutUsGeneralInformation {
    _$aboutUsGeneralInformationAtom.reportRead();
    return super.aboutUsGeneralInformation;
  }

  @override
  set aboutUsGeneralInformation(List<Aboutus> value) {
    _$aboutUsGeneralInformationAtom.reportWrite(value, super.aboutUsGeneralInformation, () {
      super.aboutUsGeneralInformation = value;
    });
  }

  final _$aboutUsStateAtom = Atom(name: '_AboutUsServiceBase.aboutUsState');

  @override
  AboutUsState get aboutUsState {
    _$aboutUsStateAtom.reportRead();
    return super.aboutUsState;
  }

  @override
  set aboutUsState(AboutUsState value) {
    _$aboutUsStateAtom.reportWrite(value, super.aboutUsState, () {
      super.aboutUsState = value;
    });
  }

  final _$getAboutUsInformationAsyncAction = AsyncAction('_AboutUsServiceBase.getAboutUsInformation');

  @override
  Future<dynamic> getAboutUsInformation() {
    return _$getAboutUsInformationAsyncAction.run(() => super.getAboutUsInformation());
  }

  @override
  String toString() {
    return '''
aboutUsShopInformation: ${aboutUsShopInformation},
aboutUsGeneralInformation: ${aboutUsGeneralInformation},
aboutUsState: ${aboutUsState}
    ''';
  }
}
