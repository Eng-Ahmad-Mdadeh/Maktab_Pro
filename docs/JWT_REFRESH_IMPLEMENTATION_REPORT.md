# تقرير تنفيذ تجديد JWT

تم تنفيذ التكامل باستخدام Dio وHive وGetIt وBloc وGoRouter، وفق بنية المشروع الحالية، دون إضافة حزم أو تعديل ملف القفل.

## الملفات المضافة

| الملف | الغرض |
| --- | --- |
| `lib/core/network/auth_interceptor.dart` | إرسال التوكن الحالي، وتجديده عند TOKEN_EXPIRED وREFRESH_TOKEN فقط، ومشاركة عملية التجديد بين الطلبات المتزامنة، وإعادة الطلب مرة واحدة مع دعم FormData والملفات. يستخدم عميل Dio منفصلًا للتجديد لمنع الحلقات. |
| `lib/core/helpers/session_helper.dart` | إشعار واجهة التطبيق بانتهاء الجلسة لإعادة إنشاء حالات Bloc المرتبطة بالشجرة. |
| `test/core/network/auth_interceptor_test.dart` | اختبارات باستخدام HttpClientAdapter وهمي تغطي النجاح والتزامن وإعادة إرسال الملفات وانتهاء الجلسة والأخطاء المؤقتة ومنع الحلقات وتغيّر الجلسة أثناء التجديد وعدم إرسال بيانات المصادقة إلى خدمات خارجية. |
| `docs/JWT_REFRESH_IMPLEMENTATION_REPORT.md` | هذا التقرير. |

## الملفات المعدّلة

| الملف | التغيير |
| --- | --- |
| `lib/core/network/api_endpoints.dart` | إضافة ثابت `auth/refresh` لحسابات الأعمال التي يستخدمها التطبيق. |
| `lib/core/network/network_helper.dart` | ربط الاعتراض والتخزين ومسح الجلسة والتنقل إلى الدخول؛ إزالة تسجيل أجسام الطلبات والتوكنات واستجابات المصادقة؛ معالجة أخطاء Dio التي لا تحتوي استجابة، وتوحيد أرقام الأخطاء النصية والعددية. |
| `lib/data/data_sources/local/user_local_data_source.dart` | تسلسل عمليات Hive، واستبدال التوكن بشرط مطابقته للتوكن القديم، وحفظ وقت الانتهاء وفق expires_in، ومسح التوكن المشروط لتجنّب تأثر جلسة جديدة برد قديم. |
| `lib/data/repositories/auth_repository.dart` | حذف طباعة التوكن، والتحقق من وجوده قبل فحص المصادقة، وعدم حذفه عند فشل فحص الملف الشخصي مؤقتًا. |
| `lib/domain/profile/profile_bloc.dart` | مسح الملف الشخصي عند انتهاء الجلسة والخروج، وتجاهل استجابة ملف شخصي تعود بعد تغيّر الجلسة. |
| `lib/domain/profile/profile_event.dart` | إضافة حدث ClearProfileEvent. |
| `lib/domain/profile/profile_state.dart` | دعم مسح user صراحة وإدراجه في مقارنة Equatable. |
| `lib/main.dart` | إعادة إنشاء الشجرة عند تغيّر الجلسة، وتوفير ProfileBloc كقيمة لأنه singleton يديره GetIt. |

## السلوك

- التطبيق خاص بحسابات الأعمال ويستخدم `/apiBack/v1/user/auth/refresh` فقط، بما يطابق مسار تسجيل دخوله. لم تُضف مسارات حسابات عادية أو مسؤولين لا يستخدمها المشروع.
- لا يوجد توكن تجديد منفصل: يُرسل access token القديم في Authorization دون جسم طلب.
- تُمسح الجلسة للأكواد الدائمة TOKEN_REVOKED وINVALID_TOKEN وTOKEN_MISSING وSESSION_EXPIRED وUNAUTHORIZED عند HTTP 401.
- أخطاء الشبكة والمهلة و5xx والاستجابة القديمة الخاطئة لمفتاح API لا تمسح الجلسة.
- يستخدم expires_in لحفظ موعد الانتهاء ولا يفترض مدة ثابتة. التجديد تفاعلي عند رد الخادم، دون مؤقت دوري.
- لا تستبدل نتيجة تجديد متأخرة جلسة أُغلقت أو تغيّر توكنها.

## التحقق والقيود

- نجح `git diff --check`.
- أُضيفت اختبارات سلوكية، لكن لم تُشغّل: أمر flutter غير متاح في البيئة. محاولة تشغيل `flutter test test/core/network/auth_interceptor_test.dart` انتهت بـ `flutter: command not found`.
- أعادت روابط بيانات إصدارات Flutter والأرشيف التي جُرّبت HTTP 404؛ لذلك لم يُثبت SDK ولم يُشغّل التحليل أو بناء التطبيق.
- لم يُختبر التكامل مع خادم فعلي أو حساب فعلي، ولا يُدّعى نجاح الاختبارات قبل تشغيلها في بيئة Flutter.

أوامر التحقق بعد توفير Flutter متوافق مع ملف القفل (Flutter >=3.32، Dart >=3.8):

```sh
flutter pub get --enforce-lockfile
flutter analyze
flutter test test/core/network/auth_interceptor_test.dart
```
