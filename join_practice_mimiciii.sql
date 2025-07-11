
-- تمرین ۱: INNER JOIN بین بیماران و پذیرش‌ها
-- هدف: نمایش بیمارانی که حداقل یک پذیرش دارند

SELECT p.subject_id, p.gender, a.hadm_id, a.admission_type
FROM mimiciii.patients p
INNER JOIN mimiciii.admissions a ON p.subject_id = a.subject_id;

-- اثر: فقط بیمارانی که حداقل یک پذیرش دارند نمایش داده می‌شوند

--------------------------------------------------------------------------------

-- تمرین ۲: LEFT JOIN برای یافتن بیماران بدون پذیرش
-- هدف: نمایش همه بیماران، حتی اگر پذیرش نداشته باشند

SELECT p.subject_id, p.gender, a.hadm_id
FROM mimiciii.patients p
LEFT JOIN mimiciii.admissions a ON p.subject_id = a.subject_id
WHERE a.hadm_id IS NULL;

-- اثر: فقط بیمارانی که هیچ رکوردی در جدول admissions ندارند نمایش داده می‌شوند

--------------------------------------------------------------------------------

-- تمرین ۳: RIGHT JOIN برای یافتن پذیرش‌های بدون اطلاعات بیمار
-- هدف: نمایش پذیرش‌هایی که اطلاعات بیمار ندارند

SELECT p.subject_id, a.hadm_id
FROM mimiciii.patients p
RIGHT JOIN mimiciii.admissions a ON p.subject_id = a.subject_id
WHERE p.subject_id IS NULL;

-- اثر: پذیرش‌هایی که اطلاعات بیمار متناظر ندارند (معمولاً نتیجه‌ای نخواهد داشت)

--------------------------------------------------------------------------------

-- تمرین ۴: FULL OUTER JOIN برای بررسی عدم تطابق
-- هدف: یافتن بیمارانی بدون پذیرش یا پذیرش‌هایی بدون اطلاعات بیمار

SELECT p.subject_id AS patient_id, a.hadm_id AS admission_id
FROM mimiciii.patients p
FULL OUTER JOIN mimiciii.admissions a ON p.subject_id = a.subject_id
WHERE p.subject_id IS NULL OR a.hadm_id IS NULL;

-- اثر: ترکیبی از بیماران بدون پذیرش و پذیرش‌های بدون اطلاعات بیمار

--------------------------------------------------------------------------------

-- تمرین ۵: CROSS JOIN برای نمایش ضرب کارتزین
-- هدف: درک مفهوم ضرب کارتزین (cross product)

SELECT TOP 5 p.subject_id, a.hadm_id
FROM mimiciii.patients p
CROSS JOIN mimiciii.admissions a;

-- اثر: هر سطر از patients با هر سطر از admissions ترکیب می‌شود (تعداد سطرها = تعداد بیماران × تعداد پذیرش‌ها)

--------------------------------------------------------------------------------

-- تمرین ۶: ترکیب JOIN و شرط WHERE
-- هدف: نمایش بیماران زن که پذیرش ثبت‌شده دارند

SELECT p.subject_id, p.gender, a.hadm_id
FROM mimiciii.patients p
INNER JOIN mimiciii.admissions a ON p.subject_id = a.subject_id
WHERE p.gender = 'F';

-- اثر: نمایش فقط زنانی که پذیرش ثبت‌شده دارند

--------------------------------------------------------------------------------
