class Item < ActiveRecord::Base
  
  
  #this is just for storing the item into the table
  def self.quickbook_item_import(token,xml)
    if !xml['QBXMLMsgsRs'].blank?
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemServiceRet'].blank?
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemServiceRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end  
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemNonInventoryRet'].blank?
            
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemNonInventoryRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemOtherChargeRet'].blank?
            
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemOtherChargeRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryRet'].blank?
           
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryRet'].each do |itemservice|
         self.call_item_save(itemservice,token)
       end
     end
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryAssemblyRet'].blank?
           
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryAssemblyRet'].each do |itemservice|
         if  itemservice.class.to_s == "Array"
            self.call_item_save_by_name(itemservice[1],token)   if   itemservice[0] == "Name"
          else
            self.call_item_save(itemservice,token)    
        end
        end
      end
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemFixedAssetRet'].blank?
            
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemFixedAssetRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
           
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemSubtotalRet'].blank?
      
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemSubtotalRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
            
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemDiscountRet'].blank?
      
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemDiscountRet'].each do |itemservice|
          if  itemservice.class.to_s == "Array"
            self.call_item_save_by_name(itemservice[1],token)   if   itemservice[0] == "Name"
          else
            self.call_item_save(itemservice,token)    
          end
        end
      end
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemPaymentRet'].blank?
      
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemPaymentRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxRet'].blank?
              
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
     end
             
      if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxGroupRet'].blank?
      
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxGroupRet'].each do |itemservice|
          if  itemservice.class.to_s == "Array"
            self.call_item_save_by_name(itemservice[1],token)   if   itemservice[0] == "Name"
          else
            self.call_item_save(itemservice,token)
          end
      end
     end
     if !xml['QBXMLMsgsRs']['ItemQueryRs']['ItemGroupRet'].blank?
             
        xml['QBXMLMsgsRs']['ItemQueryRs']['ItemGroupRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
    elsif  !xml['QBXML'].blank?
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemServiceRet'].blank?
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemServiceRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
     end
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemNonInventoryRet'].blank?
               
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemNonInventoryRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end     
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemOtherChargeRet'].blank?
         
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemOtherChargeRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryRet'].blank?
            
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryAssemblyRet'].blank?
              
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemInventoryAssemblyRet'].each do |itemservice|
          if  itemservice.class.to_s == "Array"
            self.call_item_save_by_name(itemservice[1],token)   if   itemservice[0] == "Name"
          else
            self.call_item_save(itemservice,token)    
          end
        end
      end
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemFixedAssetRet'].blank?
          
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemFixedAssetRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
          
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemSubtotalRet'].blank?
         
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemSubtotalRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
     if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemDiscountRet'].blank?
          
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemDiscountRet'].each do |itemservice|
          if  itemservice.class.to_s == "Array"
            self.call_item_save_by_name(itemservice[1],token)   if   itemservice[0] == "Name"
          else
            self.call_item_save(itemservice,token)    
          end
       end
      end
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemPaymentRet'].blank?
          
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemPaymentRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
          
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxRet'].blank?
        
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxRet'].each do |itemservice|
          self.call_item_save(itemservice,token)
        end
      end
        
      if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxGroupRet'].blank?
        
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemSalesTaxGroupRet'].each do |itemservice|
          if  itemservice.class.to_s == "Array"
            self.call_item_save_by_name(itemservice[1],token)   if   itemservice[0] == "Name"
          else
            self.call_item_save(itemservice,token)
          end
        end
      end
     if !xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemGroupRet'].blank?
      
        xml['QBXML']['QBXMLMsgsRs']['ItemQueryRs']['ItemGroupRet'].each do |itemservice|
         self.call_item_save(itemservice,token)
        end
     end      
      
     if true
       logger.info "im always true but i can not parse it1111111"
       logger.info xml['QBXMLMsgsRs']['ItemQueryRs']
       logger.info "im always true but i can not parse it222222222"
       logger.info xml['QBXMLMsgsRs']
       
       
     end 
      
      
    else
      logger.info "im totally blank"
      logger.info xml['QBXMLMsgsRs']
    end
     # sinv = StockInventory.find(1, :context => {:name => 'Starting Inventory'})
     # sinv.wkf_action('action_cancel_inventory')
     # sinv.wkf_action('action_cancel_draft')
     # sinv.wkf_action('action_confirm')
     #sinv.wkf_action('action_done')
       

    
  end
    
    
  def self.call_item_save(itemservice,token)
      
      stock_location_id = StockLocation.search([['name', '=', "Stock"]])[0]
      if stock_location_id
      else
          logger.info "wwwwwwwwwwwwwwwwww"
          stockl = StockLocation.new()
          stockl.name = 'Stock'
          stockl.save
          stock_location_id = stockl.id
      end
     logger.info "this is stock location idddd"
     logger.info stock_location_id
     uom = ProductUomCateg.search([['name', '=', "Unit"]])[0]   
     if uom
      else
          puc = ProductUomCateg.new
          puc.name = 'Unit'
          puc.save
          uom = puc.id 
      end 
      pctg = ProductCategory.search([['name', '=', "All products"]])[0]
      if pctg
   
      else
          pcg = ProductCategory.new
          pcg.name = 'All products'
          pcg.save
          pctg = pcg.id 
      end

      sinv = StockInventory.search([['name', '=', "Starting Inventory"]])[0]
      if  sinv
      else
           si = StockInventory.new
          si.name = 'Starting Inventory'
          si.save
          sinv = si.id
      end
      move_location_id = StockLocation.search([['name', '=', "Inventory loss"]])[0]
      if  move_location_id
      else
           ml = StockLocation.new
          ml.name = 'Inventory loss'
          ml.save
          move_location_id = ml.id
      end
  
      logger.info "this item i got"
      logger.info "this item i got65"
          
      logger.info itemservice
      oldid = ProductProduct.search([['name_template', '=', "#{itemservice["Name"]}"]])[0]  if itemservice.class == Hash 
      if oldid
        
      else
logger.info "this item i go4545t"
      if itemservice.class == Hash  
logger.info "this item i got"
      newp = ProductProduct.new
      newp.name_template = itemservice["Name"]
       
      logger.info "this item i got65"
      prtmp = ProductTemplate.new
      prtmp.name = itemservice["Name"]
      logger.info "itemservice"
      prtmp.description_purchase = itemservice["PurchaseDesc"]
      logger.info "this item i got65"
      prtmp.description_sale =  itemservice["SalesOrPurchase"]["Desc"] if itemservice["SalesOrPurchase"]
      prtmp.company_id =  1
      prtmp.type = "service"
      prtmp.supply_method = "buy"
      logger.info "this item i got65"
      prtmp.purchase_method = "make_to_order"
      prtmp.categ_id = pctg
      logger.info "itemservice12"
      if  !itemservice["PurchaseCost"].blank?
          prtmp.standard_price = itemservice["PurchaseCost"]       
      end
      if  !itemservice["SalesAndPurchase"].blank?
          prtmp.standard_price = itemservice["SalesAndPurchase"]["PurchaseCost"]      
      end
      if  !itemservice["SalesOrPurchase"].blank?
          prtmp.standard_price = itemservice["SalesOrPurchase"]["Price"]      
      end
      logger.info "this item i got65"
      prtmp.cost_method = "standard"
      prtmp.uom_id = uom
      logger.info "itemservice45"
      prtmp.uom_po_id = uom
       
      #prtmp.mes_type = "Fixed"
      prtmp.save
      newp.product_tmpl_id = prtmp.id
      newp.save
      psli = ProductSupplierinfo.new
      psli.company_id = 1
      logger.info "this item i got65777"
      psli.name = 1
      logger.info "this item i got65777"
      psli.min_qty = 0
      psli.delay = 0
      psli.product_id = prtmp.id
      logger.info "this item i got65774"
      psli.save
      logger.info "this item i got6574"
      logger.info "this item i got65"
      logger.info "98898"
      sm = StockMove.new
      sm.product_id = newp.id
      sm.product_qty = itemservice["QuantityOnSalesOrder"].to_i 
      logger.info "this is qty"
      sm.product_qty
      logger.info itemservice["QuantityOnSalesOrder"]
      #sm.product_qty = 0 if itemservice["QuantityOnSalesOrder"].to_i == 0
      logger.info "this is after "
      sm.product_uom = uom
      sm.location_id =  move_location_id  
      logger.info "stock location id"
      logger.info  move_location_id  
      logger.info "this item i got65"
      sm.name = "abcd"
      sm.location_dest_id =  stock_location_id    
      logger.info stock_location_id
      logger.info "moveeeeeeeeeeeeeeeee"
       
      logger.info "this item i got65"
      logger.info "5665654"
      logger.info "5ss665654"

      sm.save
      logger.info "ss22"
      
      sil = StockInventoryLine.new
      logger.info "ss22"
      
      sil.product_id = newp.id
      sil.product_uom = uom
      sil.company_id = 1
    logger.info "ss22"
        
    sil.inventory_id = sinv
      sil.location_id = stock_location_id
      sil.product_qty = itemservice["QuantityOnHand"].to_i  
    logger.info "ss22"
        
    sil.product_qty = 0 if sil.product_qty.blank?
      sil.save
      logger.info "565654"
      sinv = StockInventory.new
      sinv.company_id = 1
      sinv.name = itemservice["Name"]
      sinv.state = "done"
      sinv.save
       logger.info "this item i got65"
  
    else
     logger.info "not inserted" 
     logger.info itemservice
    end  
      
    end  

   
  end
  def self.call_item_save_by_name(name,token)
      stock_location_id = StockLocation.search([['name', '=', "Stock"]])[0]
       if stock_location_id
        else
          stockl = StockLocation.new()
          stockl.name = 'Stock'
          stockl.save
          stock_location_id = stockl.id
        end
      uom = ProductUomCateg.search([['name', '=', "Unit"]])[0]   
      if uom
      else
          puc = ProductUomCateg.new
          puc.name = 'Unit'
          puc.save
          uom = puc.id 
      end 
      pctg = ProductCategory.search([['name', '=', "All products"]])[0]
      if pctg
   
      else
          pcg = ProductCategory.new
          pcg.name = 'All products'
          pcg.save
          pctg = pcg.id 
      end
      sinv = StockInventory.search([['name', '=', "Starting Inventory"]])[0]
      if  sinv
      else
           si = StockInventory.new
          si.name = 'Starting Inventory'
          si.save
          sinv = si.id
      end
      move_location_id = StockLocation.search([['name', '=', "Inventory loss"]])[0]
      if  move_location_id
      else
           ml = StockLocation.new
          ml.name = 'Inventory loss'
          ml.save
          move_location_id = ml.id
      end
       
    logger.info "this itemmmms i got12121212"
    logger.info name
    logger.info "this item i got"
       logger.info "this item i got6588"
      newp = ProductProduct.new
      newp.name_template = name
       
      prtmp = ProductTemplate.new
      prtmp.name = name
      logger.info "this item i got6588"
      prtmp.company_id =  1
      prtmp.type = "service"
      prtmp.supply_method = "buy"
      prtmp.purchase_method = "make_to_order"
      prtmp.categ_id = pctg
      logger.info "itemservice12"
      logger.info "this item i got6588"
      
          prtmp.standard_price = 0
       
      
      prtmp.cost_method = "standard"
      prtmp.uom_id = uom
      logger.info "itemservice45"
      prtmp.uom_po_id = uom
      
      logger.info "this item i got6588"
      #prtmp.mes_type = "Fixed"
      prtmp.save
      newp.product_tmpl_id = prtmp.id
      newp.save
      logger.info "sadsadsad"
      psli = ProductSupplierinfo.new
      psli.company_id = 1
      psli.name = 1
      psli.min_qty = 0
      logger.info "this item i got6588"
      psli.delay = 0
      psli.product_id = prtmp.id
      psli.save
      sm = StockMove.new
      sm.product_id = newp.id
      sm.product_qty = 0
      sm.product_uom = uom
      sm.name = "abc"
      sm.location_dest_id =   stock_location_id
      sm.location_id =  move_location_id  
      logger.info "ddssfssdsd"
      sm.save
       sil = StockInventoryLine.new
      sil.product_id = newp.id
      logger.info "this item i got6588"
      sil.product_uom = uom
      sil.company_id = 1
      sil.inventory_id = sinv
      sil.location_id = stock_location_id
       
      sil.product_qty = 0  
      sil.save
      logger.info "asasasasas"
      sinv = StockInventory.new
      sinv.company_id = 1
      sinv.name = name
      sinv.state = "done"
      sinv.save
    
    
    
  end
  
end
