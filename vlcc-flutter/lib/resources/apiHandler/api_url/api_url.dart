import 'dart:convert';

class ApiUrl {
  static String get generalAppointmentListUrl =>
      '/api/api_client_appointment_list.php?request=client_appointment_list';
  static String get videoAppointmentTokenUpdate =>
      '/api/api_video_consultation_token_update_rbs.php?request=api_video_consultation_token_update_rbs';
  static String get apppointmentListUrl =>
      '/api/api_client_rbs_appointment_list.php?request=client_rbs_appointment_list';
  static String get cashInvoiceApi =>
      '/api/api_client_rbs_invoice_list.php?request=client_rbs_invoice_list';

  static String get packageListingUrl =>
      '/api/api_client_package_list.php?request=client_package_list';
  static String get packageInvoiceListing =>
      '/api/api_client_package_invoice_list.php?request=client_package_invoice_list';

  static String get aboutSectionInfo => '''Shaping Your Confidence
Founded by Mrs. Vandana Luthra in 1989, is a leading Wellness & Beauty services and products organisation, serving customers across 310 locations in 143 cities spanning 12 countries in South Asia, South East Asia, the Gulf Cooperation Council Region and East Africa. In over 30 years of operation, the VLCC brand has grown to become synonymous with Wellness & Beauty in Indian households and has among the largest scale and breadth of operations within the beauty and wellness services industry in India and other countries it operates in.

Guided by our motto ‘Transforming Lives’, we seek to spark self-transformation, spread happiness and imbibe every individual with wellness for life.

Over the years, we have built a strategic integrated Wellness & Beauty organization based on three pillars that consist of our core business segments:

Wellness & Beauty Services: We operate 191 Wellness Centers & Beauty Clinics across 106 cities in India and 25 in 9 other countries. Services offered include wellness, weight-management, laser, aesthetic dermatology and regular beauty salon services. VLCC is the only player in its domain whose Wellness & Weight Management programmes carry the “Recommended by Indian Medical Association (IMA)” stamp of approval. IMA is the national organisation of doctors of modern medicine, with a membership base of over 330,000 doctors
Personal Care Products: We have leveraged our exclusive consumer database, and our insight into evolving beauty and wellness needs to build and grow a diversified product portfolio in-house, and market over 118 skin-care, hair-care and body-care products as well as nutraceuticals under the VLCC Natural Sciences, VLCC Slimmer’s, VLCC Shape Up and VLCC Wellscience, BelleWave and SkinMTX, brands which are sold through over 110,000 retail store in India and to salons, spas and aesthetic dermatology clinics globally. Majority of these products are manufactured at company owned manufacturing facilities, two in India and one in Singapore.
Skill Development: We operate 94 VLCC Institutes of Beauty & Nutrition across 67 cities in India, making it one of the largest professional training academy chains in beauty and nutrition segment beauty and nutrition segment. We train over 7,300 students annually and offer entry-level as well as skill enhancement courses in multiple disciplines in the beauty and nutrition domain.
With a staff strength of over 3,000 professionals, including medical doctors, nutritionists, physiotherapists, fitness experts and cosmetologists, we estimate that in the last 5 years alone we have catered to over 10 million customers (including repeat customers).''';

  static String get termsAndConditions => '''
1. Package booked is the amount of service intended by the clients. However, service shall be provided by the company only to the extent of amount received against the invoice. The Invoice value is equal to amount received only.
2. Money once deposited is not refundable. However, it can be adjusted towards any other package after deduction of 20% of the amount paid (Post adjustment of Service already provided)
3. Token amount paid, if any, is valid only for a period of 60 days from the paid date.
4. Goods once sold will not be taken back.
5. This being computer generated invoice does not require a signature

  ''';

