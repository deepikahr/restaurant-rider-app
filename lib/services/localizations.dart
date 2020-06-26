import 'dart:async' show Future;
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'constant.dart';

class MyLocalizations {
  final Map<String, Map<String, String>> localizedValues;
  MyLocalizations(this.locale, this.localizedValues);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String get hello {
    return localizedValues[locale.languageCode]['hello'];
  }

  String get areYouSureYouWantToAssignOrderTo {
    return localizedValues[locale.languageCode]
        ['areYouSureYouWantToAssignOrderTo'];
  }

  String get assignedSuccessfully {
    return localizedValues[locale.languageCode]['assignedSuccessfully'];
  }

  String get goBack {
    return localizedValues[locale.languageCode]['goBack'];
  }

  String get myAccount {
    return localizedValues[locale.languageCode]['myAccount'];
  }

  String get viewProducts {
    return localizedValues[locale.languageCode]['viewProducts'];
  }

  String get userName {
    return localizedValues[locale.languageCode]['userName'];
  }

  String get changeProfile {
    return localizedValues[locale.languageCode]['changeProfile'];
  }

  String get updateProfile {
    return localizedValues[locale.languageCode]['updateProfile'];
  }

  String get greenSalad {
    return localizedValues[locale.languageCode]['greenSalad'];
  }

  String get edit {
    return localizedValues[locale.languageCode]['edit'];
  }

  String get pleaseWait {
    return localizedValues[locale.languageCode]['pleaseWait'];
  }

  String get enableDisable {
    return localizedValues[locale.languageCode]['enableDisable'];
  }

  String get searchProduct {
    return localizedValues[locale.languageCode]['searchProduct'];
  }

  String get products {
    return localizedValues[locale.languageCode]['products'];
  }

  String get pleaseEnterAValidEmail {
    return localizedValues[locale.languageCode]['pleaseEnterAValidEmail'];
  }

  String get passwordShouldBeAtleast6CharLong {
    return localizedValues[locale.languageCode]
        ['passwordShouldBeAtleast6CharLong'];
  }

  String get loginSuccessfully {
    return localizedValues[locale.languageCode]['loginSuccessfully'];
  }

  String get selectImage {
    return localizedValues[locale.languageCode]['selectImage'];
  }

  String get locationName {
    return localizedValues[locale.languageCode]['locationName'];
  }

  String get extraVariant {
    return localizedValues[locale.languageCode]['extraVariant'];
  }

  String get serial {
    return localizedValues[locale.languageCode]['serial'];
  }

  String get variant {
    return localizedValues[locale.languageCode]['variant'];
  }

  String get category {
    return localizedValues[locale.languageCode]['category'];
  }

  String get productName {
    return localizedValues[locale.languageCode]['productName'];
  }

  String get enterBrandName {
    return localizedValues[locale.languageCode]['enterBrandName'];
  }

  String get aboutOurProduct {
    return localizedValues[locale.languageCode]['aboutOurProduct'];
  }

  String get variantInfo {
    return localizedValues[locale.languageCode]['variantInfo'];
  }

  String get halfFull {
    return localizedValues[locale.languageCode]['halfFull'];
  }

  String get discount {
    return localizedValues[locale.languageCode]['discount'];
  }

  String get extraVariantInfo {
    return localizedValues[locale.languageCode]['extraVariantInfo'];
  }

  String get create {
    return localizedValues[locale.languageCode]['create'];
  }

  String get youAreNotAuthorizedToLogin {
    return localizedValues[locale.languageCode]['youAreNotAuthorizedToLogin'];
  }

  String get orderAccepted {
    return localizedValues[locale.languageCode]['orderAccepted'];
  }

  String get orderCancelled {
    return localizedValues[locale.languageCode]['orderCancelled'];
  }

  String get orderHistory {
    return localizedValues[locale.languageCode]['orderHistory'];
  }

  String get addProducts {
    return localizedValues[locale.languageCode]['addProducts'];
  }

  String get noOrderHistory {
    return localizedValues[locale.languageCode]['noOrderHistory'];
  }

  String get accept {
    return localizedValues[locale.languageCode]['accept'];
  }

  String get customerAndPaymentInfo {
    return localizedValues[locale.languageCode]['customerAndPaymentInfo'];
  }

  String get reject {
    return localizedValues[locale.languageCode]['reject'];
  }

