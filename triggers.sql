USE pharmacymanagement;

-- Trigger to Update Order Status (Update order status when order details change)
DELIMITER //
CREATE TRIGGER update_order_status AFTER UPDATE ON order_details FOR EACH ROW
BEGIN
  IF NEW.Status = 'Canceled' THEN
    UPDATE orders
    -- If an order detail is canceled, update the total amount in the order accordingly
    SET Total_Amount = Total_Amount - (SELECT Price FROM drugs WHERE Drug_ID = NEW.MedicationID) * NEW.Quantity
    WHERE Order_ID = NEW.OrderID;
  END IF;
END;
//
DELIMITER ;

-- Trigger to Update Inventory on Drug Purchase (Increase quantity in inventory when drugs are purchased)
DELIMITER //
CREATE TRIGGER update_inventory_after_purchase
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
  IF NEW.Quantity IS NOT NULL AND NEW.MedicationID IS NOT NULL AND NEW.TransactionType = 'In' THEN
    UPDATE inventory
    -- Increase the quantity of the drug in the inventory
    SET Quantity = Quantity + NEW.Quantity
    WHERE MedicationID = NEW.MedicationID;
  END IF;
END;
//
DELIMITER ;

-- Trigger to Update Inventory on Drug Sale (Decrease quantity in inventory when a drug is sold)
DELIMITER //
CREATE TRIGGER update_inventory_after_sale
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  IF NEW.Quantity IS NOT NULL AND NEW.DrugID IS NOT NULL THEN
    UPDATE inventory
    -- Decrease the quantity of the drug in the inventory
    SET Quantity = Quantity - NEW.Quantity
    WHERE MedicationID = NEW.DrugID;
  END IF;
END;
//
DELIMITER ;

-- Trigger to Update Total Amount in Orders (Update the total amount in the orders table when adding order items)
DELIMITER //
CREATE TRIGGER update_total_amount
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
  -- Update the total order amount when new order items are added
  UPDATE orders
  SET Total_Amount = Total_Amount + (SELECT Price FROM drugs WHERE Drug_ID = NEW.DrugID) * NEW.Quantity
  WHERE Order_ID = NEW.OrderID;
END;
//
DELIMITER ;

