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
    COUNT(CASE color WHEN 'Black' THEN 1 END) AS black_count -- 黒色のカードの数
FROM
    trump_cards
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
    COUNT(CASE mark WHEN 'JK' THEN 1 END) AS sum_columns
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
    COALESCE(TEMP.mark, 'total'), -- マーク
    SUM(TEMP.red_count), -- 赤色のカードの数
    SUM(TEMP.black_count), -- 黒色のカードの数
    SUM(TEMP.red_count) + SUM(TEMP.black_count) AS total_column -- 列合計
    -- [MOME] markは既に一意なので、集計関数は何でもいい
FROM
    (
        -- レポート作成用サブクエリ（※行合計と列合計なし）
        SELECT
            mark, -- マーク
            COUNT(CASE color WHEN 'Red' THEN 1 END) AS red_count, -- 赤色のカードの数
            COUNT(CASE color WHEN 'Black' THEN 1 END) AS black_count -- 黒色のカードの数
        FROM
            trump_cards
        GROUP BY
            mark
    ) TEMP
GROUP BY
    ROLLUP(TEMP.mark)
;

-- ③色別件数検索
SELECT
    COALESCE(TEMP.color, 'total'), -- 色
    SUM(TEMP.club_count), -- クラブの数
    SUM(TEMP.spade_count), -- スペードの数
    SUM(TEMP.heart_count), -- ハートの数
    SUM(TEMP.diamond_count), -- ダイヤの数
    SUM(TEMP.joker_count),
    (
        SUM(TEMP.club_count)
        + SUM(TEMP.spade_count)
        + SUM(TEMP.heart_count)
        + SUM(TEMP.diamond_count)
        + SUM(TEMP.joker_count)
    ) AS total_column -- 列合計
    -- [MOME] markは既に一意
FROM
    (
        -- レポート作成用サブクエリ（※行合計と列合計なし）
        SELECT
            color, -- 色
            COUNT(CASE mark WHEN 'Club' THEN 1 END) AS club_count, -- クラブの数
            COUNT(CASE mark WHEN 'Spade' THEN 1 END) AS spade_count, -- スペードの数
            COUNT(CASE mark WHEN 'Heart' THEN 1 END) AS heart_count, -- ハートの数
            COUNT(CASE mark WHEN 'Diamond' THEN 1 END) AS diamond_count, -- ダイヤの数
            COUNT(CASE mark WHEN 'JK' THEN 1 END) AS joker_count
        FROM
            trump_cards
        GROUP BY
            color
    ) TEMP
GROUP BY
    ROLLUP(TEMP.color)
;