  String get newOrders {
    return localizedValues[locale.languageCode]['newOrders'];
  }

  String get inProgress {
    return localizedValues[locale.languageCode]['inProgress'];
  }

  String get orders {
    return localizedValues[locale.languageCode]['orders'];
  }

  String get home {
    return localizedValues[locale.languageCode]['home'];
  }

  String get cart {
    return localizedValues[locale.languageCode]['cart'];
  }

  String get myOrders {
    return localizedValues[locale.languageCode]['myOrders'];
  }

  String get favourites {
    return localizedValues[locale.languageCode]['favourites'];
  }

  String get profile {
    return localizedValues[locale.languageCode]['profile'];
  }

  String get aboutUs {
    return localizedValues[locale.languageCode]['aboutUs'];
  }

  String get login {
    return localizedValues[locale.languageCode]['login'];
  }

  String get logout {
    return localizedValues[locale.languageCode]['logout'];
  }

  String get restaurantsNearYou {
    return localizedValues[locale.languageCode]['restaurantsNearYou'];
  }

  String get topRatedRestaurants {
    return localizedValues[locale.languageCode]['topRatedRestaurants'];
  }

  String get newlyArrivedRestaurants {
    return localizedValues[locale.languageCode]['newlyArrivedRestaurants'];
  }

  String get viewAll {
    return localizedValues[locale.languageCode]['viewAll'];
  }

  String get reviews {
    return localizedValues[locale.languageCode]['reviews'];
  }

  String get branches {
    return localizedValues[locale.languageCode]['branches'];
  }

  String get selectLanguages {
    return localizedValues[locale.languageCode]['selectLanguages'];
  }

  String get shortDescription {
    return localizedValues[locale.languageCode]['shortDescription'];
  }

  String get emailId {
    return localizedValues[locale.languageCode]['emailId'];
  }

  String get fullName {
    return localizedValues[locale.languageCode]['fullName'];
  }

  String get mobileNumber {
    return localizedValues[locale.languageCode]['mobileNumber'];
  }

  String get subUrban {
    return localizedValues[locale.languageCode]['subUrban'];
  }

  String get state {
    return localizedValues[locale.languageCode]['state'];
  }

  String get country {
    return localizedValues[locale.languageCode]['country'];
  }

  String get postalCode {
    return localizedValues[locale.languageCode]['postalCode'];
  }

  String get address {
    return localizedValues[locale.languageCode]['address'];
  }

  String get cancel {
    return localizedValues[locale.languageCode]['cancel'];
  }

  String get save {
    return localizedValues[locale.languageCode]['save'];
  }

  String get yourEmail {
    return localizedValues[locale.languageCode]['yourEmail'];
  }

  String get yourPassword {
    return localizedValues[locale.languageCode]['yourPassword'];
  }

  String get loginToYourAccount {
    return localizedValues[locale.languageCode]['loginToYourAccount'];
  }

  String get forgotPassword {
    return localizedValues[locale.languageCode]['forgotPassword'];
  }

  String get dontHaveAccountYet {
    return localizedValues[locale.languageCode]['dontHaveAccountYet'];
  }

  String get signInNow {
    return localizedValues[locale.languageCode]['signInNow'];
  }

  String get pleaseEnterValidEmail {
    return localizedValues[locale.languageCode]['pleaseEnterValidEmail'];
  }

  String get pleaseEnterValidPassword {
    return localizedValues[locale.languageCode]['pleaseEnterValidPassword'];
  }

  String get pleaseEnterValidName {
    return localizedValues[locale.languageCode]['pleaseEnterValidName'];
  }

  String get pleaseEnterValidMobileNumber {
    return localizedValues[locale.languageCode]['pleaseEnterValidMobileNumber'];
  }

  String get loginSuccessful {
    return localizedValues[locale.languageCode]['loginSuccessful'];
  }

  String get password {
    return localizedValues[locale.languageCode]['password'];
  }

  String get acceptTerms {
    return localizedValues[locale.languageCode]['acceptTerms'];
  }

  String get registerNow {
    return localizedValues[locale.languageCode]['registerNow'];
  }

  String get register {
    return localizedValues[locale.languageCode]['register'];
  }

  String get resetPassword {
    return localizedValues[locale.languageCode]['resetPassword'];
  }

