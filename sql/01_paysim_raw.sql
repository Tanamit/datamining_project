DROP TABLE IF EXISTS paysim_raw;

CREATE TABLE paysim_raw (
  step            int,
  type            text,
  amount          numeric(14,2),
  nameorig        text,
  oldbalanceorg   numeric(14,2),
  newbalanceorig  numeric(14,2),
  namedest        text,
  oldbalancedest  numeric(14,2),
  newbalancedest  numeric(14,2),
  isfraud         smallint,
  isflaggedfraud  smallint
);
