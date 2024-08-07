SELECT
  *
FROM (
  SELECT
    "t16"."o_year",
    SUM("t16"."nation_volume") / SUM("t16"."volume") AS "mkt_share"
  FROM (
    SELECT
      "t15"."o_year",
      "t15"."volume",
      "t15"."nation",
      "t15"."r_name",
      "t15"."o_orderdate",
      "t15"."p_type",
      CASE WHEN "t15"."nation" = 'BRAZIL' THEN "t15"."volume" ELSE CAST(0 AS TINYINT) END AS "nation_volume"
    FROM (
      SELECT
        EXTRACT(year FROM "t10"."o_orderdate") AS "o_year",
        "t8"."l_extendedprice" * (
          CAST(1 AS TINYINT) - "t8"."l_discount"
        ) AS "volume",
        "t13"."n_name" AS "nation",
        "t14"."r_name",
        "t10"."o_orderdate",
        "t7"."p_type"
      FROM "tpch"."part" AS "t7"
      INNER JOIN "tpch"."lineitem" AS "t8"
        ON "t7"."p_partkey" = "t8"."l_partkey"
      INNER JOIN "tpch"."supplier" AS "t9"
        ON "t9"."s_suppkey" = "t8"."l_suppkey"
      INNER JOIN "tpch"."orders" AS "t10"
        ON "t8"."l_orderkey" = "t10"."o_orderkey"
      INNER JOIN "tpch"."customer" AS "t11"
        ON "t10"."o_custkey" = "t11"."c_custkey"
      INNER JOIN "tpch"."nation" AS "t12"
        ON "t11"."c_nationkey" = "t12"."n_nationkey"
      INNER JOIN "tpch"."region" AS "t14"
        ON "t12"."n_regionkey" = "t14"."r_regionkey"
      INNER JOIN "tpch"."nation" AS "t13"
        ON "t9"."s_nationkey" = "t13"."n_nationkey"
    ) AS "t15"
    WHERE
      "t15"."r_name" = 'AMERICA'
      AND "t15"."o_orderdate" BETWEEN MAKE_DATE(1995, 1, 1) AND MAKE_DATE(1996, 12, 31)
      AND "t15"."p_type" = 'ECONOMY ANODIZED STEEL'
  ) AS "t16"
  GROUP BY
    1
) AS "t17"
ORDER BY
  "t17"."o_year" ASC