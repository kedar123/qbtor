class Bill < ActiveRecord::Base

   
  def self.quickbook_bill_import(token,xml)
    logger.info "111"
    logger.info xml 
    if !xml['QBXMLMsgsRs'].blank?
      logger.info "1112"
      if xml['QBXMLMsgsRs']['BillQueryRs']['BillRet'].class == Hash
        logger.info "1113"
        self.call_bill_save(xml['QBXMLMsgsRs']['BillQueryRs']['BillRet'],token,start_tag = "qbxmlmsgsrs",xml)
        logger.info "1114"
      else
        logger.info "1115"
        xml['QBXMLMsgsRs']['BillQueryRs']['BillRet'].each do |bill|
          logger.info "1116"
          self.call_bill_save(bill,token,start_tag = "qbxmlmsgsrs",xml)
          logger.info "1117"
        end
      end
    elsif !xml['QBXML'].blank?
      logger.info "1118"
      if xml['QBXML']['QBXMLMsgsRs']['BillQueryRs']['BillRet'].class ==  Hash
        logger.info "1119"
        self.call_bill_save(xml['QBXML']['QBXMLMsgsRs']['BillQueryRs']['BillRet'],token,start_tag = "qbxml",xml)
        logger.info "11110"
      else
        xml['QBXML']['QBXMLMsgsRs']['BillQueryRs']['BillRet'].each do |bill|
          logger.info "111122"
          self.call_bill_save(bill,token,start_tag = "qbxml",xml)  
          logger.info "1113"
        end
      end
    end
    
  end
     

  def self.call_bill_save(bill,token,start_tag,xml)
    logger.info bill
    logger.info "11114"
    if bill.class.to_s == "Hash"
      logger.info "11115"
      self.call_bill_save_data(bill,token,start_tag,xml)
    else
      logger.info "111116"
      logger.info "im here because of bill is arrayyyyyyyyyyy"
    end
  end
  
 
  
  
  def self.call_bill_save_data(bill,token,start_tag,xml)
    # begin
    logger.info "billlll14"
    logger.info bill
    acin = AccountInvoice.search([['transaction_id', '=', "#{bill['TxnID']}"]])[0]
    if acin.blank?
    acin = AccountInvoice.new
    logger.info "billlll65"
    acin.journal_id = 16
    logger.info "billll654l"
    acin.type = "in_invoice"
    respid = ResPartner.search([['name', '=', "#{bill['VendorRef']['FullName']}"]])[0]
    logger.info "billl845ll"
    acin.partner_id = respid
    logger.info "bill745lll"
    logger.info ResPartnerAddress.find(:all,:domain => [[:partner_id ,'=', respid]])[0].id 
    logger.info ResPartnerAddress.find(:all,:domain => [[:partner_id ,'=', respid]])[0] 
    acin.address_invoice_id =  ResPartnerAddress.find(:all,:domain => [[:partner_id ,'=', respid]])[0].id      if ResPartnerAddress.find(:all,:domain => [[:partner_id ,'=', respid]])[0]
    logger.info "bill785lll"
    acin.currency_id = 1
    logger.info "bill785qwslll"
    logger.info bill['APAccountRef']['FullName']
    logger.info "ssssss"
     accountid = AccountAccount.search([['name', '=', "#{bill['APAccountRef']['FullName']}"]])[0] 
    
     if accountid.blank?
       accountid = self.call_account_create(bill['APAccountRef']['FullName'].split(':')[0])
     else
       
     end 

    logger.info "bill78521lll"
    acin.account_id = accountid
    logger.info "bil75421llll"
    acin.save
    logger.info "bill8562lll"
    logger.info "11198798111"
    if bill['ItemLineRet']
      logger.info "billl452ll"  
      if bill['ItemLineRet'].class == Array
        logger.info "bill7458lll"
        if !bill['ItemLineRet'].blank?
          logger.info "billl745ll"
          if bill['ItemLineRet'].each do |bit|
              logger.info "bill7542lll"
              if bit.class == Hash 
                acinl = AccountInvoiceLine.new
                logger.info "bill7458lll"   
                prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{bit['ItemRef']['FullName'].split(":")[0]}"]])[0]  if bit[ "ItemRef"] 
       
                logger.info "billl7548ll"
                acinl.quantity =  bit['Quantity']
                if bit['Quantity'].to_i == 0
                  acinl.quantity = 1
                end
        
                acinl.price_unit = bit['Cost']
                logger.info "bill78542lll"
                acinl.invoice_id = acin.id
        
        
                acinl.account_id = accountid
                acinl.name = bit['ItemRef']['FullName'].split(":")[0]
                acinl.save
              end  
            end
          end
  
          
          if bill['ItemLineRet'].each do |bit|
              logger.info "11145"
              if bit.class == Hash 
                acinl = AccountInvoiceLine.new
                prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{bit['ItemRef']['FullName'].split(":")[0]}"]])[0]  if bit[ "ItemRef"] 
                logger.info "117451"
        
                acinl.quantity =  bit['Quantity']
         
                if  bit['Quantity'].to_i == 0
                  acinl.quantity = 1
                end     
        
                acinl.price_unit = bit['Cost']
                logger.info "114581"
                acinl.invoice_id = acin.id

                acinl.account_id = accountid
                logger.info "114581"
                acinl.name = bit['ItemRef']['FullName'].split(":")[0]
                logger.info "111452"
                acinl.save
                logger.info "11751"
              else
                logger.info "its not a hashhh"
              end  
            end
            logger.info "11451"
          end         
          
          
          
          
          
        end
      else
        logger.info "bill5232lll"
        if bill['ItemLineRet']
      
          logger.info "billl745ll"
          if bill['ItemLineRet'].class == Hash 
            acinl = AccountInvoiceLine.new
         
            logger.info "billl754ll"
            prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{bill['ItemLineRet']['ItemRef']['FullName'].split(":")[0]}"]])[0]  if bill['ItemLineRet'][ "ItemRef"] 
       
   
            acinl.quantity =  bill['ItemLineRet']['Quantity']
   
            if bill['ItemLineRet']['Quantity'].to_i == 0
              acinl.quantity = 1
            end 
   
            logger.info "bill5454lll"
            acinl.price_unit = bill['ItemLineRet']['Cost']
            logger.info "billl9898ll"
            acinl.invoice_id = acin.id
            acinl.account_id = accountid
            acinl.name = bill['ItemLineRet']['ItemRef']['FullName'].split(":")[0]
            acinl.save
            logger.info "billl9879ll"
          else
            logger.info "not hashgfgfgf"
          end
        end
     
      end
    else
      #logic of expense line return
       logger.info "bill523ssss2lll"
        if bill['ExpenseLineRet']
      
          logger.info "billssl745ll"
          if bill['ExpenseLineRet'].class == Hash 
            acinl = AccountInvoiceLine.new
         
            logger.info "billl7ss54ll"
            prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{bill['ExpenseLineRet']['ItemRef']['FullName'].split(":")[0]}"]])[0]  if bill['ExpenseLineRet'][ "ItemRef"] 
       
   
            acinl.quantity =  bill['ExpenseLineRet']['Quantity']
   
            if bill['ExpenseLineRet']['Quantity'].to_i == 0
              acinl.quantity = 1
            end 
   
            logger.info "bill545ss4lll"
            acinl.price_unit = bill['ExpenseLineRet']['Amount']
            logger.info "billlss9898ll"
            acinl.invoice_id = acin.id
            accountid = AccountAccount.search([['name', '=', "#{bill['ExpenseLineRet']['AccountRef']['FullName'].split(':')[0]}"]])[0]
             
            if accountid.blank?
                 accountid = self.call_account_create(bill['ExpenseLineRet']['AccountRef']['FullName'].split(':')[0])
            else
       
            end 
            acinl.account_id = accountid
            acinl.name = bill['ExpenseLineRet']['AccountRef']['FullName'].split(':')[0] if bill['ExpenseLineRet']['AccountRef']
            acinl.save
            logger.info "billl98sss79ll"
          else
            logger.info "not hashsssgfgfgf arayyyyyy"
            if bill['ExpenseLineRet'].class == Array
              bill['ExpenseLineRet'].each do |bill|
                   acinl = AccountInvoiceLine.new
         
            logger.info "billl7sshhh54ll"
            prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{bill['ItemRef']['FullName'].split(":")[0]}"]])[0]  if bill[ "ItemRef"] 
       
   
            acinl.quantity =  bill['Quantity']
   
            if bill['Quantity'].to_i == 0
              acinl.quantity = 1
            end 
   
            logger.info "bill545ss4lhhhll"
            acinl.price_unit = bill['Amount']
            logger.info "billlss9898lkkkl"
            acinl.invoice_id = acin.id
            accountid = AccountAccount.search([['name', '=', "#{bill['AccountRef']['FullName'].split(':')[0]}"]])[0]
            if accountid.blank?
                 accountid = self.call_account_create(bill['AccountRef']['FullName'].split(':')[0])
            else
       
            end

            acinl.account_id = accountid
            
            acinl.name = bill['AccountRef']['FullName'].split(':')[0] if bill['AccountRef']
            acinl.save
            logger.info "billl98ssskkk79ll"
              end
            end
          end
        end
      
    end
    end
  end
  
  
    def self.call_account_create(namee)
    uniquecode = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

    newac = AccountAccount.new
    newac.name = namee
    newac.code =  rand(123456).to_s+uniquecode[rand(26)].to_s+uniquecode[rand(26)].to_s+uniquecode[rand(26)].to_s
    newac.user_type = 1
    newac.save
    newac.id
   end
 
  
end
