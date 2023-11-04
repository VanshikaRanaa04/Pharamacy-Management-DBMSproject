USE pharmacymanagement;

-- Get the current inventory status for each drug
SELECT drugs.Drug_Name, SUM(inventory.Quantity) AS Current_Inventory
FROM drugs
JOIN inventory ON drugs.Drug_ID = inventory.MedicationID
GROUP BY drugs.Drug_Name;

-- Calculate the total sales by gender of patients
SELECT patients.Gender, SUM(orders.Total_Amount) AS Total_Sales
FROM patients
JOIN prescriptions ON patients.PatientID = prescriptions.PatientID
JOIN drugs ON prescriptions.MedicationID = drugs.Drug_ID
JOIN order_items ON drugs.Drug_ID = order_items.DrugID
JOIN orders ON order_items.OrderID = orders.Order_ID
GROUP BY patients.Gender;

-- Calculate the success rate of orders (canceled vs. successful)
SELECT CASE order_details.Status WHEN 'Success' THEN 'Successful' ELSE 'Canceled' END AS Order_Status, COUNT(*) AS Order_Count
FROM order_details
GROUP BY Order_Status;

-- Retrieve the top N drugs with the highest total sales
SELECT drugs.Drug_Name, SUM(order_items.Quantity) AS Total_Sales
FROM drugs
JOIN order_items ON drugs.Drug_ID = order_items.DrugID
JOIN orders ON order_items.OrderID = orders.Order_ID
GROUP BY drugs.Drug_Name
ORDER BY Total_Sales DESC;


-- Analyze the distribution of customer spending
SELECT customers.Customer_Name, SUM(orders.Total_Amount) AS Total_Spending
FROM customers
JOIN orders ON customers.Customer_ID = orders.Customer_ID
GROUP BY customers.Customer_Name
ORDER BY Total_Spending DESC;


