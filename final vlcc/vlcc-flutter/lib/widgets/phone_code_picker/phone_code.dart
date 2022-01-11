import 'package:flutter/material.dart';
import 'package:vlcc/resources/app_colors.dart';

class Country {
  final String name;
  final String dialCode;
  final String code;
  Country({
    required this.name,
    required this.dialCode,
    required this.code,
  });
}

final List<Country> countries = [
  Country(name: "Israel", dialCode: "+972", code: "IL"),
  Country(name: "Afghanistan", dialCode: "+93", code: "AF"),
  Country(name: "Albania", dialCode: "+355", code: "AL"),
  Country(name: "Algeria", dialCode: "+213", code: "DZ"),
  Country(name: "AmericanSamoa", dialCode: "+1 684", code: "AS"),
  Country(name: "Andorra", dialCode: "+376", code: "AD"),
  Country(name: "Angola", dialCode: "+244", code: "AO"),
  Country(name: "Anguilla", dialCode: "+1 264", code: "AI"),
  Country(name: "Antigua and Barbuda", dialCode: "+1268", code: "AG"),
  Country(name: "Argentina", dialCode: "+54", code: "AR"),
  Country(name: "Armenia", dialCode: "+374", code: "AM"),
  Country(name: "Aruba", dialCode: "+297", code: "AW"),
  Country(name: "Australia", dialCode: "+61", code: "AU"),
  Country(name: "Austria", dialCode: "+43", code: "AT"),
  Country(name: "Azerbaijan", dialCode: "+994", code: "AZ"),
  Country(name: "Bahamas", dialCode: "+1 242", code: "BS"),
  Country(name: "Bahrain", dialCode: "+973", code: "BH"),
  Country(name: "Bangladesh", dialCode: "+880", code: "BD"),
  Country(name: "Barbados", dialCode: "+1 246", code: "BB"),
  Country(name: "Belarus", dialCode: "+375", code: "BY"),
  Country(name: "Belgium", dialCode: "+32", code: "BE"),
  Country(name: "Belize", dialCode: "+501", code: "BZ"),
  Country(name: "Benin", dialCode: "+229", code: "BJ"),
  Country(name: "Bermuda", dialCode: "+1 441", code: "BM"),
  Country(name: "Bhutan", dialCode: "+975", code: "BT"),
  Country(name: "Bosnia and Herzegovina", dialCode: "+387", code: "BA"),
  Country(name: "Botswana", dialCode: "+267", code: "BW"),
  Country(name: "Brazil", dialCode: "+55", code: "BR"),
  Country(name: "British Indian Ocean Territory", dialCode: "+246", code: "IO"),
  Country(name: "Bulgaria", dialCode: "+359", code: "BG"),
  Country(name: "Burkina Faso", dialCode: "+226", code: "BF"),
  Country(name: "Burundi", dialCode: "+257", code: "BI"),
  Country(name: "Cambodia", dialCode: "+855", code: "KH"),
  Country(name: "Cameroon", dialCode: "+237", code: "CM"),
  Country(name: "Canada", dialCode: "+1", code: "CA"),
  Country(name: "Cape Verde", dialCode: "+238", code: "CV"),
  Country(name: "Cayman Islands", dialCode: "+345", code: "KY"),
  Country(name: "Central African Republic", dialCode: "+236", code: "CF"),
  Country(name: "Chad", dialCode: "+235", code: "TD"),
  Country(name: "Chile", dialCode: "+56", code: "CL"),
  Country(name: "China", dialCode: "+86", code: "CN"),
  Country(name: "Christmas Island", dialCode: "+61", code: "CX"),
  Country(name: "Colombia", dialCode: "+57", code: "CO"),
  Country(name: "Comoros", dialCode: "+269", code: "KM"),
  Country(name: "Congo", dialCode: "+242", code: "CG"),
  Country(name: "Cook Islands", dialCode: "+682", code: "CK"),
  Country(name: "Costa Rica", dialCode: "+506", code: "CR"),
  Country(name: "Croatia", dialCode: "+385", code: "HR"),
  Country(name: "Cuba", dialCode: "+53", code: "CU"),
  Country(name: "Cyprus", dialCode: "+537", code: "CY"),
  Country(name: "Czech Republic", dialCode: "+420", code: "CZ"),
  Country(name: "Denmark", dialCode: "+45", code: "DK"),
  Country(name: "Djibouti", dialCode: "+253", code: "DJ"),
  Country(name: "Dominica", dialCode: "+1 767", code: "DM"),
  Country(name: "Dominican Republic", dialCode: "+1 849", code: "DO"),
  Country(name: "Ecuador", dialCode: "+593", code: "EC"),
  Country(name: "Egypt", dialCode: "+20", code: "EG"),
  Country(name: "El Salvador", dialCode: "+503", code: "SV"),
  Country(name: "Equatorial Guinea", dialCode: "+240", code: "GQ"),
  Country(name: "Eritrea", dialCode: "+291", code: "ER"),
  Country(name: "Estonia", dialCode: "+372", code: "EE"),
  Country(name: "Ethiopia", dialCode: "+251", code: "ET"),
  Country(name: "Faroe Islands", dialCode: "+298", code: "FO"),
  Country(name: "Fiji", dialCode: "+679", code: "FJ"),
  Country(name: "Finland", dialCode: "+358", code: "FI"),
  Country(name: "France", dialCode: "+33", code: "FR"),
  Country(name: "French Guiana", dialCode: "+594", code: "GF"),
  Country(name: "French Polynesia", dialCode: "+689", code: "PF"),
  Country(name: "Gabon", dialCode: "+241", code: "GA"),
  Country(name: "Gambia", dialCode: "+220", code: "GM"),
  Country(name: "Georgia", dialCode: "+995", code: "GE"),
  Country(name: "Germany", dialCode: "+49", code: "DE"),
  Country(name: "Ghana", dialCode: "+233", code: "GH"),
  Country(name: "Gibraltar", dialCode: "+350", code: "GI"),
  Country(name: "Greece", dialCode: "+30", code: "GR"),
  Country(name: "Greenland", dialCode: "+299", code: "GL"),
  Country(name: "Grenada", dialCode: "+1 473", code: "GD"),
  Country(name: "Guadeloupe", dialCode: "+590", code: "GP"),
  Country(name: "Guam", dialCode: "+1 671", code: "GU"),
  Country(name: "Guatemala", dialCode: "+502", code: "GT"),
  Country(name: "Guinea", dialCode: "+224", code: "GN"),
  Country(name: "Guinea-Bissau", dialCode: "+245", code: "GW"),
  Country(name: "Guyana", dialCode: "+595", code: "GY"),
  Country(name: "Haiti", dialCode: "+509", code: "HT"),
  Country(name: "Honduras", dialCode: "+504", code: "HN"),
  Country(name: "Hungary", dialCode: "+36", code: "HU"),
  Country(name: "Iceland", dialCode: "+354", code: "IS"),
  Country(name: "India", dialCode: "+91", code: "IN"),
  Country(name: "Iraq", dialCode: "+964", code: "IQ"),
  Country(name: "Ireland", dialCode: "+353", code: "IE"),
  Country(name: "Israel", dialCode: "+972", code: "IL"),
  Country(name: "Italy", dialCode: "+39", code: "IT"),
  Country(name: "Jamaica", dialCode: "+1 876", code: "JM"),
  Country(name: "Japan", dialCode: "+81", code: "JP"),
  Country(name: "Jordan", dialCode: "+962", code: "JO"),
  Country(name: "Kazakhstan", dialCode: "+7 7", code: "KZ"),
  Country(name: "Kenya", dialCode: "+254", code: "KE"),
  Country(name: "Kiribati", dialCode: "+686", code: "KI"),
  Country(name: "Kuwait", dialCode: "+965", code: "KW"),
  Country(name: "Kyrgyzstan", dialCode: "+996", code: "KG"),
  Country(name: "Latvia", dialCode: "+371", code: "LV"),
  Country(name: "Lebanon", dialCode: "+961", code: "LB"),
  Country(name: "Lesotho", dialCode: "+266", code: "LS"),
  Country(name: "Liberia", dialCode: "+231", code: "LR"),
  Country(name: "Liechtenstein", dialCode: "+423", code: "LI"),
  Country(name: "Lithuania", dialCode: "+370", code: "LT"),
  Country(name: "Luxembourg", dialCode: "+352", code: "LU"),
  Country(name: "Madagascar", dialCode: "+261", code: "MG"),
  Country(name: "Malawi", dialCode: "+265", code: "MW"),
  Country(name: "Malaysia", dialCode: "+60", code: "MY"),
  Country(name: "Maldives", dialCode: "+960", code: "MV"),
  Country(name: "Mali", dialCode: "+223", code: "ML"),
  Country(name: "Malta", dialCode: "+356", code: "MT"),
  Country(name: "Marshall Islands", dialCode: "+692", code: "MH"),
  Country(name: "Martinique", dialCode: "+596", code: "MQ"),
  Country(name: "Mauritania", dialCode: "+222", code: "MR"),
  Country(name: "Mauritius", dialCode: "+230", code: "MU"),
  Country(name: "Mayotte", dialCode: "+262", code: "YT"),
  Country(name: "Mexico", dialCode: "+52", code: "MX"),
  Country(name: "Monaco", dialCode: "+377", code: "MC"),
  Country(name: "Mongolia", dialCode: "+976", code: "MN"),
  Country(name: "Montenegro", dialCode: "+382", code: "ME"),
  Country(name: "Montserrat", dialCode: "+1664", code: "MS"),
  Country(name: "Montserrat", dialCode: "+1664", code: "MS"),
  Country(name: "Morocco", dialCode: "+212", code: "MA"),
  Country(name: "Myanmar", dialCode: "+95", code: "MM"),
  Country(name: "Namibia", dialCode: "+264", code: "NA"),
  Country(name: "Nauru", dialCode: "+674", code: "NR"),
  Country(name: "Nepal", dialCode: "+977", code: "NP"),
  Country(name: "Netherlands", dialCode: "+31", code: "NL"),
  Country(name: "Netherlands Antilles", dialCode: "+599", code: "AN"),
  Country(name: "New Caledonia", dialCode: "+687", code: "NC"),
  Country(name: "New Zealand", dialCode: "+64", code: "NZ"),
  Country(name: "Nicaragua", dialCode: "+505", code: "NI"),
  Country(name: "Niger", dialCode: "+227", code: "NE"),
  Country(name: "Nigeria", dialCode: "+234", code: "NG"),
  Country(name: "Niue", dialCode: "+683", code: "NU"),
  Country(name: "Norfolk Island", dialCode: "+672", code: "NF"),
  Country(name: "Northern Mariana Islands", dialCode: "+1 670", code: "MP"),
  Country(name: "Norway", dialCode: "+47", code: "NO"),
  Country(name: "Oman", dialCode: "+968", code: "OM"),
  Country(name: "Pakistan", dialCode: "+92", code: "PK"),
  Country(name: "Palau", dialCode: "+680", code: "PW"),
  Country(name: "Panama", dialCode: "+507", code: "PA"),
  Country(name: "Papua New Guinea", dialCode: "+675", code: "PG"),
  Country(name: "Paraguay", dialCode: "+595", code: "PY"),
  Country(name: "Peru", dialCode: "+51", code: "PE"),
  Country(name: "Philippines", dialCode: "+63", code: "PH"),
  Country(name: "Poland", dialCode: "+48", code: "PL"),
  Country(name: "Portugal", dialCode: "+351", code: "PT"),
  Country(name: "Puerto Rico", dialCode: "+1 939", code: "PR"),
  Country(name: "Qatar", dialCode: "+974", code: "QA"),
  Country(name: "Romania", dialCode: "+40", code: "RO"),
  Country(name: "Rwanda", dialCode: "+250", code: "RW"),
  Country(name: "Samoa", dialCode: "+685", code: "WS"),
  Country(name: "San Marino", dialCode: "+378", code: "SM"),
  Country(name: "Saudi Arabia", dialCode: "+966", code: "SA"),
  Country(name: "Senegal", dialCode: "+221", code: "SN"),
  Country(name: "Serbia", dialCode: "+381", code: "RS"),
  Country(name: "Seychelles", dialCode: "+248", code: "SC"),
  Country(name: "Sierra Leone", dialCode: "+232", code: "SL"),
  Country(name: "Singapore", dialCode: "+65", code: "SG"),
  Country(name: "Slovakia", dialCode: "+421", code: "SK"),
  Country(name: "Slovenia", dialCode: "+386", code: "SI"),
  Country(name: "Solomon Islands", dialCode: "+677", code: "SB"),
  Country(name: "South Africa", dialCode: "+27", code: "ZA"),
  Country(
      name: "South Georgia and the South Sandwich Islands",
      dialCode: "+500",
      code: "GS"),
  Country(name: "Spain", dialCode: "+34", code: "ES"),
  Country(name: "Sri Lanka", dialCode: "+94", code: "LK"),
  Country(name: "Sudan", dialCode: "+249", code: "SD"),
  Country(name: "Suriname", dialCode: "+597", code: "SR"),
  Country(name: "Swaziland", dialCode: "+268", code: "SZ"),
  Country(name: "Sweden", dialCode: "+46", code: "SE"),
  Country(name: "Switzerland", dialCode: "+41", code: "CH"),
  Country(name: "Tajikistan", dialCode: "+992", code: "TJ"),
  Country(name: "Thailand", dialCode: "+66", code: "TH"),
  Country(name: "Togo", dialCode: "+228", code: "TG"),
  Country(name: "Tokelau", dialCode: "+690", code: "TK"),
  Country(name: "Tonga", dialCode: "+676", code: "TO"),
  Country(name: "Trinidad and Tobago", dialCode: "+1 868", code: "TT"),
  Country(name: "Tunisia", dialCode: "+216", code: "TN"),
  Country(name: "Turkey", dialCode: "+90", code: "TR"),
  Country(name: "Turkmenistan", dialCode: "+993", code: "TM"),
  Country(name: "Turks and Caicos Islands", dialCode: "+1 649", code: "TC"),
  Country(name: "Tuvalu", dialCode: "+688", code: "TV"),
  Country(name: "Uganda", dialCode: "+256", code: "UG"),
  Country(name: "Ukraine", dialCode: "+380", code: "UA"),
  Country(name: "United Arab Emirates", dialCode: "+971", code: "AE"),
  Country(name: "United Kingdom", dialCode: "+44", code: "GB"),
  Country(name: "United States", dialCode: "+1", code: "US"),
  Country(name: "Uzbekistan", dialCode: "+998", code: "UZ"),
  Country(name: "Vanuatu", dialCode: "+678", code: "VU"),
  Country(name: "Yemen", dialCode: "+967", code: "YE"),
  Country(name: "Zambia", dialCode: "+260", code: "ZM"),
  Country(name: "Zimbabwe", dialCode: "+263", code: "ZW"),
  Country(
      name: "Bolivia, Plurinational State of", dialCode: "+591", code: "BO"),
  Country(name: "Brunei Darussalam", dialCode: "+673", code: "BN"),
  Country(name: "Cocos (Keeling) Islands", dialCode: "+61", code: "CC"),
  Country(
      name: "Congo, The Democratic Republic of the",
      dialCode: "+243",
      code: "CD"),
  Country(name: "Cote d'Ivoire", dialCode: "+225", code: "CI"),
  Country(name: "Falkland Islands (Malvinas)", dialCode: "+500", code: "FK"),
  Country(name: "Guernsey", dialCode: "+44", code: "GG"),
  Country(name: "Holy See (Vatican City State)", dialCode: "+379", code: "VA"),
  Country(name: "Hong Kong", dialCode: "+852", code: "HK"),
  Country(name: "Iran, Islamic Republic of", dialCode: "+98", code: "IR"),
  Country(name: "Isle of Man", dialCode: "+44", code: "IM"),
  Country(name: "Jersey", dialCode: "+44", code: "JE"),
  Country(
      name: "Korea, Democratic People's Republic of",
      dialCode: "+850",
      code: "KP"),
  Country(name: "Korea, Republic of", dialCode: "+82", code: "KR"),
  Country(
      name: "Lao People's Democratic Republic", dialCode: "+856", code: "LA"),
  Country(name: "Libyan Arab Jamahiriya", dialCode: "+218", code: "LY"),
  Country(name: "Macao", dialCode: "+853", code: "MO"),
  Country(
      name: "Macedonia, The Former Yugoslav Republic of",
      dialCode: "+389",
      code: "MK"),
  Country(
      name: "Micronesia, Federated States of", dialCode: "+691", code: "FM"),
  Country(name: "Moldova, Republic of", dialCode: "+373", code: "MD"),
  Country(name: "Mozambique", dialCode: "+258", code: "MZ"),
  Country(
      name: "Palestinian Territory, Occupied", dialCode: "+970", code: "PS"),
  Country(name: "Pitcairn", dialCode: "+872", code: "PN"),
  Country(name: "Réunion", dialCode: "+262", code: "RE"),
  Country(name: "Russia", dialCode: "+7", code: "RU"),
  Country(name: "Saint Barthélemy", dialCode: "+590", code: "BL"),
  Country(
      name: "Saint Helena, Ascension and Tristan Da Cunha",
      dialCode: "+290",
      code: "SH"),
  Country(name: "Saint Kitts and Nevis", dialCode: "+1 869", code: "KN"),
  Country(name: "Saint Lucia", dialCode: "+1 758", code: "LC"),
  Country(name: "Saint Martin", dialCode: "+590", code: "MF"),
  Country(name: "Saint Pierre and Miquelon", dialCode: "+508", code: "PM"),
  Country(
      name: "Saint Vincent and the Grenadines", dialCode: "+1 784", code: "VC"),
  Country(name: "Sao Tome and Principe", dialCode: "+239", code: "ST"),
  Country(name: "Somalia", dialCode: "+252", code: "SO"),
  Country(name: "Svalbard and Jan Mayen", dialCode: "+47", code: "SJ"),
  Country(name: "Syrian Arab Republic", dialCode: "+963", code: "SY"),
  Country(name: "Taiwan, Province of China", dialCode: "+886", code: "TW"),
  Country(name: "Tanzania, United Republic of", dialCode: "+255", code: "TZ"),
  Country(name: "Timor-Leste", dialCode: "+670", code: "TL"),
  Country(
      name: "Venezuela, Bolivarian Republic of", dialCode: "+58", code: "VE"),
  Country(name: "Viet Nam", dialCode: "+84", code: "VN"),
  Country(name: "Virgin Islands, British", dialCode: "+1 284", code: "VG"),
  Country(name: "Virgin Islands, U.S.", dialCode: "+1 340", code: "VI"),
];

