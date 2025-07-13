
-- جلسه ۱: دستورات پایه SQL روی دیتاست MIMIC-III

-- بخش ۱: نمایش داده‌ها

-- نمایش تمام فیلدهای جدول بیماران (محدود به 10 ردیف)
SELECT TOP 10 * FROM [MIMIC_Demo].dbo.patients;

-- نمایش فقط شناسه و تاریخ تولد بیماران
SELECT subject_id, dob FROM [MIMIC_Demo].dbo.patients;

-- نمایش اولین 20 پذیرش انجام شده
SELECT TOP 20 hadm_id, subject_id, admittime, dischtime
FROM [MIMIC_Demo].dbo.admissions;


-- بخش ۲: فیلتر کردن با WHERE

-- بیماران متولد قبل از 1940
SELECT subject_id, dob
FROM [MIMIC_Demo].dbo.patients
WHERE dob < '1940-01-01';

-- پذیرش‌هایی که در سال 2126 انجام شده‌اند
SELECT hadm_id, admittime
FROM [MIMIC_Demo].dbo.admissions
WHERE YEAR(admittime) = 2126;

-- بیماران مرد
SELECT subject_id, gender
FROM [MIMIC_Demo].dbo.patients
WHERE gender = 'M';

-- بیماران زن
SELECT subject_id, gender
FROM [MIMIC_Demo].dbo.patients
WHERE gender = 'F';

-- پذیرش‌های بین دو تاریخ خاص
SELECT hadm_id, admittime, dischtime
FROM [MIMIC_Demo].dbo.admissions
WHERE admittime BETWEEN '2100-01-01' AND '2126-12-31';

SELECT subject_id, dob FROM [MIMIC_Demo].dbo.patients
ORDER BY dob;

-- بخش ۳: مرتب‌سازی با ORDER BY

-- نمایش ۱۰ بیمار به ترتیب تاریخ تولد صعودی
SELECT TOP 10 subject_id, dob
FROM [MIMIC_Demo].dbo.patients
ORDER BY dob ASC;

-- ۱۰ پذیرش اخیر به ترتیب نزولی
SELECT TOP 10 hadm_id, admittime
FROM [MIMIC_Demo].dbo.admissions
ORDER BY admittime DESC;


-- بخش ۴: DISTINCT, TOP, LIKE, IS NULL

-- نمایش جنسیت‌های یکتا
SELECT DISTINCT gender FROM [MIMIC_Demo].dbo.patients;

-- ۵۰ بیمار اول
SELECT TOP 50 subject_id FROM [MIMIC_Demo].dbo.patients;

-- پذیرش‌هایی که diagnosis شامل کلمه "infection" باشد
SELECT hadm_id, diagnosis
FROM [MIMIC_Demo].dbo.admissions
WHERE diagnosis LIKE '%infection%';

-- پذیرش‌هایی که [MARITAL_STATUS] مشخص نشده است
SELECT hadm_id, [MARITAL_STATUS]
FROM [MIMIC_Demo].dbo.admissions
WHERE [MARITAL_STATUS] IS NULL;

-- انتخاب اطلاعات بیماران زن بالای ۶۵ سال

SELECT subject_id, gender, dob
FROM [dbo].[PATIENTS]
WHERE gender = 'F'
  AND DATEDIFF(year, dob, GETDATE()) > 65;


--  ارتباط بین بستری و مرگ در بیمارستان (JOIN + شرط)

SELECT p.subject_id, a.hadm_id, a.admittime, a.dischtime, a.hospital_expire_flag
FROM [dbo].[PATIENTS] p
JOIN [dbo].[ADMISSIONS] a ON p.subject_id = a.subject_id
WHERE a.hospital_expire_flag = 1;


-- نمایش ۱۰ بیماری که در سال 2200 بستری شده‌اند و diagnosis آن‌ها شامل "pneumonia" است
SELECT TOP 10 a.hadm_id, a.subject_id, a.admittime, a.diagnosis
FROM [MIMIC_Demo].dbo.admissions a
WHERE
 YEAR(admittime) = 2200
  AND 
  a.diagnosis LIKE '%pneumonia%'
ORDER BY admittime DESC;

--میانگین سن بیماران در هر جنسیت
SELECT gender, AVG(DATEDIFF(year, dob, admittime)) AS avg_age
FROM [dbo].[PATIENTS] p
JOIN [dbo].[ADMISSIONS] a ON p.subject_id = a.subject_id
GROUP BY gender;

--قند خون بمیاران
select * from [dbo].[D_ITEMS] where itemid = 220621

SELECT icustay_id,
       MAX(CASE WHEN itemid = 220621 THEN valuenum END) AS glucose_level
FROM [dbo].[CHARTEVENTS]
WHERE itemid = 220621
  AND valuenum IS NOT NULL
GROUP BY icustay_id;

--استفاده از CTE 
--Common Table Expression
--بیماران مسن
WITH high_age_patients AS (
  SELECT subject_id, DATEDIFF(year, dob, GETDATE()) AS age
  FROM patients
  WHERE DATEDIFF(year, dob, GETDATE()) > 70
)
SELECT * FROM high_age_patients


----استفاده از CTE برای محاسبه GCS همراه اطلاعات بیمار

WITH gcs_scores AS (
  SELECT icustay_id,
         MAX(CASE WHEN itemid IN (454, 223900) THEN valuenum END) AS gcs
  FROM [dbo].[CHARTEVENTS]
  WHERE valuenum IS NOT NULL
  GROUP BY icustay_id
)
SELECT i.subject_id, i.hadm_id, g.gcs
FROM [dbo].[ICUSTAYS] i
LEFT JOIN gcs_scores g ON i.icustay_id = g.icustay_id;