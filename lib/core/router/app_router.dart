import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maktab_lessor/core/router/app_routes.dart';
import 'package:maktab_lessor/core/services/service_locator.dart';
import 'package:maktab_lessor/data/models/coupon/coupon_model.dart';
import 'package:maktab_lessor/data/models/offer/offer_model.dart';
import 'package:maktab_lessor/data/models/office/office_model.dart';
import 'package:maktab_lessor/domain/coupon/coupon_bloc.dart';
import 'package:maktab_lessor/domain/offer/offer_bloc.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/domain/unit/unit_bloc.dart';
import 'package:maktab_lessor/presentation/auth/screens/login_screen.dart';
import 'package:maktab_lessor/presentation/auth/screens/verify_code_screen.dart';
import 'package:maktab_lessor/presentation/calendar/screens/calendar_screen.dart';
import 'package:maktab_lessor/presentation/calendar/screens/unit_calendar_screen.dart';
import 'package:maktab_lessor/presentation/invoices/screens/invoices_screen.dart';
import 'package:maktab_lessor/presentation/more/screens/contact_us_screen.dart';
import 'package:maktab_lessor/presentation/coupon/screens/create_coupon_screen.dart';
import 'package:maktab_lessor/presentation/error/screens/error_screen.dart';
import 'package:maktab_lessor/presentation/money_transfers/screens/money_transfers_screen.dart';
import 'package:maktab_lessor/presentation/offer/screens/create_offer_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/create_office_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/create_unit_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_category_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_comforts_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_deposit_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_description_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_details.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_facilities_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_features_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_files_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_info_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_prices_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_unit_services_screen.dart';
import 'package:maktab_lessor/presentation/offices/screens/marketing_requests_screen.dart';
import 'package:maktab_lessor/presentation/offices/screens/unit_details_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_office_info_screen.dart';
import 'package:maktab_lessor/presentation/office/screens/update_office_location_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/basic_prices_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/couponS_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/deposit_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/offer_prices_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/unit_coupons_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/unit_offers_screen.dart';
import 'package:maktab_lessor/presentation/receiving_method/screens/receiving_method_screen.dart';
import 'package:maktab_lessor/presentation/financial_transactions/screens/financial_transactions_screen.dart';
import 'package:maktab_lessor/presentation/home/screens/home_screen.dart';
import 'package:maktab_lessor/presentation/intro/screens/intro_screen.dart';
import 'package:maktab_lessor/presentation/more/screens/more_screen.dart';
import 'package:maktab_lessor/presentation/offices/screens/office_screen.dart';
import 'package:maktab_lessor/presentation/offices/screens/offices_screen.dart';
import 'package:maktab_lessor/presentation/order/screens/order_screen.dart';
import 'package:maktab_lessor/presentation/orders/screens/orders_screen.dart';
import 'package:maktab_lessor/presentation/prices/screens/prices_screen.dart';
import 'package:maktab_lessor/presentation/profile/screens/edit_profile_screen.dart';
import 'package:maktab_lessor/presentation/invoices_and_statements/screens/monthly_account_statement_screen.dart';
import 'package:maktab_lessor/presentation/receiving_method/screens/bank_payment_screen.dart';
import 'package:maktab_lessor/presentation/receiving_method/screens/stc_pay_activate_screen.dart';
import 'package:maktab_lessor/presentation/receiving_method/screens/stc_pay_policy_screen.dart';
import 'package:maktab_lessor/presentation/complaints/screens/complaints_screen.dart';
import 'package:maktab_lessor/presentation/splash/screens/splash_screen.dart';
import 'package:maktab_lessor/presentation/more/screens/user_agreement_screen.dart';
import 'package:maktab_lessor/presentation/verify_national_access/screens/verify_national_access_screen.dart';
import '../../data/models/order/order_model.dart';
import '../../domain/navigation/navigation_bloc.dart';
import '../../domain/navigation/navigation_event.dart';
import '../../presentation/account_summary/screens/account_summary_screen.dart';
import '../../presentation/contracts_menu/contracts_menu_screen.dart';
import '../../presentation/contracts_menu/screens/contracts/screens/contract/screens/add/screens/add_contract_screen.dart';
import '../../presentation/contracts_menu/screens/contracts/screens/contract/screens/contract_screen.dart';
import '../../presentation/contracts_menu/screens/contracts/screens/contracts_screen.dart';
import '../../presentation/contracts_menu/screens/contracts_models/screens/add_contracts_model/screens/add_contracts_model_screen.dart';
import '../../presentation/contracts_menu/screens/contracts_models/screens/contracts_model/screens/contracts_model_screen.dart';
import '../../presentation/contracts_menu/screens/contracts_models/screens/contracts_models_screen.dart';
import '../../presentation/contracts_menu/screens/contracts_models/screens/edit_contracts_model/screens/edit_contracts_model_screen.dart';
import '../../presentation/evaluation/screens/evaluation_screen.dart';
import '../../presentation/more/screens/unit_settings_screen.dart';
import '../../presentation/notifications/screens/notifications_screen.dart';

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
      pageBuilder: (context, state) => _pageBuilder(context, state, const IntroScreen(), slideType: SlideType.toTop),
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      name: AppRoutes.loginScreen,
      pageBuilder: (context, state) => _pageBuilder(context, state, LoginScreen(), slideType: SlideType.toRight),
    ),
    GoRoute(
      path: AppRoutes.verifyCodeScreen,
      name: AppRoutes.verifyCodeScreen,
      pageBuilder: (context, state) => _pageBuilder(context, state, const VerifyCodeScreen(), slideType: SlideType.toRight),
    ),
    GoRoute(
      path: AppRoutes.stcPayActivateScreen,
      name: AppRoutes.stcPayActivateScreen,
      pageBuilder: (context, state) => _pageBuilder(context, state, const StcPayActivateScreen(), slideType: SlideType.toTop),
    ),
    GoRoute(
      path: AppRoutes.unitSettingsScreen,
      name: AppRoutes.unitSettingsScreen,
      pageBuilder: (context, state) => _pageBuilder(context, state, const UnitSettingsScreen()),
    ),
    GoRoute(
      path: AppRoutes.homeScreen,
      name: AppRoutes.homeScreen,
      pageBuilder: (context, state) {
        context.read<NavigationBloc>().add(HomeNavigationEvent());
        return _pageBuilder(context, state, const HomeScreen(), slideType: SlideType.none);
      },
      routes: [
        GoRoute(
          path: AppRoutes.notificationsScreen,
          name: AppRoutes.notificationsScreen,
          builder: (context, state) => const NotificationsScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.calendarScreen,
      name: AppRoutes.calendarScreen,
      // builder: (context, state) => const CalendarScreen(),
      pageBuilder: (context, state) {
        return _pageBuilder(context, state, const CalendarScreen());
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.unitCalendarScreen,
          name: AppRoutes.unitCalendarScreen,
          pageBuilder: (context, state) {
            int officeID = (state.extra as Map)['officeID'] as int;
            int unitID = (state.extra as Map)['unitID'] as int;
            return _pageBuilder(
                context,
                state,
                UnitCalendarScreen(
                  unitId: unitID,
                  officeId: officeID,
                ));
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.ordersScreen,
      name: AppRoutes.ordersScreen,
      // builder: (context, state) => const OrdersScreen(),
      pageBuilder: (context, state) {
        context.read<NavigationBloc>().add(OrdersNavigationEvent());
        return _pageBuilder(context, state, const OrdersScreen(), slideType: SlideType.none);
      },
    ),
    GoRoute(
      path: AppRoutes.orderScreen,
      name: AppRoutes.orderScreen,
      builder: (context, state) => const OrderScreen(),
    ),
    GoRoute(
      path: AppRoutes.officesScreen,
      name: AppRoutes.officesScreen,
      pageBuilder: (context, state) {
        context.read<NavigationBloc>().add(OfficesNavigationEvent());
        return _pageBuilder(
            context,
            state,
            BlocProvider(
              create: (context) => locator.get<OfficeBloc>(),
              child: const OfficesScreen(),
            ),
            slideType: SlideType.none);
      },
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
      // builder: (context, state) => const MoreScreen(),
      pageBuilder: (context, state) {
        context.read<NavigationBloc>().add(MoreNavigationEvent());
        return _pageBuilder(context, state, const MoreScreen(), slideType: SlideType.none);
      },
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
      pageBuilder: (context, state) {
        bool? fromHome = state.extra as bool?;
        return _pageBuilder(
          context,
          state,
          EditProfileScreen(
            fromHome: fromHome ?? false,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.invoicesAndStatementsScreen,
      name: AppRoutes.invoicesAndStatementsScreen,
      // builder: (context, state) => const InvoicesAndStatementsScreen(),
      // builder: (context, state) => const InvoicesScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const InvoicesScreen()),
    ),
    GoRoute(
      path: AppRoutes.monthlyAccountStatementScreen,
      name: AppRoutes.monthlyAccountStatementScreen,
      // builder: (context, state) => const MonthlyAccountStatementScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const MonthlyAccountStatementScreen()),
    ),
    GoRoute(
      path: AppRoutes.userAgreementScreen,
      name: AppRoutes.userAgreementScreen,
      // builder: (context, state) => const UserAgreementScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const UserAgreementScreen()),
    ),
    GoRoute(
      path: AppRoutes.contactUsScreen,
      name: AppRoutes.contactUsScreen,
      // builder: (context, state) => const ContactUsScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const ContactUsScreen()),
    ),
    GoRoute(
      path: AppRoutes.accountSummaryScreen,
      name: AppRoutes.accountSummaryScreen,
      // builder: (context, state) => const AccountStatementsScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const AccountStatementsScreen()),
    ),
    GoRoute(
      path: AppRoutes.contractsMenuScreen,
      name: AppRoutes.contractsMenuScreen,
      // builder: (context, state) => const ContractsMenuScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const ContractsMenuScreen()),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.contractsModelsScreen,
          name: AppRoutes.contractsModelsScreen,
          // builder: (context, state) => const ContractsModelsScreen(),
          pageBuilder: (context, state) => _pageBuilder(context, state, const ContractsModelsScreen()),
          routes: [
            GoRoute(
              path: AppRoutes.contractsModelScreen,
              name: AppRoutes.contractsModelScreen,
              // builder: (context, state) => const ContractsModelScreen(),
              pageBuilder: (context, state) => _pageBuilder(context, state, const ContractsModelScreen()),
            ),
            GoRoute(
              path: AppRoutes.editContractsModelScreen,
              name: AppRoutes.editContractsModelScreen,
              // builder: (context, state) => const EditContractsModelScreen(),
              pageBuilder: (context, state) => _pageBuilder(context, state, const EditContractsModelScreen()),
            ),
            GoRoute(
              path: AppRoutes.addContractsModelScreen,
              name: AppRoutes.addContractsModelScreen,
              // builder: (context, state) => AddContractsModelScreen(),
              pageBuilder: (context, state) => _pageBuilder(context, state, AddContractsModelScreen()),
            ),
          ],
        ),
        GoRoute(
            path: AppRoutes.contractsScreen,
            name: AppRoutes.contractsScreen,
            // builder: (context, state) => const ContractsScreen(),
            pageBuilder: (context, state) => _pageBuilder(context, state, const ContractsScreen()),
            routes: [
              GoRoute(
                path: AppRoutes.contractScreen,
                name: AppRoutes.contractScreen,
                builder: (context, state) => ContractScreen(
                  cancelContract: (state.extra as bool?) ?? false,
                ),
                pageBuilder: (context, state) {
                  return _pageBuilder(
                      context,
                      state,
                      ContractScreen(
                        cancelContract: (state.extra as bool?) ?? false,
                      ));
                },
              ),
              GoRoute(
                path: AppRoutes.addContractScreen,
                name: AppRoutes.addContractScreen,
                // builder: (context, state) => const AddContractScreen(),
                pageBuilder: (context, state) =>
                    _pageBuilder(context, state, AddContractScreen(order: state.extra as OrderModel?)),
              ),
            ]),
      ],
    ),
    GoRoute(
      path: AppRoutes.financialTransactionScreen,
      name: AppRoutes.financialTransactionScreen,
      // builder: (context, state) => const FinincialTransactionsScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const FinincialTransactionsScreen()),
    ),
    GoRoute(
      path: AppRoutes.receivingMethodScreen,
      name: AppRoutes.receivingMethodScreen,
      // builder: (context, state) => const ReceivingMethodScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const ReceivingMethodScreen()),
    ),
    GoRoute(
      path: AppRoutes.stcPayPolicyScreen,
      name: AppRoutes.stcPayPolicyScreen,
      // builder: (context, state) => const StcPayPolicyScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const StcPayPolicyScreen()),
    ),
    GoRoute(
      path: AppRoutes.bankPaymentScreen,
      name: AppRoutes.bankPaymentScreen,
      // builder: (context, state) => const BankPaymentScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const BankPaymentScreen()),
    ),
    GoRoute(
      path: AppRoutes.moneyTransfersScreen,
      name: AppRoutes.moneyTransfersScreen,
      // builder: (context, state) => const MoneyTransfersScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const MoneyTransfersScreen()),
    ),
    GoRoute(
      path: AppRoutes.verifyAccountWithNationalAccess,
      name: AppRoutes.verifyAccountWithNationalAccess,
      // builder: (context, state) => const VerifyNationalAccessScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const VerifyNationalAccessScreen()),
    ),
    GoRoute(
      path: AppRoutes.pricesScreen,
      name: AppRoutes.pricesScreen,
      // builder: (context, state) => PricesScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, PricesScreen()),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.basicPricesScreen,
          name: AppRoutes.basicPricesScreen,
          // builder: (context, state) => const BasicPricesScreen(),
          pageBuilder: (context, state) => _pageBuilder(context, state, const BasicPricesScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.updateUnitPricesScreen,
              name: AppRoutes.updateUnitPricesScreen,
              // builder: (context, state) {
              //   Office unit = state.extra as Office;
              //   return BlocProvider(
              //     create: (context) => locator.get<UnitBloc>(),
              //     child: UpdateUnitPricesScreen(unit: unit),
              //   );
              // },
              pageBuilder: (context, state) {
                Office unit = state.extra as Office;
                return _pageBuilder(
                    context,
                    state,
                    BlocProvider(
                      create: (context) => locator.get<UnitBloc>(),
                      child: UpdateUnitPricesScreen(unit: unit),
                    ));
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.offerPricesScreen,
          name: AppRoutes.offerPricesScreen,
          // builder: (context, state) => const OfferPricesScreen(),
          pageBuilder: (context, state) => _pageBuilder(context, state, const OfferPricesScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.unitOffersScreen,
              name: AppRoutes.unitOffersScreen,
              // builder: (context, state) {
              //   return const UnitOffersScreen();
              // },
              pageBuilder: (context, state) => _pageBuilder(context, state, const UnitOffersScreen()),
            ),
            GoRoute(
              path: AppRoutes.createOfferScreen,
              name: AppRoutes.createOfferScreen,
              // builder: (context, state) {
              //   Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
              //   Offer? offer = data != null ? data['offer'] : null;
              //   Office? unit = data != null ? data['unit'] : null;
              //   return BlocProvider(
              //     create: (context) => locator.get<OfferBloc>()..add(InitialOfferEvent(offer, unit)),
              //     child: CreateOfferScreen(offer: offer, unit: unit),
              //   );
              // },
              pageBuilder: (context, state) {
                Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
                Offer? offer = data != null ? data['offer'] : null;
                Office? unit = data != null ? data['unit'] : null;
                return _pageBuilder(
                    context,
                    state,
                    BlocProvider(
                      create: (context) => locator.get<OfferBloc>()..add(InitialOfferEvent(offer, unit)),
                      child: CreateOfferScreen(offer: offer, unit: unit),
                    ));
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.depositScreen,
          name: AppRoutes.depositScreen,
          // builder: (context, state) => const DepositScreen(),
          pageBuilder: (context, state) => _pageBuilder(context, state, const DepositScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.updateUnitDepositScreen,
              name: AppRoutes.updateUnitDepositScreen,
              // builder: (context, state) {
              //   Office unit = state.extra as Office;
              //   return BlocProvider(
              //     create: (context) => locator.get<UnitBloc>(),
              //     child: UpdateUnitDepositScreen(unit: unit),
              //   );
              // },
              pageBuilder: (context, state) {
                Office unit = state.extra as Office;
                return _pageBuilder(
                    context,
                    state,
                    BlocProvider(
                      create: (context) => locator.get<UnitBloc>(),
                      child: UpdateUnitDepositScreen(unit: unit),
                    ));
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.couponsScreen,
          name: AppRoutes.couponsScreen,
          // builder: (context, state) => const CouponsScreen(),
          pageBuilder: (context, state) => _pageBuilder(context, state, const CouponsScreen()),
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.unitCouponsScreen,
              name: AppRoutes.unitCouponsScreen,
              // builder: (context, state) {
              //   return const UnitCouponsScreen();
              // },
              pageBuilder: (context, state) => _pageBuilder(context, state, const UnitCouponsScreen()),
            ),
            GoRoute(
              path: AppRoutes.createCouponScreen,
              name: AppRoutes.createCouponScreen,
              // builder: (context, state) {
              //   Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
              //   Coupon? coupon = data != null ? data['coupon'] : null;
              //   Office? unit = data != null ? data['unit'] : null;
              //   return BlocProvider(
              //     create: (context) => locator.get<CouponBloc>()..add(InitialCouponEvent(coupon, unit)),
              //     child: CreateCouponScreen(coupon: coupon, unit: unit),
              //   );
              // },
              pageBuilder: (context, state) {
                Map<String, dynamic>? data = state.extra as Map<String, dynamic>?;
                Coupon? coupon = data != null ? data['coupon'] : null;
                Office? unit = data != null ? data['unit'] : null;
                return _pageBuilder(
                    context,
                    state,
                    BlocProvider(
                      create: (context) => locator.get<CouponBloc>()..add(InitialCouponEvent(coupon, unit)),
                      child: CreateCouponScreen(coupon: coupon, unit: unit),
                    ));
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.complaintsScreen,
      name: AppRoutes.complaintsScreen,
      // builder: (context, state) => const ComplaintsScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const ComplaintsScreen()),
    ),
    GoRoute(
      path: AppRoutes.evaluationScreen,
      name: AppRoutes.evaluationScreen,
      // builder: (context, state) => const ComplaintsScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const EvaluationScreen()),
    ),
    GoRoute(
      path: AppRoutes.officeScreen,
      name: AppRoutes.officeScreen,
      // builder: (context, state) => const OfficeScreen(),
      pageBuilder: (context, state) => _pageBuilder(context, state, const OfficeScreen()),
    ),
    GoRoute(
      path: AppRoutes.createOfficeScreen,
      name: AppRoutes.createOfficeScreen,
      pageBuilder: (context, state) {
        Office? office = state.extra as Office?;
        return _pageBuilder(context, state, CreateOfficeScreen(office: office));
      },
    ),
    GoRoute(
      path: AppRoutes.createUnitScreen,
      name: AppRoutes.createUnitScreen,
      pageBuilder: (context, state) {
        Map<String, dynamic> data = state.extra as Map<String, dynamic>;
        return _pageBuilder(
            context,
            state,
            CreateUnitScreen(
              unit: data['unit'],
              office: data['office'],
            ));
      },
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error!),
);

enum SlideType { toRight, toLeft, toTop, toDown, none }

CustomTransitionPage _pageBuilder(context, state, page, {SlideType slideType = SlideType.none}) {
  return CustomTransitionPage(
    child: page,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final double beginX = switch (slideType) {
        SlideType.toRight => -1,
        SlideType.toLeft => 1,
        SlideType.toTop => 0,
        SlideType.toDown => 0,
        SlideType.none => -1,
      };
      final double beginY = switch (slideType) {
        SlideType.toRight => 0,
        SlideType.toLeft => 0,
        SlideType.toTop => 1,
        SlideType.toDown => -1,
        SlideType.none => 0,
      };
      var begin = Offset(beginX, beginY);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