class PhoneCodePicker extends StatefulWidget {
  final Function(Country counter) onSelected;
  const PhoneCodePicker({Key? key, required this.onSelected}) : super(key: key);

  @override
  _PhoneCodePickerState createState() => _PhoneCodePickerState();
}

class _PhoneCodePickerState extends State<PhoneCodePicker> {
  final _searchTextController = TextEditingController();

  final List<Country> _filterCountry = [];

  @override
  void initState() {
    super.initState();

    _filterCountry.addAll(countries);
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4)),
                width: 60,
                height: 8,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              // color: widget.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: _searchTextController,
              // style: TextStyle(color: widget.primaryColor,fontSize: 14),
              onChanged: _onSearch,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search here..',
                  hintStyle: TextStyle(
                      color: AppColors.profileEnabled.withOpacity(0.5),
                      fontSize: 14)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) => ListTile(
                onTap: () {
                  Navigator.pop(context);
                  widget.onSelected(_filterCountry[i]);
                },
                leading: CircleAvatar(
                  backgroundColor: AppColors.orange1,
                  child: Text(
                    _filterCountry[i].code,
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                title: Text(
                  _filterCountry[i].name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Text(
                  _filterCountry[i].dialCode,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              itemCount: _filterCountry.length,
            ),
          ),
        ],
      ),
    );
  }

  void _onSearch(String key) {
    _filterCountry.clear();

    for (var element in countries) {
      if (element.name.toLowerCase().contains(key.toLowerCase()) ||
          element.code.toLowerCase().contains(key.toLowerCase())) {
        _filterCountry.add(element);
      }
    }

    setState(() {});
  }
}

