class Account < ActiveRecord::Base
  
 def self.call_account_save(xml)
    logger.info "xxxxxx"
    if !xml['QBXMLMsgsRs'].blank?
       if xml['QBXMLMsgsRs']['AccountQueryRs']['AccountRet']
            xml['QBXMLMsgsRs']['AccountQueryRs']['AccountRet'].each do |ac|
              self.account_save(ac)
           end
       elsif !xml['QBXML'].blank?
       if xml['QBXML']['QBXMLMsgsRs']['AccountQueryRs']['AccountRet'] 
          xml['QBXML']['QBXMLMsgsRs']['AccountQueryRs']['AccountRet'] .each do |ac|
                 self.account_save(ac)
         end
         
       end
    end
 end
 
   logger.info "this is listtttt"
  
end

 
 
def self.call_account_type_save(xml)

    logger.info "xxxxxx"
    if !xml['QBXMLMsgsRs'].blank?
       if xml['QBXMLMsgsRs']['AccountQueryRs']['AccountRet']
            xml['QBXMLMsgsRs']['AccountQueryRs']['AccountRet'].each do |ac|
              self.account_type_save(ac)
           end
       elsif !xml['QBXML'].blank?
       if xml['QBXML']['QBXMLMsgsRs']['AccountQueryRs']['AccountRet'] 
          xml['QBXML']['QBXMLMsgsRs']['AccountQueryRs']['AccountRet'] .each do |ac|
                 self.account_type_save(ac)
         end
         
       end
    end
 end
 
   logger.info "this is listtttt"
  
end 
 
 
 
 
 
 def self.account_save(ac)

  uniquecode = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
   logger.info "11"
   actyid = ""
   actyid = AccountAccountType.search([['name','=', "#{ac['AccountType']}"]])[0]
    newac = AccountAccount.new
   newac.name = ac['Name']
   newac.code = ac['AccountNumber']
   newac.code = rand(123456).to_s+uniquecode[rand(26)].to_s+uniquecode[rand(26)].to_s+uniquecode[rand(26)].to_s
      logger.info "1165654"
    if ac['ParentRef'] 
      pacid = AccountAccount.search([['name','=', "#{ac['ParentRef']['FullName']}"]])[0]
      newac.parent_id = pacid
    end
    newac.type = "other"
     newac.user_type = actyid  
    newac.active = true
   newac.save
    logger.info "1198987"
  
     
 end
  
 def self.account_type_save(ac)
sendquery = QuickbooksImportStatus.find_by_token("kedar.pathak@pragtech.co.in")
sendquery.continueid = ac['ListID']
sendquery.save
  uniquecode = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
    
   actyid = ""
   #actyid = AccountAccountType.search([['name','=', "#{ac['AccountType']}"]])[0]
   #if actyid.blank?
     acty = AccountAccountType.new
       logger.info "1122"
      acty.name = ac['AccountType']
     acty.code =  rand(123456).to_s+uniquecode[rand(26)].to_s+uniquecode[rand(26)].to_s+uniquecode[rand(26)].to_s
      
     if ac['AccountType'].to_s.include?('Expense')
      acty.report_type = 'expense'
     
     elsif ac['AccountType'].to_s.include?('Bank')
      acty.report_type = 'none'
     elsif ac['AccountType'].to_s.include?('Bank')
      acty.report_type = 'none'
     
     elsif ac['AccountType'].to_s.include?('Receivable')
      acty.report_type = 'income'
     
     elsif ac['AccountType'].to_s.include?('Asset')
      acty.report_type = 'asset'
     
     elsif ac['AccountType'].to_s.include?('Liability')
      acty.report_type = 'liability'
     end
     if ac['AccountType'].to_s.include?('CreditCard')
      acty.report_type = 'none'
     
     elsif ac['AccountType'].to_s.include?('Income')
      acty.report_type = 'income'
     
     elsif ac['AccountType'].to_s.include?('CostOfGoodsSold')
      acty.report_type = 'income'
      
   else
       acty.report_type = 'none'
     end
     
       logger.info "1551"
      acty.close_method = 'none'
      acty.save
   #  actyid = acty.id
   #else
   #end
    
  
     
 end
 
 
 
end
