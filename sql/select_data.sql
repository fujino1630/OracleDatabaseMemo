-- ①全体検索
SELECT
    suji,
    label,
    mark,
    color,
    is_num
FROM
    trump_cards
;


-- ②マーク別件数検索
SELECT
    mark, -- マーク
    COUNT(CASE color WHEN 'Red' THEN 1 END) AS red_count, -- 赤色のカードの数
    COUNT(CASE color WHEN 'Black' THEN 1 END) AS black_count, -- 黒色のカードの数
    COUNT(*) AS sum_columns
FROM
    trump_cards
WHERE
    mark IS NOT NULL -- JOKERを除く
GROUP BY
    mark
;


-- ③色別件数検索
SELECT
    color, -- 色
    COUNT(CASE mark WHEN 'Club' THEN 1 END) AS club_count, -- クラブの数
    COUNT(CASE mark WHEN 'Spade' THEN 1 END) AS spade_count, -- スペードの数
    COUNT(CASE mark WHEN 'Heart' THEN 1 END) AS heart_count, -- ハートの数
    COUNT(CASE mark WHEN 'Diamond' THEN 1 END) AS diamond_count, -- ダイヤの数
    COUNT(*) AS sum_columns
FROM
    trump_cards
GROUP BY
    color
;


----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------
-- 合計行を加える方法

-- ②マーク別件数検索
SELECT
    -- GROUPING関数は、集計行なら1、それ以外なら0を返す
    DECODE(GROUPING(mark), 1, '合計', mark) AS mark,
    COUNT(*) AS count
FROM
    trump_cards
GROUP BY
    ROLLUP(mark)
;


-- ③色別件数検索
SELECT
    -- color, -- 色
    DECODE(GROUPING(color), 1, '合計', color) AS color,
    COUNT(CASE mark WHEN 'Club' THEN 1 END) AS club_count, -- クラブの数
    COUNT(CASE mark WHEN 'Spade' THEN 1 END) AS spade_count, -- スペードの数
    COUNT(CASE mark WHEN 'Heart' THEN 1 END) AS heart_count, -- ハートの数
    COUNT(CASE mark WHEN 'Diamond' THEN 1 END) AS diamond_count, -- ダイヤの数
    COUNT(*) AS sum_columns
FROM
    trump_cards
GROUP BY
    -- color
    ROLLUP(color)
;