  String get resetPasswordOtp {
    return localizedValues[locale.languageCode]['resetPasswordOtp'];
  }

  String get resetMessage {
    return localizedValues[locale.languageCode]['resetMessage'];
  }

  String get verifyOtp {
    return localizedValues[locale.languageCode]['verifyOtp'];
  }

  String get otpErrorMessage {
    return localizedValues[locale.languageCode]['otpErrorMessage'];
  }

  String get otpMessage {
    return localizedValues[locale.languageCode]['otpMessage'];
  }

  String get createPassword {
    return localizedValues[locale.languageCode]['createPassword'];
  }

  String get createPasswordMessage {
    return localizedValues[locale.languageCode]['createPasswordMessage'];
  }

  String get connectionError {
    return localizedValues[locale.languageCode]['connectionError'];
  }

  String get favoritesListEmpty {
    return localizedValues[locale.languageCode]['favoritesListEmpty'];
  }

  String get removedFavoriteItem {
    return localizedValues[locale.languageCode]['removedFavoriteItem'];
  }

  String get cartEmpty {
    return localizedValues[locale.languageCode]['cartEmpty'];
  }

  String get upcoming {
    return localizedValues[locale.languageCode]['upcoming'];
  }

  String get history {
    return localizedValues[locale.languageCode]['history'];
  }

  String get noCompletedOrders {
    return localizedValues[locale.languageCode]['noCompletedOrders'];
  }

  String get assignForDeliver {
    return localizedValues[locale.languageCode]['assignForDeliver'];
  }

  String get pleaseTryAgain {
    return localizedValues[locale.languageCode]['pleaseTryAgain'];
  }

  String get assignedTo {
    return localizedValues[locale.languageCode]['assignedTo'];
  }

  String get selectDeliveryAgent {
    return localizedValues[locale.languageCode]['selectDeliveryAgent'];
  }

  String get alreadyAssigned {
    return localizedValues[locale.languageCode]['alreadyAssigned'];
  }

  String get noStaffAvailable {
    return localizedValues[locale.languageCode]['noStaffAvailable'];
  }

  String get status {
    return localizedValues[locale.languageCode]['status'];
  }

  String get view {
    return localizedValues[locale.languageCode]['view'];
  }

  String get track {
    return localizedValues[locale.languageCode]['track'];
  }

  String get total {
    return localizedValues[locale.languageCode]['total'];
  }

  String get paymentMode {
    return localizedValues[locale.languageCode]['paymentMode'];
  }

  String get chargesIncluding {
    return localizedValues[locale.languageCode]['chargesIncluding'];
  }

  String get trackOrder {
    return localizedValues[locale.languageCode]['trackOrder'];
  }

  String get orderProgress {
    return localizedValues[locale.languageCode]['orderProgress'];
  }

  String get daysAgo {
    return localizedValues[locale.languageCode]['daysAgo'];
  }

  String get weeksAgo {
    return localizedValues[locale.languageCode]['weeksAgo'];
  }

  String get dayAgo {
    return localizedValues[locale.languageCode]['dayAgo'];
  }

  String get weekAgo {
    return localizedValues[locale.languageCode]['weekAgo'];
  }

  String get usersReview {
    return localizedValues[locale.languageCode]['usersReview'];
  }

  String get outletsDelivering {
    return localizedValues[locale.languageCode]['outletsDelivering'];
  }

  String get noLocationsFound {
    return localizedValues[locale.languageCode]['noLocationsFound'];
  }

  String get noProducts {
    return localizedValues[locale.languageCode]['noProducts'];
  }

  String get goToCart {
    return localizedValues[locale.languageCode]['goToCart'];
  }

  String get location {
    return localizedValues[locale.languageCode]['location'];
  }

  String get open {
    return localizedValues[locale.languageCode]['open'];
  }

  String get freeDeliveryAbove {
    return localizedValues[locale.languageCode]['freeDeliveryAbove'];
  }

  String get deliveryChargesOnly {
    return localizedValues[locale.languageCode]['deliveryChargesOnly'];
  }

  String get freeDeliveryAvailable {
    return localizedValues[locale.languageCode]['freeDeliveryAvailable'];
  }

  String get size {
    return localizedValues[locale.languageCode]['size'];
  }

  String get price {
    return localizedValues[locale.languageCode]['price'];
  }

