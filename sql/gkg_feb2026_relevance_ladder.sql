WITH base AS (
  SELECT
    DATE(PARSE_TIMESTAMP('%Y%m%d%H%M%S', CAST(DATE AS STRING))) AS day,
    DATE AS datetime_int,
    DocumentIdentifier AS url,
    SourceCommonName AS source,
    V2Themes AS themes,
    V2Persons AS persons,
    V2Organizations AS orgs,
    V2Locations AS locations,
    V2Tone AS v2tone_raw
  FROM `gdelt-bq.gdeltv2.gkg`
  WHERE DATE BETWEEN 20260201000000 AND 20260228235959
),

scored AS (
  SELECT
    *,
    -- Tier 1: strict Milano-Cortina / Winter Olympics phrasing in URL
    REGEXP_CONTAINS(LOWER(url),
      r'(milano[-_]?cortina|milan[-_]?cortina|winter[-_]?olymp|milano.*olymp|cortina.*olymp)') AS rel_strict,

    -- Tier 2: contextual sports terms with host/winter context 
    (
      REGEXP_CONTAINS(LOWER(url), r'(medal|medals|gold|silver|bronze|closing-ceremony|opening-ceremony|podium|finals?)')
      AND REGEXP_CONTAINS(LOWER(url), r'(milano|milan|cortina|winter)')
    ) AS rel_context,

    -- Tier 3: broad Olympics keyword
    REGEXP_CONTAINS(LOWER(url), r'\bolymp(ic|ics)?\b') AS rel_olymp,

    -- Helper: host location mention
    REGEXP_CONTAINS(LOWER(url), r'\b(milano|milan|cortina)\b') AS rel_host_loc
  FROM base
),

filtered AS (
  SELECT
    *,
    (rel_strict OR rel_context OR rel_olymp) AS rel_combined
  FROM scored
)

SELECT
  day,
  datetime_int,
  url,
  source,
  themes,
  persons,
  orgs,
  locations,
  v2tone_raw,
  rel_strict,
  rel_context,
  rel_olymp,
  rel_host_loc,
  rel_combined
FROM filtered
WHERE
  (
    rel_strict
    OR rel_olymp
    OR rel_context
    OR (rel_host_loc AND REGEXP_CONTAINS(LOWER(url), r'(olymp|winter)'))
    OR REGEXP_CONTAINS(LOWER(themes), r'(olympic|winter_olympic)')
  )
LIMIT 200000;