  static String get privacyPolicy => '''
VLCC Healthcare Limited recognizes its obligation to adhere to the best practice of integrity for its web, online visitors. We have developed our privacy practices in order to maintain the practices and also to comply with the Children's Online Privacy Practices Act.

VLCC Healthcare Limited only collects personally identifying information with your specific knowledge and agreement. To provide information such as your age or gender may also be requested and is optional.

VLCC Healthcare Limited uses this information to provide you with the service you have requested. We may also use the information to contact you about VLCC Healthcare Limited's products or services, or for your feedback. VLCC Healthcare Limited does not sell users' contact details. If you do not wish to have your information shared with us, please uncheck the box (T&C, Privacy Policy) in the form. If you do not wish to receive communications from us, simply follow the unsubscribe instructions contained within the e-mail. If you've registered on any of our group websites. We may allow access to our database by third parties that give us services, such as technical maintenance, forums andmarketing but only for the sole purpose of and necessary to provide those services. We may also provide your information to our marketing partners or advertisers, so that they can serve ads to you that meet your needs or match your interests. VLCC Healthcare Limited does not bear any responsibility for any actions or policies of third parties. There may also be occasion when we are legally required to provide access to our database in order to cooperate with government investigations agencies or other legal proceedings. For such instances, the information provided is for that purpose only.

Our website uses cookies to control the ads display, track your usage patterns on our site, to deliver custom content, and to record account registration. Our cookies may contain personally identifiable information and such cookies may be shared with our group companies.

Your Computer's Internet Protocol ("IP") address is associated with the machine from which you are surfing the Internet, it given to each device by the internet service provider (ISP). Your ISP keeps a record of the device which is using their service, they have the subscriber's name, subscriber's billing address, & service address. Subscriber's phone number, mobile phone and email id, etc. Date & time range of when a particular IP address was assigned to the subscriber's device. User's hardware details (modem etc). It is against privacy laws.

ISP are obligated to provide this information to Law Enforcement Agencies (Police, CBI etc) for any given investigations of frauds, hacking, online crimes, threats to the society and to prevent loss of a life.

Every ISP has their own procedure to provide this information to government investigating agencies. We or our partners may record and use your IP address to collect information about the device in use and to keep a check on lead authenticity, user demographic information.

We might provide links to external websites of our group companies whose content we believe might be of interest to our visitors. Before using our group websites, we recommend that you may review their terms & conditions and privacy policies.

At times, if required it may be necessary for us to change the terms of the Online Privacy Policy. To ensure that you are aware of current privacy practices, we recommend that you check our site from time to time.

  ''';

  static String get packageInvoiceDetailsListingResponse => json.encode({
        "Status": 2000,
        "Message": "Success",
        "InvoiceDetails": [
          {
            "InvoiceId": "12",
            "CenterName": "TEST CENTER",
            "CenterCode": "INDLTEST0",
            "ClientId": "CLMC/19/00000067383",
            "ClientName": "Ramesh",
            "InvoiceNumber": "TEST00001PKG20/002003",
            "InvoiceDate": "2019-05-01",
            "InvoiceCashbackDiscount": "0",
            "InvoiceLoyaltyDiscount": "0",
            "InvoiceVoucherDiscount": "0",
            "InvoiceFPCardNumber": null,
            "InvoiceFPCDiscount": "0",
            "InvoiceTotalDiscount": "0",
            "InvoiceTotalAmountAfterDiscount": "4499",
            "InvoiceTotalPaidIncTaxAmount": "5308",
            "InvoicePackageBooingID": "1",
            "InvoicePackageBooingNumber": "PKG/20/000001",
            "InvoiceURL":
                "http://lms.vlccwellness.com/enquiry/form/print_receipta4.php?receiptid=MTI=",
            "InvoicePModeDtl": [
              {
                "InvoicePackagePaymentId": "16",
                "InvoicePackagePaymentRefNo": "",
                "InvoicePackagePaymentDate": "0000-00-00",
                "InvoicePackagePaymentBank": "",
                "InvoicePackagePaymentBankBranch": null,
                "InvoicePackagePaymentAmount": "4000",
                "InvoicePackagePaymentStatus": "Active"
              },
              {
                "InvoicePackagePaymentId": "17",
                "InvoicePackagePaymentRefNo": "23232",
                "InvoicePackagePaymentDate": "2019-05-01",
                "InvoicePackagePaymentBank": "",
                "InvoicePackagePaymentBankBranch": null,
                "InvoicePackagePaymentAmount": "1308",
                "InvoicePackagePaymentStatus": "Active"
              }
            ]
          },
          {
            "InvoiceId": "13",
            "CenterName": "TEST CENTER",
            "CenterCode": "INDLTEST0",
            "ClientId": "CLMC/19/00000067383",
            "ClientName": "Ramesh",
            "InvoiceNumber": "TEST00001PKG20/002004",
            "InvoiceDate": "2019-05-01",
            "InvoiceCashbackDiscount": "0",
            "InvoiceLoyaltyDiscount": "0",
            "InvoiceVoucherDiscount": "0",
            "InvoiceFPCardNumber": null,
            "InvoiceFPCDiscount": "0",
            "InvoiceTotalDiscount": "0",
            "InvoiceTotalAmountAfterDiscount": "1499",
            "InvoiceTotalPaidIncTaxAmount": "1768",
            "InvoicePackageBooingID": "2",
            "InvoicePackageBooingNumber": "PKG/20/000002",
            "InvoiceURL":
                "http://lms.vlccwellness.com/enquiry/form/print_receipta4.php?receiptid=MTM=",
            "InvoicePModeDtl": [
              {
                "InvoicePackagePaymentId": "18",
                "InvoicePackagePaymentRefNo": "",
                "InvoicePackagePaymentDate": "0000-00-00",
                "InvoicePackagePaymentBank": "",
                "InvoicePackagePaymentBankBranch": null,
                "InvoicePackagePaymentAmount": "1768",
                "InvoicePackagePaymentStatus": "Active"
              }
            ]
          }
        ]
      });