  String get selectSize {
    return localizedValues[locale.languageCode]['selectSize'];
  }

  String get completeOrder {
    return localizedValues[locale.languageCode]['completeOrder'];
  }

  String get addNote {
    return localizedValues[locale.languageCode]['addNote'];
  }

  String get applyCoupon {
    return localizedValues[locale.languageCode]['applyCoupon'];
  }

  String get subTotal {
    return localizedValues[locale.languageCode]['subTotal'];
  }

  String get deliveryCharges {
    return localizedValues[locale.languageCode]['deliveryCharges'];
  }

  String get grandTotal {
    return localizedValues[locale.languageCode]['grandTotal'];
  }

  String get cookNote {
    return localizedValues[locale.languageCode]['cookNote'];
  }

  String get note {
    return localizedValues[locale.languageCode]['note'];
  }

  String get add {
    return localizedValues[locale.languageCode]['add'];
  }

  String get pleaseEnter {
    return localizedValues[locale.languageCode]['pleaseEnter'];
  }

  String get coupon {
    return localizedValues[locale.languageCode]['coupon'];
  }

  String get noCoupon {
    return localizedValues[locale.languageCode]['noCoupon'];
  }

  String get noResource {
    return localizedValues[locale.languageCode]['noResource'];
  }

  String get noCuisines {
    return localizedValues[locale.languageCode]['noCuisines'];
  }

  String get apply {
    return localizedValues[locale.languageCode]['apply'];
  }

  String get reviewOrder {
    return localizedValues[locale.languageCode]['reviewOrder'];
  }

  String get date {
    return localizedValues[locale.languageCode]['date'];
  }

  String get totalOrder {
    return localizedValues[locale.languageCode]['totalOrder'];
  }

  String get contactInformation {
    return localizedValues[locale.languageCode]['contactInformation'];
  }

  String get selectAddress {
    return localizedValues[locale.languageCode]['selectAddress'];
  }

  String get addAddress {
    return localizedValues[locale.languageCode]['addAddress'];
  }

  String get orderDetails {
    return localizedValues[locale.languageCode]['orderDetails'];
  }

  String get orderSummary {
    return localizedValues[locale.languageCode]['orderSummary'];
  }

  String get totalIncluding {
    return localizedValues[locale.languageCode]['totalIncluding'];
  }

  String get placeOrderNow {
    return localizedValues[locale.languageCode]['placeOrderNow'];
  }

  String get paymentMethod {
    return localizedValues[locale.languageCode]['paymentMethod'];
  }

  String get selectDateTime {
    return localizedValues[locale.languageCode]['selectDateTime'];
  }

  String get selectAddressFirst {
    return localizedValues[locale.languageCode]['selectAddressFirst'];
  }

  String get brand {
    return localizedValues[locale.languageCode]['brand'];
  }

  String get errorMessage {
    return localizedValues[locale.languageCode]['errorMessage'];
  }

  String get deliveryNotAvailable {
    return localizedValues[locale.languageCode]['deliveryNotAvailable'];
  }

  String get notDeliverToThisPostcode {
    return localizedValues[locale.languageCode]['notDeliverToThisPostcode'];
  }

  String get deliverToThisPostcode {
    return localizedValues[locale.languageCode]['deliverToThisPostcode'];
  }

  String get pickUp {
    return localizedValues[locale.languageCode]['pickUp'];
  }

  String get dineIn {
    return localizedValues[locale.languageCode]['dineIn'];
  }

  String get thankYou {
    return localizedValues[locale.languageCode]['thankYou'];
  }

  String get orderPlaced {
    return localizedValues[locale.languageCode]['orderPlaced'];
  }

  String get thankYouMessage {
    return localizedValues[locale.languageCode]['thankYouMessage'];
  }

  String get backTo {
    return localizedValues[locale.languageCode]['backTo'];
  }

  String get rateYourOrder {
    return localizedValues[locale.languageCode]['rateYourOrder'];
  }

  String get wereGlad {
    return localizedValues[locale.languageCode]['wereGlad'];
  }

  String get rateIt {
    return localizedValues[locale.languageCode]['rateIt'];
  }

  String get feedbackImportant {
    return localizedValues[locale.languageCode]['feedbackImportant'];
  }

  String get submit {
    return localizedValues[locale.languageCode]['submit'];
  }

