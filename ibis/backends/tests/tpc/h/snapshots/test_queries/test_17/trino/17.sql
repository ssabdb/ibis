SELECT
  SUM("t9"."l_extendedprice") / CAST(7.0 AS DOUBLE) AS "avg_yearly"
FROM (
  SELECT
    *
  FROM (
    SELECT
      "t4"."l_orderkey",
      "t4"."l_partkey",
      "t4"."l_suppkey",
      "t4"."l_linenumber",
      "t4"."l_quantity",
      "t4"."l_extendedprice",
      "t4"."l_discount",
      "t4"."l_tax",
      "t4"."l_returnflag",
      "t4"."l_linestatus",
      "t4"."l_shipdate",
      "t4"."l_commitdate",
      "t4"."l_receiptdate",
      "t4"."l_shipinstruct",
      "t4"."l_shipmode",
      "t4"."l_comment",
      "t5"."p_partkey",
      "t5"."p_name",
      "t5"."p_mfgr",
      "t5"."p_brand",
      "t5"."p_type",
      "t5"."p_size",
      "t5"."p_container",
      "t5"."p_retailprice",
      "t5"."p_comment"
    FROM (
      SELECT
        "t0"."l_orderkey",
        "t0"."l_partkey",
        "t0"."l_suppkey",
        "t0"."l_linenumber",
        CAST("t0"."l_quantity" AS DECIMAL(15, 2)) AS "l_quantity",
        CAST("t0"."l_extendedprice" AS DECIMAL(15, 2)) AS "l_extendedprice",
        CAST("t0"."l_discount" AS DECIMAL(15, 2)) AS "l_discount",
        CAST("t0"."l_tax" AS DECIMAL(15, 2)) AS "l_tax",
        "t0"."l_returnflag",
        "t0"."l_linestatus",
        "t0"."l_shipdate",
        "t0"."l_commitdate",
        "t0"."l_receiptdate",
        "t0"."l_shipinstruct",
        "t0"."l_shipmode",
        "t0"."l_comment"
      FROM "hive"."ibis_tpch_sf1"."lineitem" AS "t0"
    ) AS "t4"
    INNER JOIN (
      SELECT
        "t1"."p_partkey",
        "t1"."p_name",
        "t1"."p_mfgr",
        "t1"."p_brand",
        "t1"."p_type",
        "t1"."p_size",
        "t1"."p_container",
        CAST("t1"."p_retailprice" AS DECIMAL(15, 2)) AS "p_retailprice",
        "t1"."p_comment"
      FROM "hive"."ibis_tpch_sf1"."part" AS "t1"
    ) AS "t5"
      ON "t5"."p_partkey" = "t4"."l_partkey"
  ) AS "t6"
  WHERE
    "t6"."p_brand" = 'Brand#23'
    AND "t6"."p_container" = 'MED BOX'
    AND "t6"."l_quantity" < (
      (
        SELECT
          AVG("t7"."l_quantity") AS "Mean(l_quantity)"
        FROM (
          SELECT
            "t0"."l_orderkey",
            "t0"."l_partkey",
            "t0"."l_suppkey",
            "t0"."l_linenumber",
            CAST("t0"."l_quantity" AS DECIMAL(15, 2)) AS "l_quantity",
            CAST("t0"."l_extendedprice" AS DECIMAL(15, 2)) AS "l_extendedprice",
            CAST("t0"."l_discount" AS DECIMAL(15, 2)) AS "l_discount",
            CAST("t0"."l_tax" AS DECIMAL(15, 2)) AS "l_tax",
            "t0"."l_returnflag",
            "t0"."l_linestatus",
            "t0"."l_shipdate",
            "t0"."l_commitdate",
            "t0"."l_receiptdate",
            "t0"."l_shipinstruct",
            "t0"."l_shipmode",
            "t0"."l_comment"
          FROM "hive"."ibis_tpch_sf1"."lineitem" AS "t0"
          WHERE
            "t0"."l_partkey" = "t6"."p_partkey"
        ) AS "t7"
      ) * CAST(0.2 AS DOUBLE)
    )
) AS "t9"