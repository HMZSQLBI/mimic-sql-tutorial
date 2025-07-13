# آموزش SQL با استفاده از دیتابیس MIMIC-III Demo

## 👨‍🏫 معرفی دوره

این دوره برای آموزش عملی SQL به کارکنان فناوری اطلاعات بیمارستان‌ها طراحی شده است. تمرین‌ها بر پایه دیتابیس دمو MIMIC-III انجام می‌شوند که شامل داده‌های ساختگی مرتبط با بیماران بستری، مراقبت‌های ویژه (ICU) و اطلاعات بالینی است.

---

## 🧬 آشنایی با دیتاست MIMIC-III

دیتابیس [MIMIC-III (Medical Information Mart for Intensive Care)](https://physionet.org/content/mimiciii-demo/1.4/) توسط MIT و Beth Israel Deaconess Medical Center توسعه یافته و شامل اطلاعات ناشناس بیماران ICU است. نسخه دمو شامل حجم محدودی از داده‌هاست و بدون نیاز به مجوز قابل استفاده می‌باشد.
https://physionet.org/content/mimiciii-demo/1.4/


---

## 📊 آشنایی با جداول مهم

در تمرین‌ها عمدتاً از جداول زیر استفاده می‌شود:

- `patients`: اطلاعات دموگرافیک بیماران
- `admissions`: اطلاعات مربوط به پذیرش بیمار
- `icustays`: سوابق بستری در ICU
- `diagnoses_icd`: تشخیص‌های بالینی (کدهای ICD9)
- `chartevents`: رویدادهای ثبت‌شده در ICU (در نسخه دمو محدود است)

---

## 🔐 روش دسترسی به دیتاست کامل

برای استفاده از دیتاست کامل MIMIC-III:

1. ثبت‌نام در سایت PhysioNet: [https://physionet.org](https://physionet.org)
2. گذراندن دوره آموزشی "Protecting Human Research Participants"
3. ارسال درخواست و امضای توافق‌نامه
4. پس از تأیید، می‌توانید فایل‌های کامل دیتاست را دانلود کنید.

   در این ویدیو میتوانید مراحل دسترسی به داده های اصلی را ببینید: 
https://youtu.be/JdQmmj2-pw0

---

## 🗃️ روش انتقال داده‌ها به SQL Server

1. استفاده از ابزار `pgAdmin` برای Export دیتای دمو از PostgreSQL به فایل `.csv`
2. استفاده از `SQL Server Management Studio` یا `SSIS` برای وارد کردن داده‌ها به SQL Server
3. استفاده از اسکریپت های انتقال داده به MSSQL
4. ساخت اسکیمای `mimiciii` و تطبیق دقیق ساختار جداول

در این ریپوزیتوری روش سوم توضیح داده شده است
---

## 🧮 دستور SELECT

آشنایی با:

- انتخاب ستون‌های خاص
- مرتب‌سازی (`ORDER BY`)
- حذف تکرارها (`DISTINCT`)
- محدود کردن نتایج (`TOP`, `WHERE`)

📁 تمرین‌ها: [`01_basic_select/select_examples.sql`](https://github.com/HMZSQLBI/mimic-sql-tutorial/blob/main/select_examples.sql)

---

## 🔄 دستور WITH (CTE)

- تعریف CTE با `WITH`
- استفاده از CTE برای خوانایی و ماژولار کردن کوئری‌های پیچیده
- ترکیب CTE با `JOIN` و `CASE`

📁 تمرین: [`04_cte_case/with_join_case_mimiciii.sql`](https://github.com/HMZSQLBI/mimic-sql-tutorial/blob/main/join_practice_mimiciii.sql)

---

## 🔗 JOIN ها

- آشنایی با `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN`, `CROSS JOIN`
- ترکیب اطلاعات از چند جدول (patients, admissions, icustays)
- 
📁 تمرین: https://github.com/HMZSQLBI/mimic-sql-tutorial/blob/main/join_practice_mimiciii.sql

---

## ⚙️ Indexes (ایندکس‌ها)

- بررسی تأثیر ایندکس بر کارایی کوئری
- ایجاد ایندکس تک‌ستونی و چندستونی
- مشاهده ایندکس‌های موجود
- مقایسه اجرای کوئری با و بدون ایندکس

📁 تمرین: https://github.com/HMZSQLBI/mimic-sql-tutorial/blob/main/index_practice_mimiciii.sql

---

## ✅ مجوز

محتوای آموزشی این ریپوزیتوری تحت مجوز MIT منتشر شده است. داده‌های MIMIC-III تحت شرایط مجوز خاص خود در سایت PhysioNet ارائه می‌شود.

---

## 📬 ارتباط

در صورت سوال یا پیشنهاد، لطفاً از طریق Issues در همین ریپوزیتوری یا ایمیل شخصی با ما در تماس باشید.