  String get writeReview {
    return localizedValues[locale.languageCode]['writeReview'];
  }

  String get deliveryAddress {
    return localizedValues[locale.languageCode]['deliveryAddress'];
  }

  String get whereToDeliver {
    return localizedValues[locale.languageCode]['whereToDeliver'];
  }

  String get byCreating {
    return localizedValues[locale.languageCode]['byCreating'];
  }

  String get please {
    return localizedValues[locale.languageCode]['please'];
  }

  String get enterYour {
    return localizedValues[locale.languageCode]['enterYour'];
  }

  String get city {
    return localizedValues[locale.languageCode]['city'];
  }

  String get item {
    return localizedValues[locale.languageCode]['item'];
  }

  String get type {
    return localizedValues[locale.languageCode]['type'];
  }

  String get pickUpTime {
    return localizedValues[locale.languageCode]['pickUpTime'];
  }

  String get tableNo {
    return localizedValues[locale.languageCode]['tableNo'];
  }

  String get orderID {
    return localizedValues[locale.languageCode]['orderID'];
  }

  String get rate {
    return localizedValues[locale.languageCode]['rate'];
  }

  String get name {
    return localizedValues[locale.languageCode]['name'];
  }

  String get confirm {
    return localizedValues[locale.languageCode]['confirm'];
  }

  String get contactNo {
    return localizedValues[locale.languageCode]['contactNo'];
  }

  String get orderType {
    return localizedValues[locale.languageCode]['orderType'];
  }

  String get restaurant {
    return localizedValues[locale.languageCode]['restaurant'];
  }

  String get totalincludingGST {
    return localizedValues[locale.languageCode]['totalincludingGST'];
  }

  String get success {
    return localizedValues[locale.languageCode]['success'];
  }

  String get otp {
    return localizedValues[locale.languageCode]['otp'];
  }

  String get pleaseAccepttermsandconditions {
    return localizedValues[locale.languageCode]
        ['pleaseAccepttermsandconditions'];
  }

  String get alert {
    return localizedValues[locale.languageCode]['alert'];
  }

  String get ok {
    return localizedValues[locale.languageCode]['ok'];
  }

  String get addCard {
    return localizedValues[locale.languageCode]['addCard'];
  }

  String get nameonCard {
    return localizedValues[locale.languageCode]['nameonCard'];
  }

  String get pleaseenteryourfullname {
    return localizedValues[locale.languageCode]['pleaseenteryourfullname'];
  }

  String get creditCardNumber {
    return localizedValues[locale.languageCode]['creditCardNumber'];
  }

  String get cardNumbermustbeof16digit {
    return localizedValues[locale.languageCode]['cardNumbermustbeof16digit'];
  }

  String get mm {
    return localizedValues[locale.languageCode]['mm'];
  }

  String get invalidmonth {
    return localizedValues[locale.languageCode]['invalidmonth'];
  }

  String get yyyy {
    return localizedValues[locale.languageCode]['yyyy'];
  }

  String get invalidyear {
    return localizedValues[locale.languageCode]['invalidyear'];
  }

  String get cvv {
    return localizedValues[locale.languageCode]['cvv'];
  }

  String get cardNumbermustbeof3digit {
    return localizedValues[locale.languageCode]['cardNumbermustbeof3digit'];
  }

  String get selectOrderType {
    return localizedValues[locale.languageCode]['selectOrderType'];
  }

  String get restaurantAddress {
    return localizedValues[locale.languageCode]['restaurantAddress'];
  }

  String get dELIVERY {
    return localizedValues[locale.languageCode]['dELIVERY'];
  }

  String get clickToSlot {
    return localizedValues[locale.languageCode]['clickToSlot'];
  }

  String get dateandTime {
    return localizedValues[locale.languageCode]['dateandTime'];
  }

  String get time {
    return localizedValues[locale.languageCode]['time'];
  }

  String get selectDate {
    return localizedValues[locale.languageCode]['selectDate'];
  }

  String get closed {
    return localizedValues[locale.languageCode]['closed'];
  }

  String get pleaseSelectDatefirstforpickup {
    return localizedValues[locale.languageCode]
        ['pleaseSelectDatefirstforpickup'];
  }

  String get storeisClosedPleaseTryAgainduringouropeninghours {
    return localizedValues[locale.languageCode]
        ['storeisClosedPleaseTryAgainduringouropeninghours'];
  }

