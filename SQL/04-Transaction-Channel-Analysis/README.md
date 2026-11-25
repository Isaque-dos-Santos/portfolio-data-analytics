# Transaction Channel Performance Analysis

## Project Overview

This project analyzes monthly transaction performance across different source systems using SQL.

The analysis focuses on transaction volume, unique customers, total points, and monthly percentage changes to evaluate the activity of each transaction channel over time.

## Business Objective

Evaluate the performance of different transaction channels and identify periods of growth or decline in transaction activity.

## Dataset

The project uses the `transacoes` table, which contains transaction records, customer identifiers, transaction dates, source systems, and points.

## Technologies and Techniques

- SQLite
- Common Table Expressions (CTEs)
- GROUP BY
- COUNT(DISTINCT)
- SUM()
- LAG() Window Function
- ROUND()
- NULLIF()
- Date manipulation with SUBSTR()

## Analysis Process

The analysis is divided into three main stages:

1. **Monthly Aggregation:** Groups transactions by month and source system, calculating total transactions, unique customers, and total points.

2. **Previous Month Comparison:** Uses the LAG() window function to retrieve the transaction volume from the previous available month within each source system.

3. **Percentage Change:** Calculates the percentage increase or decrease in transaction volume compared with the previous available month.

## Key Metrics

- **Total Transactions:** Number of distinct transactions recorded per channel and month.
- **Unique Customers:** Number of distinct customers with recorded transactions.
- **Total Points:** Sum of points recorded during the period.
- **Monthly Growth Rate:** Percentage change in transaction volume compared with the previous available month.

## Limitations

- The first recorded month of each channel has no previous period available for comparison.
- Missing months may cause LAG() to compare nonconsecutive calendar months.
- Transaction points are not treated as monetary revenue.
- The analysis measures transaction activity rather than customer retention.

## Conclusion

This project demonstrates how SQL can be used to organize transactional data, calculate business performance indicators, and analyze changes over time.

By combining aggregations, CTEs, and window functions, the analysis provides a structured foundation for evaluating transaction channel performance.