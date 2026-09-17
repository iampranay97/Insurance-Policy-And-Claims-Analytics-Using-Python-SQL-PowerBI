CREATE TABLE clean_contracts (
    contract_id VARCHAR(50) PRIMARY KEY,
    client_id VARCHAR(50),
    client_name VARCHAR(100),
    product VARCHAR(50),
    start_date DATE,
    end_date DATE,
    annual_premium NUMERIC(10, 2),
    status VARCHAR(50),
    city_postal VARCHAR(100),
    risk_zone VARCHAR(50),
    client_age INT,
    channel VARCHAR(50),
    csp VARCHAR(50),
    gender VARCHAR(20)
);

CREATE TABLE clean_claims (
    claim_id VARCHAR(50) PRIMARY KEY,
    contract_id VARCHAR(50),
    occurrence_date DATE,
    declaration_date DATE,
    claim_type VARCHAR(100),
    damage_amount NUMERIC(10, 2),
    indemnified_amount NUMERIC(10, 2),
    status VARCHAR(50),
    expert_id VARCHAR(50),
    liability VARCHAR(50)
);

CREATE TABLE clean_vehicles (
    contract_id VARCHAR(50),
    brand VARCHAR(50),
    model VARCHAR(50),
    year INT,
    fuel_type VARCHAR(50),
    current_value NUMERIC(10, 2),
    color VARCHAR(30),
    usage VARCHAR(50),
    previous_claims INT,
    power_hp INT
);

SELECT * FROM clean_contracts;
SELECT * FROM clean_claims;
SELECT * FROM clean_vehicles;


-- 1. Row Counts & Primary Key Check

SELECT 
    (SELECT COUNT(*) FROM clean_contracts) AS total_contracts,
    (SELECT COUNT(*) FROM clean_claims) AS total_claims,
    (SELECT COUNT(*) FROM clean_vehicles) AS total_vehicles;


-- 2. Financial Overview (Overall Business KPIs)

SELECT 
    ROUND(SUM(annual_premium), 2) AS total_premium_collected,
    ROUND(AVG(annual_premium), 2) AS avg_premium_per_contract,
    COUNT(DISTINCT client_id) AS total_unique_clients
FROM clean_contracts;


-- 3. Claims Summary by Status

SELECT 
    status,
    COUNT(claim_id) AS total_claims,
    ROUND(SUM(damage_amount), 2) AS total_damage_amount,
    ROUND(SUM(indemnified_amount), 2) AS total_indemnified_amount
FROM clean_claims
GROUP BY status
ORDER BY total_claims DESC;


-- 4. Policy Distribution by Product & Channel

SELECT 
    product,
    channel,
    COUNT(contract_id) AS total_contracts,
    ROUND(SUM(annual_premium), 2) AS total_revenue
FROM clean_contracts
GROUP BY product, channel
ORDER BY total_revenue DESC;


-- 5. Vehicle Distribution by Fuel Type & Top Brands

SELECT 
    brand,
    fuel_type,
    COUNT(*) AS total_vehicles,
    ROUND(AVG(current_value), 2) AS avg_vehicle_value
FROM clean_vehicles
GROUP BY brand, fuel_type
ORDER BY total_vehicles DESC
LIMIT 10;


-- 6. Loss Ratio & Profitability Analysis by Risk Zone

SELECT 
    c.risk_zone,
    COUNT(DISTINCT c.contract_id) AS total_contracts,
    ROUND(SUM(c.annual_premium), 2) AS total_premium,
    COALESCE(ROUND(SUM(cl.indemnified_amount), 2), 0.00) AS total_indemnified,
    ROUND(
        (COALESCE(SUM(cl.indemnified_amount), 0) / NULLIF(SUM(c.annual_premium), 0)) * 100, 
        2
    ) AS loss_ratio_pct
FROM clean_contracts c
LEFT JOIN clean_claims cl 
    ON c.contract_id = cl.contract_id
GROUP BY c.risk_zone
ORDER BY loss_ratio_pct DESC;


-- 7. Top High-Risk Clients Ranking

WITH client_claim_summary AS (
    SELECT 
        c.client_id,
        c.client_name,
        c.risk_zone,
        c.annual_premium,
        COUNT(cl.claim_id) AS total_claims,
        COALESCE(SUM(cl.damage_amount), 0) AS total_damage
    FROM clean_contracts c
    LEFT JOIN clean_claims cl 
        ON c.contract_id = cl.contract_id
    GROUP BY c.client_id, c.client_name, c.risk_zone, c.annual_premium
)
SELECT 
    client_id,
    client_name,
    risk_zone,
    annual_premium,
    total_claims,
    total_damage,
    DENSE_RANK() OVER (
        PARTITION BY risk_zone 
        ORDER BY annual_premium DESC
    ) AS premium_rank_in_zone
FROM client_claim_summary
WHERE total_claims > 0
ORDER BY risk_zone, premium_rank_in_zone
LIMIT 15;


-- 8. Vehicle Risk & Claim Frequency Analysis

SELECT 
    v.brand,
    v.fuel_type,
    COUNT(DISTINCT v.contract_id) AS insured_vehicles,
    COUNT(cl.claim_id) AS total_claims_filed,
    COUNT(CASE WHEN cl.status = 'Closed' THEN 1 END) AS approved_claims,
    ROUND(AVG(v.current_value), 2) AS avg_vehicle_value,
    COALESCE(ROUND(SUM(cl.indemnified_amount), 2), 0.00) AS total_payout
FROM clean_vehicles v
JOIN clean_contracts c 
    ON v.contract_id = c.contract_id
LEFT JOIN clean_claims cl 
    ON c.contract_id = cl.contract_id
GROUP BY v.brand, v.fuel_type
HAVING COUNT(cl.claim_id) > 0
ORDER BY total_payout DESC;