  String get somethingwentwrongpleaserestarttheapp {
    return localizedValues[locale.languageCode]
        ['somethingwentwrongpleaserestarttheapp'];
  }

  String get logoutSuccessfully {
    return localizedValues[locale.languageCode]['logoutSuccessfully'];
  }

  String get nearBy {
    return localizedValues[locale.languageCode]['nearBy'];
  }

  String get topRated {
    return localizedValues[locale.languageCode]['topRated'];
  }

  String get newlyArrived {
    return localizedValues[locale.languageCode]['newlyArrived'];
  }

  String get cod {
    return localizedValues[locale.languageCode]['cod'];
  }

  String get noPaymentMethods {
    return localizedValues[locale.languageCode]['noPaymentMethods'];
  }

  String get selectCard {
    return localizedValues[locale.languageCode]['selectCard'];
  }

  String get noSavedCardsPleaseaddone {
    return localizedValues[locale.languageCode]['noSavedCardsPleaseaddone'];
  }

  String get pleaseEnterCVV {
    return localizedValues[locale.languageCode]['pleaseEnterCVV'];
  }

  String get cVVmustbeof3digits {
    return localizedValues[locale.languageCode]['cVVmustbeof3digits'];
  }

  String get paymentFailed {
    return localizedValues[locale.languageCode]['paymentFailed'];
  }

  String get yourordercancelledPleasetryagain {
    return localizedValues[locale.languageCode]
        ['yourordercancelledPleasetryagain'];
  }

  String get productRemovedFromFavourite {
    return localizedValues[locale.languageCode]['productRemovedFromFavourite'];
  }

  String get productaddedtoFavourites {
    return localizedValues[locale.languageCode]['productaddedtoFavourites'];
  }

  String get whichextraingredientswouldyouliketoadd {
    return localizedValues[locale.languageCode]
        ['whichextraingredientswouldyouliketoadd'];
  }

  String get extra {
    return localizedValues[locale.languageCode]['extra'];
  }

  String get deliveryisNotAvailable {
    return localizedValues[locale.languageCode]['deliveryisNotAvailable'];
  }

  String get description {
    return localizedValues[locale.languageCode]['description'];
  }

  String get clearcart {
    return localizedValues[locale.languageCode]['clearcart'];
  }

  String get youhavesomeitemsalreadyinyourcartfromotherlocationremovetoaddthis {
    return localizedValues[locale.languageCode]
        ['youhavesomeitemsalreadyinyourcartfromotherlocationremovetoaddthis'];
  }

  String get yes {
    return localizedValues[locale.languageCode]['yes'];
  }

  String get no {
    return localizedValues[locale.languageCode]['no'];
  }

  String get nodeliveryavailable {
    return localizedValues[locale.languageCode]['nodeliveryavailable'];
  }

  String get freedeliveryabove {
    return localizedValues[locale.languageCode]['freedeliveryabove'];
  }

  String get freedeliveryavailable {
    return localizedValues[locale.languageCode]['freedeliveryavailable'];
  }

  String get storeisClosed {
    return localizedValues[locale.languageCode]['storeisClosed'];
  }

  String get openingTime {
    return localizedValues[locale.languageCode]['openingTime'];
  }

  String get sorry {
    return localizedValues[locale.languageCode]['sorry'];
  }

  String get restaurants {
    return localizedValues[locale.languageCode]['restaurants'];
  }

  String get restaurantSass {
    return localizedValues[locale.languageCode]['restaurantSass'];
  }

  String get grilledChickenLoremipsumdolorsitametconsecteturadipiscingelit {
    return localizedValues[locale.languageCode]
        ['grilledChickenLoremipsumdolorsitametconsecteturadipiscingelit'];
  }

  String get seddoeiusmodtemporincididuntutlaboreetdolormagna {
    return localizedValues[locale.languageCode]
        ['seddoeiusmodtemporincididuntutlaboreetdolormagna'];
  }

  String get pleaseSelectTimefirstforpickup {
    return localizedValues[locale.languageCode]
        ['pleaseSelectTimefirstforpickup'];
  }

  String get pleaseSelectAddshippingaddressfirst {
    return localizedValues[locale.languageCode]
        ['pleaseSelectAddshippingaddressfirst'];
  }

