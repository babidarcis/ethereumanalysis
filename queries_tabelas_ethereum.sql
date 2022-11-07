#retorna a quantidade de blocos com contratos feitos em um dia - usei o max(date)
SELECT
  CAST(block_number	AS INTEGER) AS blocks,
  COUNT(CAST(total_supply AS FLOAT64)) AS tokens
FROM `bigquery-public-data.crypto_ethereum.tokens`
WHERE CAST(block_timestamp AS DATE) = CURRENT_DATE() AND total_supply IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC

#retorna a quantidade de tokens criados por bloco
SELECT *
FROM (SELECT block_number, COUNT(distinct total_supply) AS ctn_token
      FROM `bigquery-public-data.crypto_ethereum.tokens`
      GROUP BY 1)
WHERE ctn_token >= 1
ORDER BY ctn_token DESC

#retorna a quantidade de blocos gerados nos útimos 15 dias
SELECT
  CAST(block_number AS INTEGER) AS blocks,
  COUNT(CAST(total_supply AS FLOAT64)) AS tokens
FROM `bigquery-public-data.crypto_ethereum.tokens`
WHERE CAST(block_timestamp AS DATE) BETWEEN CURRENT_DATE() -15 AND CURRENT_DATE()
GROUP BY 1
ORDER BY tokens DESC

#retorna a quantidade de blocos gerados com tokens nos útimos 15 dias
SELECT
  CAST(block_number AS INTEGER) AS blocks,
  COUNT(CAST(total_supply AS FLOAT64)) AS tokens
FROM `bigquery-public-data.crypto_ethereum.tokens`
WHERE CAST(block_timestamp AS DATE) BETWEEN CURRENT_DATE() -15 AND CURRENT_DATE() AND total_supply IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC

