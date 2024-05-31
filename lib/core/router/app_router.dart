import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab/core/router/app_routes.dart';
import 'package:maktab/core/services/service_locator.dart';
import 'package:maktab/data/models/coupon/coupon_model.dart';
import 'package:maktab/data/models/offer/offer_model.dart';
import 'package:maktab/data/models/office/office_model.dart';
import 'package:maktab/domain/coupon/coupon_bloc.dart';
import 'package:maktab/domain/offer/offer_bloc.dart';
import 'package:maktab/domain/office/office_bloc.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/account_summary/screens/account_summary_screen.dart';
import 'package:maktab/presentation/auth/screens/login_screen.dart';
import 'package:maktab/presentation/auth/screens/verify_code_screen.dart';
import 'package:maktab/presentation/calendar/screens/calendar_screen.dart';
import 'package:maktab/presentation/calendar/screens/unit_calendar_screen.dart';
import 'package:maktab/presentation/more/screens/contact_us_screen.dart';
import 'package:maktab/presentation/contracts/screens/contracts_samples_screen.dart';
import 'package:maktab/presentation/contracts/screens/contracts_screen.dart';
import 'package:maktab/presentation/contracts/screens/specific_contracts_screen.dart';
import 'package:maktab/presentation/coupon/screens/create_coupon_screen.dart';
import 'package:maktab/presentation/error/screens/error_screen.dart';
import 'package:maktab/presentation/money_transfers/screens/money_transfers_screen.dart';
import 'package:maktab/presentation/offer/screens/create_offer_screen.dart';
import 'package:maktab/presentation/office/screens/create_office_screen.dart';
import 'package:maktab/presentation/office/screens/create_unit_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_category_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_comforts_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_deposit_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_description_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_details.dart';
import 'package:maktab/presentation/office/screens/update_unit_facilities_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_features_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_files_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_info_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_prices_screen.dart';
import 'package:maktab/presentation/office/screens/update_unit_services_screen.dart';
import 'package:maktab/presentation/offices/screens/marketing_requests_screen.dart';
import 'package:maktab/presentation/offices/screens/unit_details_screen.dart';
import 'package:maktab/presentation/office/screens/update_office_info_screen.dart';
import 'package:maktab/presentation/office/screens/update_office_location_screen.dart';
import 'package:maktab/presentation/prices/screens/basic_prices_screen.dart';
import 'package:maktab/presentation/prices/screens/couponS_screen.dart';
import 'package:maktab/presentation/prices/screens/deposit_screen.dart';
import 'package:maktab/presentation/prices/screens/offer_prices_screen.dart';
import 'package:maktab/presentation/prices/screens/unit_coupons_screen.dart';
import 'package:maktab/presentation/prices/screens/unit_offers_screen.dart';
import 'package:maktab/presentation/receiving_method/screens/receiving_method_screen.dart';
import 'package:maktab/presentation/financial_transactions/screens/financial_transactions_screen.dart';
import 'package:maktab/presentation/home/screens/home_screen.dart';
import 'package:maktab/presentation/intro/screens/intro_screen.dart';
import 'package:maktab/presentation/invoices_and_statements/screens/invoices_and_statements_screen.dart';
import 'package:maktab/presentation/more/screens/more_screen.dart';
import 'package:maktab/presentation/offices/screens/office_screen.dart';
import 'package:maktab/presentation/offices/screens/offices_screen.dart';
import 'package:maktab/presentation/order/screens/order_screen.dart';
import 'package:maktab/presentation/orders/screens/orders_screen.dart';
import 'package:maktab/presentation/prices/screens/prices_screen.dart';
import 'package:maktab/presentation/profile/screens/edit_profile_screen.dart';
import 'package:maktab/presentation/invoices_and_statements/screens/monthly_account_statement_screen.dart';
import 'package:maktab/presentation/receiving_method/screens/bank_payment_screen.dart';
import 'package:maktab/presentation/receiving_method/screens/stc_pay_activate_screen.dart';
import 'package:maktab/presentation/receiving_method/screens/stc_pay_policy_screen.dart';
import 'package:maktab/presentation/complaints/screens/complaints_screen.dart';
import 'package:maktab/presentation/splash/screens/splash_screen.dart';
import 'package:maktab/presentation/more/screens/user_agreement_screen.dart';
import 'package:maktab/presentation/verify_national_access/screens/verify_national_access_screen.dart';
import '../../presentation/more/screens/unit_settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      name: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.introScreen,
      name: AppRoutes.introScreen,
      builder: (context, state) => const IntroScreen(),
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      name: AppRoutes.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyCodeScreen,
      name: AppRoutes.verifyCodeScreen,
      builder: (context, state) => const VerifyCodeScreen(),
    ),
    GoRoute(
        path: AppRoutes.stcPayActivateScreen,
        name: AppRoutes.stcPayActivateScreen,
        builder: (context, state) => const StcPayActivateScreen()),
    GoRoute(
      path: AppRoutes.unitSettingsScreen,
      name: AppRoutes.unitSettingsScreen,
      builder: (context, state) => const UnitSettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      name: AppRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.calendarScreen,
      name: AppRoutes.calendarScreen,
      builder: (context, state) => const CalendarScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.unitCalendarScreen,
          name: AppRoutes.unitCalendarScreen,
          builder: (context, state) {
            int officeID = (state.extra as Map)['officeID'] as int;
            int unitID = (state.extra as Map)['unitID'] as int;
            return UnitCalendarScreen(unitId: unitID, officeId: officeID,);
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.ordersScreen,
      name: AppRoutes.ordersScreen,
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      path: AppRoutes.orderScreen,
      name: AppRoutes.orderScreen,
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: AppRoutes.officesScreen,
      name: AppRoutes.officesScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => locator.get<OfficeBloc>(),
        child: const OfficesScreen(),
      ),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.marketingRequestsScreen,
          name: AppRoutes.marketingRequestsScreen,
          builder: (context, state) {
            return const MarketingRequestsScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.updateOfficeLoctionScreen,
          name: AppRoutes.updateOfficeLoctionScreen,
          builder: (context, state) {
            Office? office = state.extra as Office;
            return BlocProvider(
              create: (context) => locator.get<OfficeBloc>(),
              child: UpdateOfficeLocationScreen(office: office),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.updateOfficeInfoScreen,
          name: AppRoutes.updateOfficeInfoScreen,
          builder: (context, state) {
            Office? office = state.extra as Office;
            return BlocProvider(
              create: (context) => locator.get<OfficeBloc>(),
              child: UpdateOfficeInfoScreen(office: office),
            );
          },
        ),
        GoRoute(
          path: AppRoutes.unitDetailsScreen,
          name: AppRoutes.unitDetailsScreen,
          builder: (context, state) {
            Office office = state.extra as Office;
            return BlocProvider(
              create: (context) => locator.get<UnitBloc>(),
              child: UnitDetailsScreen(office: office),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.updateUnitInfoScreen,
              name: AppRoutes.updateUnitInfoScreen,
              builder: (context, state) {
                Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitInfoScreen(
                    unit: data['unit'],
                    office: data['office'],
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitCategoryScreen,
              name: AppRoutes.updateUnitCategoryScreen,
              builder: (context, state) {
                Map<String, dynamic> data = state.extra as Map<String, dynamic>;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitCategoryScreen(
                    unit: data['unit'],
                    office: data['office'],
                  ),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitDetailsScreen,
              name: AppRoutes.updateUnitDetailsScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitDetailsScreen(unit: unit),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitDescriptionScreen,
              name: AppRoutes.updateUnitDescriptionScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitDescriptionScreen(unit: unit),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitFacilitiesScreen,
              name: AppRoutes.updateUnitFacilitiesScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitFacilitiesScreen(unit: unit),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitFeaturesScreen,
              name: AppRoutes.updateUnitFeaturesScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitFeaturesScreen(unit: unit),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitComfortsScreen,
              name: AppRoutes.updateUnitComfortsScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitComfortsScreen(unit: unit),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitServicesScreen,
              name: AppRoutes.updateUnitServicesScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitServicesScreen(unit: unit),
                );
              },
            ),
            GoRoute(
              path: AppRoutes.updateUnitFilesScreen,
              name: AppRoutes.updateUnitFilesScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitFilesScreen(unit: unit),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.moreScreen,
      name: AppRoutes.moreScreen,
      builder: (context, state) => const MoreScreen(),
    ),
    GoRoute(
      path: AppRoutes.editProfileScreen,
      name: AppRoutes.editProfileScreen,
      builder: (context, state) {
        bool? fromHome = state.extra as bool?;
        return EditProfileScreen(
          fromHome: fromHome ?? false,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.invoicesAndStatementsScreen,
      name: AppRoutes.invoicesAndStatementsScreen,
      builder: (context, state) => const InvoicesAndStatementsScreen(),
    ),
    GoRoute(
      path: AppRoutes.monthlyAccountStatementScreen,
      name: AppRoutes.monthlyAccountStatementScreen,
      builder: (context, state) => const MonthlyAccountStatementScreen(),
    ),
    GoRoute(
      path: AppRoutes.userAgreementScreen,
      name: AppRoutes.userAgreementScreen,
      builder: (context, state) => const UserAgreementScreen(),
    ),
    GoRoute(
      path: AppRoutes.contactUsScreen,
      name: AppRoutes.contactUsScreen,
      builder: (context, state) => const ContactUsScreen(),
    ),
    GoRoute(
      path: AppRoutes.accountSummaryScreen,
      name: AppRoutes.accountSummaryScreen,
      builder: (context, state) => const AccountSummaryScreen(),
    ),
    GoRoute(
        path: AppRoutes.contractsScreen,
        name: AppRoutes.contractsScreen,
        builder: (context, state) => const ContractsScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.contractsSamplesScreen,
            name: AppRoutes.contractsSamplesScreen,
            builder: (context, state) => const ContractsSamplesScreen(),
          ),
          GoRoute(
            path: AppRoutes.specificContractsScreen,
            name: AppRoutes.specificContractsScreen,
            builder: (context, state) => const SpecificContractsScreen(),
          ),
        ]),
    GoRoute(
      path: AppRoutes.financialTransactionScreen,
      name: AppRoutes.financialTransactionScreen,
      builder: (context, state) => const FinincialTransactionsScreen(),
    ),
    GoRoute(
      path: AppRoutes.receivingMethodScreen,
      name: AppRoutes.receivingMethodScreen,
      builder: (context, state) => const ReceivingMethodScreen(),
    ),
    GoRoute(
      path: AppRoutes.stcPayPolicyScreen,
      name: AppRoutes.stcPayPolicyScreen,
      builder: (context, state) => const StcPayPolicyScreen(),
    ),
    GoRoute(
      path: AppRoutes.bankPaymentScreen,
      name: AppRoutes.bankPaymentScreen,
      builder: (context, state) => const BankPaymentScreen(),
    ),
    GoRoute(
      path: AppRoutes.moneyTransfersScreen,
      name: AppRoutes.moneyTransfersScreen,
      builder: (context, state) => const MoneyTransfersScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyAccountWithNationalAccess,
      name: AppRoutes.verifyAccountWithNationalAccess,
      builder: (context, state) => const VerifyNationalAccessScreen(),
    ),
    GoRoute(
      path: AppRoutes.pricesScreen,
      name: AppRoutes.pricesScreen,
      builder: (context, state) => PricesScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.basicPricesScreen,
          name: AppRoutes.basicPricesScreen,
          builder: (context, state) => const BasicPricesScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.updateUnitPricesScreen,
              name: AppRoutes.updateUnitPricesScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitPricesScreen(unit: unit),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.offerPricesScreen,
          name: AppRoutes.offerPricesScreen,
          builder: (context, state) => const OfferPricesScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.unitOffersScreen,
              name: AppRoutes.unitOffersScreen,
              builder: (context, state) {
                return const UnitOffersScreen();
              },
            ),
            GoRoute(
              path: AppRoutes.createOfferScreen,
              name: AppRoutes.createOfferScreen,
              builder: (context, state) {
                Map<String, dynamic>? data =
                    state.extra as Map<String, dynamic>?;
                Offer? offer = data != null ? data['offer'] : null;
                Office? unit = data != null ? data['unit'] : null;
                return BlocProvider(
                  create: (context) => locator.get<OfferBloc>()
                    ..add(InitialOfferEvent(offer, unit)),
                  child: CreateOfferScreen(offer: offer, unit: unit),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.depositScreen,
          name: AppRoutes.depositScreen,
          builder: (context, state) => const DepositScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.updateUnitDepositScreen,
              name: AppRoutes.updateUnitDepositScreen,
              builder: (context, state) {
                Office unit = state.extra as Office;
                return BlocProvider(
                  create: (context) => locator.get<UnitBloc>(),
                  child: UpdateUnitDepositScreen(unit: unit),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.couponsScreen,
          name: AppRoutes.couponsScreen,
          builder: (context, state) => const CouponsScreen(),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.unitCouponsScreen,
              name: AppRoutes.unitCouponsScreen,
              builder: (context, state) {
                return const UnitCouponsScreen();
              },
            ),
            GoRoute(
              path: AppRoutes.createCouponScreen,
              name: AppRoutes.createCouponScreen,
              builder: (context, state) {
                Map<String, dynamic>? data =
                state.extra as Map<String, dynamic>?;
                Coupon? coupon = data != null ? data['coupon'] : null;
                Office? unit = data != null ? data['unit'] : null;
                return BlocProvider(
                  create: (context) => locator.get<CouponBloc>()
                    ..add(InitialCouponEvent(coupon, unit)),
                  child: CreateCouponScreen(coupon: coupon, unit: unit),
                );

              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.complaintsScreen,
      name: AppRoutes.complaintsScreen,
      builder: (context, state) => const ComplaintsScreen(),
    ),
    GoRoute(
      path: AppRoutes.officeScreen,
      name: AppRoutes.officeScreen,
      builder: (context, state) => const OfficeScreen(),
    ),
    GoRoute(
      path: AppRoutes.createOfficeScreen,
      name: AppRoutes.createOfficeScreen,
      builder: (context, state) {
        Office? office = state.extra as Office?;
        return CreateOfficeScreen(office: office);
      },
    ),
    GoRoute(
      path: AppRoutes.createUnitScreen,
      name: AppRoutes.createUnitScreen,
      builder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return CreateUnitScreen(
          unit: data['unit'],
          office: data['office'],
        );
      },
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error!),
);
