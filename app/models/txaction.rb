class Txaction < ActiveRecord::Base
  
 

  #this method will import all the transactions into the Txaction table and TxactionTagging table.
  #for finding the  tag_id first it will find a tag  into the tag table if its did not find it then 
  #it will search it in qbtag table. if it did not find the tag id then in log fill it will print tag name 
  #if its find a tag id then it will search weather this transaction is already there in the transaction table or not 
  #if its not then it will create it else it will not create it. this is for avoiding the duplication of entry.
  #before this it will find or create an account for quickbook as per the email sent to me 
  def self.quickbook_transaction_import(token,xml) 
     
    if !xml['QBXMLMsgsRs'].blank?
      if !xml['QBXMLMsgsRs']['TransactionQueryRs']['TransactionRet'].blank?
        xml['QBXMLMsgsRs']['TransactionQueryRs']['TransactionRet'].each do |transaction|
         self.call_transaction_save(transaction,token)
         #logger.info transaction
         #logger.info "i got trans"
        end
      end
    elsif  !xml['QBXML'].blank?
      if !xml['QBXML']['QBXMLMsgsRs']['TransactionQueryRs']['TransactionRet'].blank?
        xml['QBXML']['QBXMLMsgsRs']['TransactionQueryRs']['TransactionRet'].each do |transaction|
          #logger.info transaction
          #logger.info "i got th etrans"
          self.call_transaction_save(transaction,token)
       end
      end  
    end
  end
  
 
  
  def self.call_transaction_save(transaction,token)
    
   if transaction.class == Hash
 
    acv = AccountVoucher.search([['transaction_id', '=', "#{transaction['TxnID']}"]])[0]
    if acv.blank?
    journalid = AccountJournal.search([['code', '=', "QJT"]])[0]  
    
    
    logger.info "this is transaction"
    logger.info transaction
    acv = AccountVoucher.new
    acv.transaction_id = transaction['TxnID'] 
    logger.info "ssssssssssssssssssss"
    respid = ResPartner.search([["name", "=", "#{transaction['EntityRef']['FullName'].split(':')[0]}" ] ])[0] if transaction['EntityRef'] 
    acv.partner_id = respid
    acv.journal_id = journalid
    logger.info "wwwwwwwwwwwwwwwwwwwwwwwwwww"
    accountid = AccountAccount.search([['name', '=', "#{transaction['AccountRef']['FullName'].split(':')[0]}"]])[0] if transaction['AccountRef'] 
     if accountid.blank?
       accountid = self.call_account_create(transaction['AccountRef']['FullName'].split(':')[0])
     else
       
     end 
    
    acv.account_id = accountid
    acv.date = transaction['TxnDate'] 
    acv.narration = transaction['Memo']
    acv.amount = transaction['Amount'].to_i
    acv.save

    avl = AccountVoucherLine.new
    avl.voucher_id = acv.id
    avl.amount = transaction['Amount']
    avl.type='cr'
    avl.account_id = accountid
    avl.save
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
