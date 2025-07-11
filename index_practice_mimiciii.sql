
-- تمرین ۱: مقایسه اجرای کوئری با و بدون ایندکس
-- هدف: بررسی تاثیر ایندکس روی سرعت جستجو

-- فعال‌سازی بررسی I/O
SET STATISTICS IO ON;

-- اجرای کوئری اولیه بدون ایندکس
SELECT * 
FROM mimiciii.admissions
WHERE subject_id = 10001;

-- اثر مورد انتظار: logical reads بالا خواهد بود چون Full Table Scan انجام می‌شود

-- ایجاد ایندکس روی ستون subject_id
CREATE NONCLUSTERED INDEX idx_admissions_subject_id
ON mimiciii.admissions(subject_id);

-- اجرای مجدد کوئری
SELECT * 
FROM mimiciii.admissions
WHERE subject_id = 10001;

-- اثر مورد انتظار: کاهش چشمگیر logical reads، استفاده از ایندکس

SET STATISTICS IO OFF;

--------------------------------------------------------------------------------

-- تمرین ۲: ایندکس ترکیبی
-- هدف: مقایسه ایندکس تک‌ستونی و مرکب برای فیلتر چند ستونی

-- اجرای کوئری با فیلتر دو ستونی
SELECT * 
FROM mimiciii.icustays
WHERE subject_id = 10001 AND hadm_id = 100134;

-- ایجاد ایندکس روی subject_id به تنهایی
CREATE NONCLUSTERED INDEX idx_icustays_subject
ON mimiciii.icustays(subject_id);

-- اجرای مجدد کوئری
-- اثر: شاید ایندکس استفاده شود، اما نه بهینه چون فقط روی subject_id است

-- ایجاد ایندکس مرکب روی دو ستون
CREATE NONCLUSTERED INDEX idx_icustays_subject_hadm
ON mimiciii.icustays(subject_id, hadm_id);

-- اجرای مجدد کوئری
-- اثر: استفاده از ایندکس ترکیبی، کارایی بهتر از ایندکس تک‌ستونی

--------------------------------------------------------------------------------

-- تمرین ۳: انتخاب ستون مناسب برای ایندکس‌گذاری
-- هدف: تحلیل فراوانی داده‌ها و ایندکس‌گذاری روی فیلد پرتکرار

-- بررسی فراوانی admission_type
SELECT admission_type, COUNT(*) 
FROM mimiciii.admissions
GROUP BY admission_type;

-- ایجاد ایندکس روی admission_type
CREATE NONCLUSTERED INDEX idx_admission_type
ON mimiciii.admissions(admission_type);

-- کوئری برای فیلتر بر اساس admission_type
SELECT * 
FROM mimiciii.admissions
WHERE admission_type = 'EMERGENCY';

-- اثر: استفاده از ایندکس و کاهش زمان فیلتر در ستون دارای چند مقدار یکتا

--------------------------------------------------------------------------------

-- تمرین ۴: مشاهده ایندکس‌های موجود روی جدول admissions
-- هدف: آشنایی با متادیتاهای مربوط به ایندکس‌ها

SELECT 
    t.name AS table_name,
    ind.name AS index_name,
    ind.type_desc AS index_type,
    col.name AS column_name
FROM sys.indexes ind 
INNER JOIN sys.index_columns ic ON ind.object_id = ic.object_id AND ind.index_id = ic.index_id 
INNER JOIN sys.columns col ON ic.object_id = col.object_id AND ic.column_id = col.column_id 
INNER JOIN sys.tables t ON ind.object_id = t.object_id 
WHERE t.name = 'admissions';

-- اثر: نمایش تمام ایندکس‌های تعریف‌شده روی جدول admissions

--------------------------------------------------------------------------------

-- تمرین ۵: حذف ایندکس و بررسی تأثیر

-- ایجاد ایندکس روی hospital_expire_flag
CREATE NONCLUSTERED INDEX idx_expire_flag
ON mimiciii.admissions(hospital_expire_flag);

-- اجرای کوئری با ایندکس
SELECT * 
FROM mimiciii.admissions
WHERE hospital_expire_flag = 1;

-- اثر: سرعت بهتر در اجرای شرط WHERE با استفاده از ایندکس

-- حذف ایندکس
DROP INDEX idx_expire_flag ON mimiciii.admissions;

-- اجرای مجدد کوئری
SELECT * 
FROM mimiciii.admissions
WHERE hospital_expire_flag = 1;

-- اثر: بازگشت به اسکن کامل جدول (Full Scan)، کاهش سرعت

--------------------------------------------------------------------------------
