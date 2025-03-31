
SELECT lugar.lugar
FROM lugar
LEFT JOIN visita ON lugar.ip = visita.ip
WHERE visita.idVisita IS NULL;