// class PhoneCodePicker extends StatefulWidget {
//   final Color primaryColor;
//   final Function(Country counter) onSelected;
//   const PhoneCodePicker({Key key,this.primaryColor = Colors.blueAccent,@required this.onSelected}) : assert(primaryColor!=null), super(key: key);

//   @override
//   _PhoneCodePickerState createState() => _PhoneCodePickerState();
// }

// class _PhoneCodePickerState extends State<PhoneCodePicker> {

// final _searchTextController = TextEditingController();

// final List<Country> _filterCountry = [];

// @override
// void initState() {
//   super.initState();

//   _filterCountry.addAll(countries);
// }

// @override
// void dispose() {
//   _searchTextController.dispose();
//   super.dispose();
// }

// @override
// Widget build(BuildContext context) {
//   return Container(
//     height: MediaQuery.of(context).size.height*0.5,
//     child: Column(
//       children: [
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: widget.primaryColor.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(4)
//               ),
//               width: 60,
//               height: 8,
//             ),
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.all(10),
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           decoration: BoxDecoration(
//             color: widget.primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: TextField(
//             controller: _searchTextController,
//             style: TextStyle(color: widget.primaryColor,fontSize: 14),
//             onChanged:_onSearch,
//             decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search here..',
//                 hintStyle: TextStyle(color: widget.primaryColor.withOpacity(0.5),fontSize: 14)
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             itemBuilder: (_, i) => ListTile(
//               onTap: (){
//                 Navigator.pop(context);
//                 widget.onSelected(_filterCountry[i]);
//               },
//               leading: CircleAvatar(
//                 backgroundColor: widget.primaryColor,
//                 child: Text(_filterCountry[i].code,style: TextStyle(fontSize: 12,color: Colors.white),),
//               ),
//               title: Text(_filterCountry[i].name,style: Theme.of(context).textTheme.bodyText1,),
//               trailing: Text(_filterCountry[i].dialCode,style: Theme.of(context).textTheme.bodyText1,),
//             ),
//             itemCount: _filterCountry.length,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// void _onSearch(String key){
//   _filterCountry.clear();

//   countries.forEach((element) {
//     if(element.name.toLowerCase().contains(key.toLowerCase()) || element.code.toLowerCase().contains(key.toLowerCase()))
//       _filterCountry.add(element);
//   });

//   setState(() {

//   });
// }

// }