  String get noDeliverycharge {
    return localizedValues[locale.languageCode]['noDeliverycharge'];
  }

  String get earnings {
    return localizedValues[locale.languageCode]['earnings'];
  }

  String get liveTasks {
    return localizedValues[locale.languageCode]['liveTasks'];
  }

  String get confirmation {
    return localizedValues[locale.languageCode]['confirmation'];
  }

  String get areyousureyouArrivedatRestaurant {
    return localizedValues[locale.languageCode]
        ['areyousureyouArrivedatRestaurant'];
  }

  String get cONFIRM {
    return localizedValues[locale.languageCode]['cONFIRM'];
  }

  String get arrivedatRestaurant {
    return localizedValues[locale.languageCode]['arrivedatRestaurant'];
  }

  String get totalBill {
    return localizedValues[locale.languageCode]['totalBill'];
  }

  String get collectfromCustomer {
    return localizedValues[locale.languageCode]['collectfromCustomer'];
  }

  String get help {
    return localizedValues[locale.languageCode]['help'];
  }

  String get orderDelivered {
    return localizedValues[locale.languageCode]['orderDelivered'];
  }

  String get orderisPlaced {
    return localizedValues[locale.languageCode]['orderisPlaced'];
  }

  String get orderStatus {
    return localizedValues[locale.languageCode]['orderStatus'];
  }

  String get payGlobalRestaurant {
    return localizedValues[locale.languageCode]['payGlobalRestaurant'];
  }

  String get orderPicked {
    return localizedValues[locale.languageCode]['orderPicked'];
  }

  String get startDelivery {
    return localizedValues[locale.languageCode]['startDelivery'];
  }

  String get submitBill {
    return localizedValues[locale.languageCode]['submitBill'];
  }

  String get camera {
    return localizedValues[locale.languageCode]['camera'];
  }

  String get uploadBill {
    return localizedValues[locale.languageCode]['uploadBill'];
  }

  String get upload {
    return localizedValues[locale.languageCode]['upload'];
  }

  String get noEarning {
    return localizedValues[locale.languageCode]['noEarning'];
  }

  String get totalEarningsfor {
    return localizedValues[locale.languageCode]['totalEarningsfor'];
  }

  String get earningDetails {
    return localizedValues[locale.languageCode]['earningDetails'];
  }

  String get noImage {
    return localizedValues[locale.languageCode]['noImage'];
  }

  String get noOrders {
    return localizedValues[locale.languageCode]['noOrders'];
  }

  String get yourprofilePictureSuccessfullyUPDATED {
    return localizedValues[locale.languageCode]
        ['yourprofilePictureSuccessfullyUPDATED'];
  }

  String get changeprofilepicture {
    return localizedValues[locale.languageCode]['changeprofilepicture'];
  }

  String get choosefromphotos {
    return localizedValues[locale.languageCode]['choosefromphotos'];
  }

  String get takephoto {
    return localizedValues[locale.languageCode]['takephoto'];
  }

  String get removephoto {
    return localizedValues[locale.languageCode]['removephoto'];
  }

  String get search {
    return localizedValues[locale.languageCode]['search'];
  }

  String get items {
    return localizedValues[locale.languageCode]['items'];
  }

  String get noHistory {
    return localizedValues[locale.languageCode]['noHistory'];
  }

  String get noNewOrder {
    return localizedValues[locale.languageCode]['noNewOrder'];
  }

  String get noProcessingOrder {
    return localizedValues[locale.languageCode]['noProcessingOrder'];
  }

  String get nEW {
    return localizedValues[locale.languageCode]['nEW'];
  }

  String get processing {
    return localizedValues[locale.languageCode]['processing'];
  }

  String get modified {
    return localizedValues[locale.languageCode]['modified'];
  }

  String get yourprofileSuccessfullyUPDATED {
    return localizedValues[locale.languageCode]
        ['yourprofileSuccessfullyUPDATED'];
  }

  greetTo(name) {
    return localizedValues[locale.languageCode]['greetTo']
        .replaceAll('{{name}}', name);
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  Map<String, Map<String, String>> localizedValues;

  MyLocalizationsDelegate(this.localizedValues);

  @override
  bool isSupported(Locale locale) => LANGUAGES.contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(
        MyLocalizations(locale, localizedValues));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