  static String get packageListingModelResponse => json.encode({
        "Status": 2000,
        "Message": "Success",
        "PackageDetails": [
          {
            "BookingId": "1",
            "CenterName": "TEST CENTER",
            "CenterCode": "TEST00001",
            "ClientId": "CLMC/19/00000067383",
            "BookingNumber": "PKG/20/000001",
            "BookingDate": "2019-09-21",
            "BookingExpiryDate": "0000-00-00",
            "BookingQty": "4",
            "BookingAmount": "9396",
            "BookingDiscountAmount": "119.96",
            "BookingAmountAfterDiscount": "9276.04",
            "BookingTaxAmount": "1669.69",
            "BookingTotalAmount": "10945.7",
            "BookingTotalPaidIncTaxAmount": "10946",
            "BookingTotalPaidExcTaxAmount": "9276.27",
            "BookingTotalBalExcTaxAmount": "0",
            "BookingUnexecutedAmount": "6277.27",
            "BookingExecutedAmount": "2999",
            "PackageItemDtl": [
              {
                "booking_item_id": "1",
                "ServiceName": " Full Body Polish",
                "ServiceCode": "SRV000410",
                "ServiceQty": "2",
                "ServiceFinalAmt": "5878.04",
                "ServicePaidQty": "1",
                "ServiceLeftQty": 1
              },
              {
                "booking_item_id": "2",
                "ServiceName": " Aroma Body Massage",
                "ServiceCode": "SRV000387",
                "ServiceQty": "2",
                "ServiceFinalAmt": "3398",
                "ServicePaidQty": "2",
                "ServiceLeftQty": 2
              }
            ]
          },
          {
            "BookingId": "2",
            "CenterName": "TEST CENTER",
            "CenterCode": "TEST00001",
            "ClientId": "CLMC/19/00000067383",
            "BookingNumber": "PKG/20/000002",
            "BookingDate": "2019-09-21",
            "BookingExpiryDate": "0000-00-00",
            "BookingQty": "2",
            "BookingAmount": "5699",
            "BookingDiscountAmount": "0",
            "BookingAmountAfterDiscount": "5699",
            "BookingTaxAmount": "1025.82",
            "BookingTotalAmount": "6724.82",
            "BookingTotalPaidIncTaxAmount": "6725",
            "BookingTotalPaidExcTaxAmount": "5699.15",
            "BookingTotalBalExcTaxAmount": "0",
            "BookingUnexecutedAmount": "5699.15",
            "BookingExecutedAmount": "0",
            "PackageItemDtl": [
              {
                "booking_item_id": "3",
                "ServiceName": " AC Facial",
                "ServiceCode": "SRV0001548",
                "ServiceQty": "1",
                "ServiceFinalAmt": "2700",
                "ServicePaidQty": "1",
                "ServiceLeftQty": 1
              },
              {
                "booking_item_id": "4",
                "ServiceName": " Full Body Polish",
                "ServiceCode": "SRV000410",
                "ServiceQty": "1",
                "ServiceFinalAmt": "2999",
                "ServicePaidQty": "1",
                "ServiceLeftQty": 0
              }
            ]
          },
          {
            "BookingId": "902393",
            "CenterName": "TEST CENTER",
            "CenterCode": "TEST00001",
            "ClientId": "CLMC/19/00000067383",
            "BookingNumber": "TEST00001PKG/21/000006",
            "BookingDate": "2020-12-16",
            "BookingExpiryDate": "2020-12-16",
            "BookingQty": "1",
            "BookingAmount": "50000",
            "BookingDiscountAmount": "0",
            "BookingAmountAfterDiscount": "50000",
            "BookingTaxAmount": "9000",
            "BookingTotalAmount": "59000",
            "BookingTotalPaidIncTaxAmount": "0",
            "BookingTotalPaidExcTaxAmount": "0",
            "BookingTotalBalExcTaxAmount": "50000",
            "BookingUnexecutedAmount": "0",
            "BookingExecutedAmount": "0",
            "PackageItemDtl": [
              {
                "booking_item_id": "1806688",
                "ServiceName": " VLCC FEMINA MISS INDIA DIVA GOLD CARD-50K",
                "ServiceCode": "SRV0002022",
                "ServiceQty": "1",
                "ServiceFinalAmt": "50000",
                "ServicePaidQty": "1",
                "ServiceLeftQty": 1
              }
            ]
          },
          {
            "BookingId": "942890",
            "CenterName": "TEST CENTER",
            "CenterCode": "INDLTEST0",
            "ClientId": "CLMC/19/00000067383",
            "BookingNumber": "INDLTEST0PKG/22/000008",
            "BookingDate": "2021-09-02",
            "BookingExpiryDate": "2021-09-12",
            "BookingQty": "10",
            "BookingAmount": "15990",
            "BookingDiscountAmount": "0",
            "BookingAmountAfterDiscount": "15990",
            "BookingTaxAmount": "2878.2",
            "BookingTotalAmount": "18868.2",
            "BookingTotalPaidIncTaxAmount": "15094",
            "BookingTotalPaidExcTaxAmount": "12791.5",
            "BookingTotalBalExcTaxAmount": "0",
            "BookingUnexecutedAmount": "12791.5",
            "BookingExecutedAmount": "0",
            "PackageItemDtl": [
              {
                "booking_item_id": "1880962",
                "ServiceName": " Moroccan Oil Treatment   Short Hair ",
                "ServiceCode": "SRV0001595",
                "ServiceQty": "10",
                "ServiceFinalAmt": "15990",
                "ServicePaidQty": "10",
                "ServiceLeftQty": 10
              }
            ]
          },
          {
            "BookingId": "942894",
            "CenterName": "TEST CENTER",
            "CenterCode": "INDLTEST0",
            "ClientId": "CLMC/19/00000067383",
            "BookingNumber": "INDLTEST0PKG/22/000009",
            "BookingDate": "2021-09-02",
            "BookingExpiryDate": "2022-06-29",
            "BookingQty": "1",
            "BookingAmount": "50000",
            "BookingDiscountAmount": "0",
            "BookingAmountAfterDiscount": "50000",
            "BookingTaxAmount": "9000",
            "BookingTotalAmount": "59000",
            "BookingTotalPaidIncTaxAmount": "59000",
            "BookingTotalPaidExcTaxAmount": "50000",
            "BookingTotalBalExcTaxAmount": "0",
            "BookingUnexecutedAmount": "50000",
            "BookingExecutedAmount": "0",
            "PackageItemDtl": [
              {
                "booking_item_id": "1880966",
                "ServiceName": " Perfect 10 Diva Slimming Gold Card",
                "ServiceCode": "SRV0002029",
                "ServiceQty": "1",
                "ServiceFinalAmt": "50000",
                "ServicePaidQty": "1",
                "ServiceLeftQty": 1
              }
            ]
          },
          {
            "BookingId": "942896",
            "CenterName": "TEST CENTER",
            "CenterCode": "INDLTEST0",
            "ClientId": "CLMC/19/00000067383",
            "BookingNumber": "INDLTEST0PKG/22/000010",
            "BookingDate": "2021-09-02",
            "BookingExpiryDate": "2021-09-14",
            "BookingQty": "3",
            "BookingAmount": "5397",
            "BookingDiscountAmount": "0",
            "BookingAmountAfterDiscount": "5397",
            "BookingTaxAmount": "0",
            "BookingTotalAmount": "6368.46",
            "BookingTotalPaidIncTaxAmount": "0",
            "BookingTotalPaidExcTaxAmount": "5397",
            "BookingTotalBalExcTaxAmount": "0",
            "BookingUnexecutedAmount": "5397",
            "BookingExecutedAmount": "0",
            "PackageItemDtl": [
              {
                "booking_item_id": "1880968",
                "ServiceName": " TUMMY TRIM",
                "ServiceCode": "SRV000062",
                "ServiceQty": "3",
                "ServiceFinalAmt": "5397",
                "ServicePaidQty": "3",
                "ServiceLeftQty": 3
              }
            ]
          }
        ]
      });
}
