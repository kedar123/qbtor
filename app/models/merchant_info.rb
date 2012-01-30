 
class MerchantInfo < ActiveRecord::Base
 
  
  
  def self.quickbook_customer_import(xml)
    if !xml['QBXMLMsgsRs'].blank?
      xml['QBXMLMsgsRs']['CustomerQueryRs']['CustomerRet'].each do |customer|
        self.call_customer_save(customer)
      end
    elsif  !xml['QBXML'].blank?
      xml['QBXML']['QBXMLMsgsRs']['CustomerQueryRs']['CustomerRet'].each do |customer|
        self.call_customer_save(customer)
      end
    end
  end
  
  def self.call_customer_save(customer)
    begin
    oldid = ResPartner.search([['name', '=', "#{customer['Name']}"]])[0]
      if oldid.blank?
     respart = ResPartner.new
     if customer.class == Hash
     if customer["ParentRef"].blank?  
     
      
     respart.name = customer['Name'] if customer['Name']
     respart.phone = customer['Phone'] if customer['Phone']
     respart.email = customer['Email'] if customer['Email']
     respart.company_id = 1
     respart.customer = true
     respart.supplier = false
     
     
     respart.save
     
     respartadd = ResPartnerAddress.new
     respartadd.partner_id = respart.id
     #respartadd.name = customer['Name']
     respartadd.phone = customer['Phone'] if customer['Phone']
     respartadd.email = customer['Email'] if customer['Email']
     
     respartadd.city = customer['BillAddress']['City'] if customer['BillAddress']['City']
     respartadd.zip =  customer['BillAddress']['PostalCode'] if customer['BillAddress']['PostalCode']
     respartadd.street =  customer['BillAddress']['Addr1'] + " " +customer['BillAddress']['Addr2'] if customer['BillAddress'] and customer['BillAddress']['Addr1'] and customer['BillAddress']['Addr2']
     respartadd.country =  customer['BillAddress']['State'] 
   
     respartadd.save
     
     end
     end 
      end
    rescue => e
      logger.info "there is some error"
      logger.info e
    end
    
     
  end
  
  def self.quickbook_vendor_import(xml)
            
    if !xml['QBXMLMsgsRs'].blank?
      xml['QBXMLMsgsRs']['VendorQueryRs']['VendorRet'].each do |vendor|
        self.call_vendor_save(vendor)
      end
              
    elsif  !xml['QBXML'].blank?    
      xml['QBXML']['QBXMLMsgsRs']['VendorQueryRs']['VendorRet'].each do |vendor|
        self.call_vendor_save(vendor)
      end
              
    end 
          
          
       
  end
  
  def self.call_vendor_save(vendor)
    begin
    if vendor.class == Hash
         respart = ResPartner.new
     
      
     respart.name = vendor["Name"] if vendor["Name"]
     respart.phone = vendor["Phone"] if vendor["Phone"]
     respart.email = vendor["Email"] if vendor["Email"]
     respart.company_id = 1
     respart.supplier = true
     respart.customer = false
     
      
     respart.save
     respartadd = ResPartnerAddress.new
     respartadd.partner_id = respart.id
     #respartadd.name = vendor['Name']
     respartadd.phone = vendor["Phone"] if vendor["Phone"]
     respartadd.email = vendor["Email"] if vendor["Email"]
     respartadd.city = vendor["BillAddress"]["City"] if vendor["BillAddress"] and vendor["BillAddress"]["City"]
     respartadd.zip =  vendor["BillAddress"]["PostalCode"] if vendor["BillAddress"] and vendor["BillAddress"]["PostalCode"]
     respartadd.street =  vendor["BillAddress"]["Addr1"] + " "+vendor["BillAddress"]["Addr2"] if vendor["BillAddress"] and vendor["BillAddress"]["Addr1"] and vendor["BillAddress"]["Addr2"]
     respartadd.country =  vendor["BillAddress"]["State"]  if vendor["BillAddress"] and vendor["BillAddress"]["State"]
   
     respartadd.save
     
    end  
   
   
  
    rescue => e
      logger.info "there is some error"
      logger.info e
    end
      
  end
  
    
   
  
  

end
