-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER

-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 透明人，Email 為 opacity0@hexschooltest.io，Role 為 USER
insert into "USER" (
   name,
   email,
   role
) values ( '李燕容',
           'lee2000@hexschooltest.io',
           'USER' ),( '王小明',
                      'wXlTq@hexschooltest.io',
                      'USER' ),( '肌肉棒子',
                                 'muscle@hexschooltest.io',
                                 'USER' ),( '好野人',
                                            'richman@hexschooltest.io',
                                            'USER' ),( 'Q太郎',
                                                       'starplatinum@hexschooltest.io',
                                                       'USER' ),( '透明人',
                                                                  'opacity0@hexschooltest.io',
                                                                  'USER' );

-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH
update "USER"
   set
   role = 'COACH'
 where email in ( 'lee2000@hexschooltest.io',
                  'muscle@hexschooltest.io',
                  'starplatinum@hexschooltest.io' );
-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料
delete from "USER"
 where email = 'opacity0@hexschooltest.io';
-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）
select count(*)
  from "USER";
-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）
-- select * from "USER" Limit 3;

--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
    -- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
    -- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
    -- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`
insert into "CREDIT_PACKAGE" (
   name,
   credit_amount,
   price
) values ( '7 堂組合包方案',
           7,
           1400 ),( '14 堂組合包方案',
                    14,
                    2520 ),( '21 堂組合包方案',
                             21,
                             4800 );
-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 name 欄位做子查詢）
    -- 1. `王小明` 購買 `14 堂組合包方案`
    -- 2. `王小明` 購買 `21 堂組合包方案`
    -- 3. `好野人` 購買 `14 堂組合包方案`
insert into "CREDIT_PURCHASE" (
   user_id,
   credit_package_id,
   purchased_credits,
   price_paid
)
   select users.id as user_id,
          credit_purchase.id as credit_package_id,
          credit_purchase.credit_amount as purchased_credits,
          credit_purchase.price as price_paid
     from "USER" users
    inner join "CREDIT_PACKAGE" credit_purchase
   on ( users.name = '王小明'
      and credit_purchase.name in ( '14 堂組合包方案',
                                    '21 堂組合包方案' ) )
       or ( users.name = '好野人'
      and credit_purchase.name = '14 堂組合包方案' );

-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
    -- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
    -- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
    -- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年
insert into "COACH" (
   user_id,
   experience_years
)
   select id,
          2
     from "USER"
    where email in ( 'lee2000@hexschooltest.io',
                     'muscle@hexschooltest.io',
                     'starplatinum@hexschooltest.io' );
-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
    -- 1. 所有教練都有 `重訓` 專長
    -- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
    -- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長


--所有教練都有 `重訓` 專長
insert into "COACH_LINK_SKILL" (
   coach_id,
   skill_id
)
   (
      select a.id,
             b.id
        from "COACH" a,
             "SKILL" b
       where b.name = '重訓'
   );

-- 教練`肌肉棒子` 需要有 `瑜伽` 專長
insert into "COACH_LINK_SKILL" (
   coach_id,
   skill_id
)
   (
      select c.id,
             d.id
        from (
         select a.id
           from "COACH" a
          inner join "USER" b
         on a.user_id = b.id
          where b.name = '肌肉棒子'
      ) c,
             "SKILL" d
       where d.name = '瑜伽'
   );

-- 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長
insert into "COACH_LINK_SKILL" (
   coach_id,
   skill_id
)
   select a.id,
          b.id
     from (
      select b.id
        from "USER" a
       inner join "COACH" b
      on a.id = b.user_id
       where a.name = 'Q太郎'
   ) a,
          "SKILL" b
    where b.name in ( '有氧運動',
                      '復健訓練' );

-- 3-3 修改：更新教練的經驗年數，資料需求如下：
    -- 1. 教練`肌肉棒子` 的經驗年數為3年
    -- 2. 教練`Q太郎` 的經驗年數為5年

-- 教練`肌肉棒子` 的經驗年數為3年
update "COACH"
   set
   experience_years = 3
 where id = (
   select b.id
     from "USER" a
    inner join "COACH" b
   on a.id = b.user_id
    where a.name = '肌肉棒子'
);

-- 教練`Q太郎` 的經驗年數為5年
update "COACH"
   set
   experience_years = 5
 where id = (
   select b.id
     from "USER" a
    inner join "COACH" b
   on a.id = b.user_id
    where a.name = 'Q太郎'
);

-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。


insert into "SKILL" ( name ) values ( '空中瑜伽' );

delete from "SKILL"
 where name = '空中瑜伽';

--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE

-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
    -- 1. 教練設定為用戶`李燕容` 
    -- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
    -- 3. 在課程名稱上，設定為「`重訓基礎課`」
    -- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
    -- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
    -- 6. 最大授課人數`max_participants` 設定為10
    -- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io
insert into "COURSE" (
   user_id,
   skill_id,
   name,
   description,
   start_at,
   end_at,
   max_participants,
   meeting_url
) values ( (
   select id
     from "USER"
    where name = '李燕容'
),
           (
              select id
                from "SKILL"
               where name = '重訓'
           ),
           '重訓基礎課',
           '此課堂為重訓基礎課程，讓學員了解關於重訓的基礎觀念',
           to_timestamp('2024-11-25 14:00:00',
                        'YYYY-MM-DD hh24:mi:ss'),
           to_timestamp('2024-11-25 16:00:00',
                        'YYYY-MM-DD hh24:mi:ss'),
           10,
           'https://test-meeting.test.io' );

-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================

-- 5. 客戶預約與授課 COURSE_BOOKING
-- 5-1. 新增：請在 `COURSE_BOOKING` 新增兩筆資料：
    -- 1. 第一筆：`王小明`預約 `李燕容` 的課程
        -- 1. 預約人設為`王小明`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課
    -- 2. 新增： `好野人` 預約 `李燕容` 的課程
        -- 1. 預約人設為 `好野人`
        -- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
        -- 3. 狀態`status` 設定為即將授課

insert into "COURSE_BOOKING" (
   user_id,
   course_id,
   booking_at,
   status
) values ( (
   select id
     from "USER"
    where name = '王小明'
),
           (
              select a.id
                from "COURSE" a
               inner join "USER" b
              on a.user_id = b.id
               where b.name = '李燕容'
                 and b.role = 'COACH'
           ),
           to_timestamp('2024-11-24 16:00:00',
                        'YYYY-MM-DD hh24:mi:ss'),
           '即將授課' ),( (
   select id
     from "USER"
    where name = '好野人'
),
                      (
                         select a.id
                           from "COURSE" a
                          inner join "USER" b
                         on a.user_id = b.id
                          where b.name = '李燕容'
                            and b.role = 'COACH'
                      ),
                      to_timestamp('2024-11-24 16:00:00',
                                   'YYYY-MM-DD hh24:mi:ss'),
                      '即將授課' );

-- 5-2. 修改：`王小明`取消預約 `李燕容` 的課程，請在`COURSE_BOOKING`更新該筆預約資料：
    -- 1. 取消預約時間`cancelled_at` 設為2024-11-24 17:00:00
    -- 2. 狀態`status` 設定為課程已取消

update "COURSE_BOOKING"
   set cancelled_at = to_timestamp('2024-11-24 17:00:00',
             'YYYY-MM-DD hh24:mi:ss'),
       status = '課程已取消'
 where user_id = (
   select id
     from "USER"
    where name = '王小明'
);


-- 5-3. 新增：`王小明`再次預約 `李燕容`   的課程，請在`COURSE_BOOKING`新增一筆資料：
    -- 1. 預約人設為`王小明`
    -- 2. 預約時間`booking_at` 設為2024-11-24 17:10:25
    -- 3. 狀態`status` 設定為即將授課

insert into "COURSE_BOOKING" (
   user_id,
   course_id,
   booking_at,
   status
) values ( (
   select id
     from "USER"
    where name = '王小明'
),
           (
              select a.id
                from "COURSE" a
               inner join "USER" b
              on a.user_id = b.id
               where b.name = '李燕容'
                 and b.role = 'COACH'
           ),
           to_timestamp('2024-11-24 17:10:25',
                        'YYYY-MM-DD hh24:mi:ss'),
           '即將授課' );

-- 5-4. 查詢：取得王小明所有的預約紀錄，包含取消預約的紀錄

select b.name,
       a.booking_at,
       a.status,
       a.cancelled_at,
       a.created_at
  from "COURSE_BOOKING" a
 inner join "USER" b
on a.user_id = b.id
 where b.name = '王小明';

-- 5-5. 修改：`王小明` 現在已經加入直播室了，請在`COURSE_BOOKING`更新該筆預約資料（請注意，不要更新到已經取消的紀錄）：
    -- 1. 請在該筆預約記錄他的加入直播室時間 `join_at` 設為2024-11-25 14:01:59
    -- 2. 狀態`status` 設定為上課中
update "COURSE_BOOKING"
   set join_at = to_timestamp('2024-11-25 14:01:59',
             'YYYY-MM-DD hh24:mi:ss'),
       status = '上課中'
 where user_id = (
      select id
        from "USER"
       where name = '王小明'
   )
   and status = '即將授課';


-- 5-6. 查詢：計算用戶王小明的購買堂數，顯示須包含以下欄位： user_id , total。 (需使用到 SUM 函式與 Group By)

select a.user_id,
       sum(a.price_paid)
  from "CREDIT_PURCHASE" a
 inner join "USER" b
on a.user_id = b.id
 where b.name = '王小明'
 group by a.user_id;

-- 5-7. 查詢：計算用戶王小明的已使用堂數，顯示須包含以下欄位： user_id , total。 (需使用到 Count 函式與 Group By)

select b.id,
       count(*) as total
  from "COURSE_BOOKING" a
 inner join "USER" b
on a.user_id = b.id
 where b.name = '王小明'
 group by b.id;

-- 5-8. [挑戰題] 查詢：請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位： user_id , remaining_credit
    -- 提示：
    -- select ("CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit) as remaining_credit, ...
    -- from ( 用戶王小明的購買堂數 ) as "CREDIT_PURCHASE"
    -- inner join ( 用戶王小明的已使用堂數) as "COURSE_BOOKING"
    -- on "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;

--先把 購買課程總數 和 上過課的數量 算好，再互相減去
select c.user_id,
       ( c.total_credit - d.used_credit ) as remaining_credit
  from (
   select a.user_id,
          sum(a.purchased_credits) as total_credit
     from "CREDIT_PURCHASE" a
    inner join "USER" b
   on a.user_id = b.id
    where b.name = '王小明'
    group by a.user_id
) c
 inner join (
   select a.user_id,
          count(a.course_id) as used_credit
     from "COURSE_BOOKING" a
    inner join "USER" b
   on a.user_id = b.id
    where b.name = '王小明'
      and a.join_at is not null
    group by a.user_id
) d
on c.user_id = d.user_id;

-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================
-- 6. 後台報表
-- 6-1 查詢：查詢專長為重訓的教練，並按經驗年數排序，由資深到資淺（需使用 inner join 與 order by 語法)
-- 顯示須包含以下欄位： 教練名稱 , 經驗年數, 專長名稱

select e.name,
       e.experience_years,
       f.name
  from (
   select c.name,
          c.experience_years,
          d.skill_id
     from (
      select a.name,
             b.experience_years,
             b.id
        from "USER" a
       inner join "COACH" b
      on a.id = b.user_id
   ) c
    inner join "COACH_LINK_SKILL" d
   on c.id = d.coach_id
) e
 inner join "SKILL" f
on e.skill_id = f.id
 order by e.experience_years desc;

-- 6-2 查詢：查詢每種專長的教練數量，並只列出教練數量最多的專長（需使用 group by, inner join 與 order by 與 limit 語法）
-- 顯示須包含以下欄位： 專長名稱, coach_total

select b.name,
       count(a.coach_id)
  from "COACH_LINK_SKILL" a
 inner join "SKILL" b
on a.skill_id = b.id
 group by b.name;

-- 6-3. 查詢：計算 11 月份組合包方案的銷售數量
-- 顯示須包含以下欄位： 組合包方案名稱, 銷售數量

--這邊因為12月才把資料匯入，導致created_at的日期落在12月，所以這邊我抓12月份的
select a.name,
       count(*)
  from "CREDIT_PACKAGE" a
 inner join "CREDIT_PURCHASE" b
on a.id = b.credit_package_id
 where b.created_at between to_timestamp('2024-12-01 00:00:00',
             'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-12-31',
             'YYYY-MM-DD HH24:MI:SS')
 group by a.name;

-- 6-4. 查詢：計算 11 月份總營收（使用 purchase_at 欄位統計）
-- 顯示須包含以下欄位： 總營收

--這裡一樣抓12月的
select sum(price_paid) as "12_Month_Total"
  from "CREDIT_PURCHASE"
 where purchase_at between to_timestamp('2024-12-01 00:00:00',
             'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-12-31 23:59:59',
             'YYYY-MM-DD HH24:MI:SS');

-- 6-5. 查詢：計算 11 月份有預約課程的會員人數（需使用 Distinct，並用 created_at 和 status 欄位統計）
-- 顯示須包含以下欄位： 預約會員人數

--這裡一樣抓12月的
select distinct *
  from "COURSE_BOOKING"
 where created_at between to_timestamp('2024-12-01 00:00:00',
             'YYYY-MM-DD HH24:MI:SS') and to_timestamp('2024-12-31 23:59:59',
             'YYYY-MM-DD HH24:MI:SS')
   and status != '課程已取消';