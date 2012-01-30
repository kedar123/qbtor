class Invoice < ActiveRecord::Base
   
  def self.quickbook_invoice_import(xml)
     if !xml['QBXMLMsgsRs'].blank?
      xml['QBXMLMsgsRs']['InvoiceQueryRs']['InvoiceRet'].each do |invoice|
          logger.info "totally sending the invoic454eq"
        self.call_invoice_save(invoice)
          logger.info "totally sending the invoic454e78"
          
      end  
    elsif  !xml['QBXML'].blank?    
      xml['QBXML']['QBXMLMsgsRs']['InvoiceQueryRs']['InvoiceRet'].each do |invoice|
         logger.info "totally sending the invoice"
        self.call_invoice_save(invoice)
           logger.info "totally sending the invoic454e"
      end
    end
  end
  
  def self.call_invoice_save(invoice)
    logger.info "some invoice "
    logger.info invoice
    if invoice.class == Hash
    acin = AccountInvoice.search([['transaction_id', '=', "#{invoice['TxnID']}"]])[0]
    if acin.blank?
    acin = AccountInvoice.new
    logger.info "some invoice 666"
     acin.journal_id = 15
    respid = ResPartner.search([['name', '=', "#{invoice['CustomerRef']['FullName'].split(':')[0]}"]])[0]
    acin.partner_id = respid
      logger.info "some invoice 666"
     acin.address_invoice_id =  ResPartnerAddress.find(:all,:domain => [[:partner_id ,'=', respid]])[0].id if ResPartnerAddress.find(:all,:domain => [[:partner_id ,'=', respid]])[0]
    acin.currency_id = 1
      logger.info "some invoice 666"
     accountid = AccountAccount.search([['name', '=', "#{invoice['ARAccountRef']['FullName']}"]])[0]
       
     if accountid.blank?
       accountid = self.call_account_create(invoice['ARAccountRef']['FullName'].split(':')[0])
     else
       
     end 

    acin.account_id = accountid
    acin.transaction_id = invoice['TxnID']
    acin.save
      logger.info "some invoice 666"
     taxrate = invoice['SalesTaxPercentage']
    taxname = ""
    taxname = invoice['ItemSalesTaxRef']['FullName']    if invoice['ItemSalesTaxRef']  
    taxid = ""
      logger.info "some invoice 666"
    actid = ""
    if invoice['InvoiceLineRet']
        self.save_invoice_line(invoice,accountid,taxname,taxrate,acin)
    elsif invoice['InvoiceLineGroupRet']
        self.save_invoice_line(invoice['InvoiceLineGroupRet'],accountid,taxname,taxrate,acin)
    else
      logger.info "always there are some errors"
    end
       logger.info "some invoice 666"
   
    end
   end
    end
  

   def self.save_invoice_line(invoice,accountid,taxname,taxrate,acin)
       logger.info "some invoice fgfg6663e"
  
           if invoice['InvoiceLineRet'].class == Array
               logger.info "some invodffdie3ce 666"
  
           
         invoice['InvoiceLineRet'].each do |lit|
           
         logger.info "some inwevoice er666"
         if lit.class == Hash
           logger.info "some inweevoiererce 666"
          acinl = AccountInvoiceLine.new
           prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{lit['ItemRef']['FullName']}"]])[0]  if lit[ "ItemRef"]
           logger.info "some invoiwddcerre 666"
          if prodid.class == Array
            logger.info "some invoicewss 64566"
            acinl.product_id =  prodid[0].id if prodid
          end
           acinl.quantity = lit["Quantity"]  
           logger.info "some invoice gffwwsgt666"
          acinl.quantity = 1 if lit["Quantity"].blank? or lit["Quantity"] == "0" or lit["Quantity"] == "0.00"
          acinl.price_unit = lit["Rate"] if lit["Rate"]
          acinl.account_id = accountid
          logger.info "some invoice4545t wws666"
           acinl.name = lit['ItemRef']['FullName'] if lit['ItemRef']
          acinl.invoice_id = acin.id
          logger.info "some invoicefg45 ws666"
           if lit['ItemRef']  
            if lit['ItemRef']['FullName']  
              acinl.save
            end
           end
          logger.info "some invoice trt5wss666"
           if lit['SalesTaxCodeRef']
             logger.info "some invoice 656wws666"
              istax = lit['SalesTaxCodeRef']['FullName'] if lit['SalesTaxCodeRef']
              logger.info istax
              if istax == 'Tax' 
                if !taxname.blank?
                  logger.info "some invoice45wss45 666"
                  taxid = AccountTax.search([['name','=',"#{taxname}"]])[0]
                  logger.info taxname
                  logger.info "taxnameee"
                  logger.info AccountTax.search([['name','=',"#{taxname}"]])
                   if taxid.blank?
                     logger.info "blank hererere"
                      atn = AccountTax.new
                      atn.name = taxname
                      logger.info "some in344voisswce 666"
                      atn.amount = taxrate.to_f / 100
                      atn.type = 'percent'
                      atn.save
                      logger.info "tax is created"
                      logger.info atn.id
                      taxid = atn.id
                   end
              end   
              end
           end 
            acinl.quick_book_tax_id = taxid
            logger.info taxid
            logger.info "my tax id"
             if istax == 'Tax' 
               acinl.invoice_line_tax_id = [taxid] 
             end
            logger.info "some invoice 6ssw6236"
             if lit['ItemRef']  
                logger.info "some invoice 6ssw623654"
              if  lit['ItemRef']['FullName']    
                 logger.info "some invoice 6ssw623456"
                acinl.save
                 logger.info "some invoice 6ssw645236"
              end
            end 
            logger.info "some invoice 6ssw6236"
            begin
            acin.wkf_action('button_reset_taxes')
            rescue
            logger.info "there is always error"
            end
         else
           logger.info "invoice line return in not an hash"
          end
 
       end
           else
             if  invoice['InvoiceLineRet'].class == Hash
              self.save_hash_invoice_line_item(invoice,accountid,acin,taxname)
             else
               logger.info "this is my invoice and value is zero"
             end
      end
   end
  
    
  
  
    def self.save_hash_invoice_line_item(invoice,accountid,acin,taxname)
           logger.info "some invodffdice 6646"
           logger.info "some invoice er6646"
           logger.info "some invoiererce 666"
            acinl = AccountInvoiceLine.new
              prodid = ProductProduct.find(:all,:domain => [[:name ,'=', "#{invoice['InvoiceLineRet']['ItemRef']['FullName']}"]])[0]     if invoice['InvoiceLineRet']['ItemRef']
              logger.info "some invoicerre 666"
              if prodid.class == Array
               logger.info "some invoice 64566"
               acinl.product_id =  prodid[0].id if prodid
              end
              logger.info "some invoice gffgt666"
              if  invoice['InvoiceLineRet'] 
                if  invoice['InvoiceLineRet']['Quantity'] 
                 acinl.quantity =  invoice['InvoiceLineRet']['Quantity']  
                else
                acinl.quantity = 1
                end
              end

              acinl.price_unit =  invoice['InvoiceLineRet']['Rate']
              acinl.account_id = accountid
              logger.info "some invoice4545t 666"
              acinl.name =  invoice['InvoiceLineRet']['ItemRef']['FullName']         
              acinl.invoice_id = acin.id
              logger.info "some invoicefg45 666"
              if invoice['InvoiceLineRet']['ItemRef']   
                if invoice['InvoiceLineRet']['ItemRef']['FullName']  
                  acinl.save
                end
              end
              logger.info "some invoice trt5666"
              if  invoice['InvoiceLineRet']['SalesTaxCodeRef']  
              logger.info "some invoice 656666"
               istax = invoice['InvoiceLineRet']['SalesTaxCodeRef']['FullName']   if invoice['InvoiceLineRet']['SalesTaxCodeRef']
               logger.info "some invoice 65667566"
               logger.info istax
               logger.info istax.class
               
                if istax == 'Tax' 
                  logger.info "some invoice 65664866"
                  if !taxname.blank?
                   logger.info "some invoice4545 666"
                    taxid = AccountTax.search([['name','=',"#{taxname}"]])[0]
                   if taxid.blank?
                      atn = AccountTax.new
                      atn.name = taxname
                      logger.info "some in344voice 666"
                      atn.amount = taxrate.to_f / 100
                      atn.type = 'percent'
                      atn.save
                      taxid = atn.id
                   end
                  end   
                end
               end 
            acinl.quick_book_tax_id = taxid
             if istax == 'Tax' 
                acinl.invoice_line_tax_id = ["#{taxid}"]
             end
             if invoice['InvoiceLineRet']['SalesTaxCodeRef']   
              if  invoice['InvoiceLineRet']['SalesTaxCodeRef']['FullName']    
                acinl.save
              end
            end
            begin
            acin.wkf_action('button_reset_taxes')
            rescue
              logger.info "always there is error"
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

  
