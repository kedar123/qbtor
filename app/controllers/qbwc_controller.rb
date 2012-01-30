# This controller implements the seven web callback methods for QBWC
# Check qbwc_api.rb file for descriptions of parameters and return values
class QbwcController < ApplicationController
  require 'rubygems'
  require 'soap/rpc/driver'
  require 'xmlsimple'
 
  before_filter :set_soap_header
  
  # --- [ QBWC server version control ] ---
  # Expects:
  #   * string ticket  = A GUID based ticket string to maintain identity of QBWebConnector 
  # Returns string: 
  #   * Return a string describing the server version and any other information that you want your user to see.
  def serverVersion(ticket)
    logger.info "im in the serverversion"
    'Describe your app version here...'
  end

  # --- [ QBWC version control ] ---
  # Expects:
  #   * string strVersion = QBWC version number
  # Returns string: 
  #   * NULL or <emptyString> = QBWC will let the web service update
  #   * "E:<any text>" = popup ERROR dialog with <any text>, abort update and force download of new QBWC.
  #   * "W:<any text>" = popup WARNING dialog with <any text>, and give user choice to update or not.  
  def clientVersion(version)
    logger.info "im in the client version"
    nil # support any version
  end

  # --- [ Authenticate web connector ] ---
  # Expects: 
  #   * string strUserName = username from QWC file
  #   * string strPassword = password
  # Returns string[2]: 
  #   * string[0] = ticket (guid)
  #   * string[1] =
  #       - empty string = use current company file
  #       - "none" = no further request/no further action required
  #       - "nvu" = not valid user
  #       - any other string value = use this company file             
  def authenticate(username, password)

    if (QuickbooksImportStatus.find_by_token("Kedar.pathak@pragtech.co.in"))
    else 
      QuickbooksImportStatus.create(:username=>"",:password=>"",:token=>"kedar.pathak@pragtech.co.in",:returnqid=>25,:querystatus=>"")
    end
    [ 'Kedar.pathak@pragtech.co.in', "" ]
  
  end
 
  # --- [ To facilitate capturing of QuickBooks error and notifying it to web services ] ---
  # Expects: 
  #   * string ticket  = A GUID based ticket string to maintain identity of QBWebConnector 
  #   * string hresult = An HRESULT value thrown by QuickBooks when trying to make connection
  #   * string message = An error message corresponding to the HRESULT
  # Returns string:
  #   * "done" = no further action required from QBWebConnector
  #   * any other string value = use this name for company file
  def connectionError(ticket, hresult, message)
    'done'
  end

  # --- [ Facilitates web service to send request XML to QuickBooks via QBWC ] ---
  # Expects:
  #   * int qbXMLMajorVers
  #   * int qbXMLMinorVers
  #   * string ticket
  #   * string strHCPResponse 
  #   * string strCompanyFileName 
  #   * string Country
  #   * int qbXMLMajorVers
  #   * int qbXMLMinorVers
  # Returns string:
  #   * "any_string" = Request XML for QBWebConnector to process
  #   * "" = No more request XML
  def sendRequestXML(ticket, hpc_response, company_file_name, country, qbxml_major_version, qbxml_minor_version)
 
     sendquery = QuickbooksImportStatus.find_by_token("kedar.pathak@pragtech.co.in")
    if  !(sendquery.continueid.to_s.blank? )
      logger.info "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww45"
        if sendquery.querystatus == "TransactionQueyRq"
           
        logger.info "sds45s4d5s4d5s4"
        logger.info  sendquery
        maxreturn = 2
        logger.info "im nil herererere"
        logger.info sendquery.iteratorremaining
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 2
        if  sendquery.iteratorremaining.to_i   > 0  
          builder = Builder::XmlMarkup.new
          xml = builder.TransactionQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn); }
        else
          
             xml = <<-REQUEST
                  <EmployeeQueryRq requestID="c1">
                  </EmployeeQueryRq>
        REQUEST

        sendquery.querystatus = "employeequery"
        sendquery.returnqid = 92
        sendquery.save
        sendquery.returnqid = 91
        sendquery.continueid = ""
        sendquery.save  
           
        end
      end  
      
       if sendquery.querystatus == "billquery"
        maxreturn = 2
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 2
        if  sendquery.iteratorremaining   > 0
          builder = Builder::XmlMarkup.new
          xml = builder.BillQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn);b.IncludeLineItems(true) }      
        else
          
           xml = <<-REQUEST
            <TransactionQueryRq requestID="1"   iterator="Start">
                  <MaxReturned>5</MaxReturned>
              </TransactionQueryRq>
          REQUEST
        sendquery.querystatus = "TransactionQueyRq"
        sendquery.returnqid = 30
        sendquery.save
        sendquery.iteratorremaining = nil
        sendquery.continueid = ""
        sendquery.save  
         
         end
      end
     if sendquery.querystatus == "vendorquery"
        maxreturn = 5
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 5
        if  sendquery.iteratorremaining.to_i   > 0  
          builder = Builder::XmlMarkup.new
          xml = builder.VendorQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn); }
        else
           xml = <<-REQUEST
              <InvoiceQueryRq   iterator="Start">
                  <MaxReturned>2</MaxReturned>
                <IncludeLineItems>true</IncludeLineItems>
                 
              </InvoiceQueryRq>
        REQUEST
        logger.info "the invoice query send"
        sendquery.querystatus = "InvoiceQueryRq"
        sendquery.returnqid = 85
        sendquery.save
        sendquery.iteratorremaining = nil
        sendquery.continueid = ""
        sendquery.save  
        
        end
      end 

      
       if sendquery.querystatus == "InvoiceQueryRq"
        maxreturn = 2
         logger.info "im not nil here"
         logger.info  sendquery.iteratorremaining
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 2
        if  sendquery.iteratorremaining   > 0
          builder = Builder::XmlMarkup.new
          xml = builder.InvoiceQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn);b.IncludeLineItems(true) }      
        else
         
              
           xml = <<-REQUEST
                  <BillQueryRq requestID="2"  iterator="Start">
                  <MaxReturned>2</MaxReturned>
                    <IncludeLineItems>true</IncludeLineItems>
                    <IncludeLinkedTxns>true</IncludeLinkedTxns>
                  </BillQueryRq>
        REQUEST
        sendquery.querystatus = "billquery"
        sendquery.returnqid = 90
        sendquery.save    
        sendquery.iteratorremaining = nil
        sendquery.continueid = ""
        sendquery.save  

        end

      end
    
      if sendquery.querystatus == "customerqueryreq"
        maxreturn = 5
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 5
        if  sendquery.iteratorremaining.to_i   > 0  
          builder = Builder::XmlMarkup.new
          xml = builder.CustomerQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn); }
        else
          xml = <<-REQUEST
              <VendorQueryRq requestID="1">
              </VendorQueryRq>
          REQUEST
          sendquery.querystatus = "vendorquery"
          sendquery.returnqid = 89
          sendquery.iteratorremaining = nil
          sendquery.continueid = ""
          sendquery.save  
  
        end
      end

      
     
      
      if sendquery.querystatus == "itemquery"
        maxreturn = 5
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 5
        if  sendquery.iteratorremaining   > 0
          builder = Builder::XmlMarkup.new
          xml = builder.ItemQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn); }      
        else
         
         xml = <<-REQUEST
          <CustomerQueryRq requestID="27" iterator="Start">
                  <MaxReturned>5</MaxReturned>
          </CustomerQueryRq>
          REQUEST
          sendquery.querystatus = "customerqueryreq"
          sendquery.returnqid = 70
          sendquery.save
          sendquery.iteratorremaining = nil
          sendquery.continueid = ""
          sendquery.save
        
        end
      end 
       
      
      if sendquery.querystatus == "accountquery"
        maxreturn = 3
        maxreturn = sendquery.iteratorremaining  if sendquery.iteratorremaining < 3
        if  sendquery.iteratorremaining   > 0
          builder = Builder::XmlMarkup.new
          xml = builder.AccountQueryRq(:iterator=>"Continue",:iteratorID=>sendquery.continueid) { |b| b.MaxReturned(maxreturn); }      
        else
         xml = <<-REQUEST
              <ItemQueryRq requestID="255" iterator="Start">
                    <MaxReturned>5</MaxReturned>
              </ItemQueryRq>
        REQUEST
        sendquery.querystatus = "itemquery"
        sendquery.returnqid = 20
        sendquery.save
        sendquery.iteratorremaining = nil
        sendquery.continueid = ""
        sendquery.save  
        end
      end 
      
      
      
      
      
      
      
    else
      logger.info "sksnsjsksjsn123"
      if sendquery.querystatus == ""
        xml = <<-REQUEST
            <CompanyQueryRq requestID="25855">
            </CompanyQueryRq>
        REQUEST
        sendquery.querystatus = "companyquery"
        sendquery.returnqid = 10
        sendquery.save
     elsif sendquery.querystatus == "companyquery"
        
           xml = <<-REQUEST
              <ItemQueryRq requestID="255" iterator="Start">
                    <MaxReturned>5</MaxReturned>
              </ItemQueryRq>
        REQUEST
        sendquery.querystatus = "itemquery"
        sendquery.returnqid = 20
        sendquery.save 
        
        
        
      
      
      elsif sendquery.querystatus == "itemquery"
      
             xml = <<-REQUEST
              <CustomerQueryRq requestID="27" iterator="Start">
                    <MaxReturned>5</MaxReturned>
              </CustomerQueryRq>
        REQUEST
        sendquery.querystatus = "customerqueryreq"
        sendquery.returnqid = 70
        sendquery.save
    
            
        
        
        
      elsif sendquery.querystatus == "customerqueryreq"
        
             xml = <<-REQUEST
              <VendorQueryRq requestID="1" iterator="Start">
                  <MaxReturned>5</MaxReturned>
              </VendorQueryRq>
        REQUEST
        sendquery.querystatus = "vendorquery"
        sendquery.returnqid = 89
        sendquery.save 
             
   
      elsif sendquery.querystatus == "vendorquery"
        xml = <<-REQUEST
              <InvoiceQueryRq   iterator="Start">
                  <MaxReturned>2</MaxReturned>
                <IncludeLineItems>true</IncludeLineItems>
                 
              </InvoiceQueryRq>
        REQUEST
        sendquery.querystatus = "InvoiceQueryRq"
        sendquery.returnqid = 85
        sendquery.save
      elsif sendquery.querystatus == "InvoiceQueryRq"
         
                xml = <<-REQUEST
                  <BillQueryRq requestID="2"  iterator="Start">
                  <MaxReturned>2</MaxReturned>
                    <IncludeLineItems>true</IncludeLineItems>
                    <IncludeLinkedTxns>true</IncludeLinkedTxns>
                  </BillQueryRq>
        REQUEST
        sendquery.querystatus = "billquery"
        sendquery.returnqid = 90
        sendquery.save     
             
      elsif sendquery.querystatus == "billquery"
         
      xml = <<-REQUEST
              <TransactionQueryRq requestID="1"  iterator="Start">
                    <MaxReturned>2</MaxReturned>
                </TransactionQueryRq>
        REQUEST
        sendquery.querystatus = "TransactionQueyRq"
        sendquery.returnqid = 18
        sendquery.save
            
        
      elsif  sendquery.querystatus == "TransactionQueyRq" 
         
        xml = <<-REQUEST
                  <EmployeeQueryRq requestID="c1">
                  </EmployeeQueryRq>
        REQUEST

        sendquery.querystatus = "employeequery"
        sendquery.returnqid = 92
        sendquery.save
        
     elsif sendquery.querystatus == "employeequery"   
       
      #  xml = <<-REQUEST
      #            <EntityQueryRq requestID="4">
   #
    #               </EntityQueryRq>
    #     REQUEST
    #    there is no need to call entity query because it returns customers
    #    sendquery.querystatus = "entityquery"
    #    sendquery.returnqid = 93
    #    sendquery.save
        #    there is no need to call entity query because it returns customers
       xml = <<-REQUEST
              <GeneralSummaryReportQueryRq>
                <GeneralSummaryReportType>ProfitAndLossStandard
                </GeneralSummaryReportType>
                <ReportPeriod>
                    <FromReportDate>2015-01-01</FromReportDate>
                    <ToReportDate>2016-01-15</ToReportDate>
                </ReportPeriod>
                <SummarizeColumnsBy>Month</SummarizeColumnsBy>
              </GeneralSummaryReportQueryRq>  
         REQUEST
         
        sendquery.querystatus = "profitandloss"
        sendquery.returnqid = 94
        sendquery.save
        
       elsif sendquery.querystatus == "profitandloss"   
        xml=""
        sendquery.querystatus = "Import Completed"
        sendquery.returnqid = 100
        sendquery.save
     elsif sendquery.querystatus == "Import Completed"
        xml = ""
     end
    end
     
      
     
    
    logger.info "xml request sendqqqq"
    logger.info  wrap_qbxml_request(xml)
    wrap_qbxml_request(xml)
  end

  # --- [ Facilitates web service to receive response XML from QuickBooks via QBWC ] ---
  # Expects:
  #   * string ticket
  #   * string response
  #   * string hresult
  #   * string message
  # Returns int:
  #   * Greater than zero  = There are more request to send
  #   * 100 = Done. no more request to send
  #   * Less than zero  = Custom Error codes
  #this method will
  def receiveResponseXML(ticket, response, hresult, message)
     logger.info "it is come herererer1255"  
      
     logger.info  User.find(:last).id
     # current_user = User.find(:last);
    #set_current_user(User.find(:last), :update_login_timestamp => true)
     logger.info "it is come herererer22"  
    sendquery = QuickbooksImportStatus.find_by_token("kedar.pathak@pragtech.co.in")
    logger.info "it is come herererer33"  
    @xml = XmlSimple.xml_in(response, { 'ForceArray' => false })
    logger.info @xml
    if !@xml['QBXMLMsgsRs'].blank?
       logger.info "rrrrrrrrrrr"
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "TransactionQueryRs"
        logger.info "jhjhjhjhjjjhjjjjjjjjjjjh"
        sendquery.continueid = @xml['QBXMLMsgsRs']["TransactionQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["TransactionQueryRs"]["iteratorRemainingCount"]
        sendquery.save
        Txaction.quickbook_transaction_import(ticket,@xml)
      end  
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "CustomerQueryRs"
        sendquery.continueid = @xml['QBXMLMsgsRs']["CustomerQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["CustomerQueryRs"]["iteratorRemainingCount"]
        sendquery.save
        MerchantInfo.quickbook_customer_import(@xml)
      end
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "InvoiceQueryRs"
        logger.info "invoice is saved"
        sendquery.continueid = @xml['QBXMLMsgsRs']["InvoiceQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["InvoiceQueryRs"]["iteratorRemainingCount"]
        sendquery.save
        Invoice.quickbook_invoice_import(@xml)
       end
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "BillQueryRs"
        sendquery.continueid = @xml['QBXMLMsgsRs']["BillQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["BillQueryRs"]["iteratorRemainingCount"]
        sendquery.save
    
        Bill.quickbook_bill_import(ticket,@xml)
      end
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "CompanyQueryRs"
           logger.info "im here because here the company will be requested"
        Company.quickbook_company_import(ticket,@xml)
      end
       
       
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "ItemQueryRs"
        sendquery.continueid = @xml['QBXMLMsgsRs']["ItemQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["ItemQueryRs"]["iteratorRemainingCount"]
        sendquery.save

        Item.quickbook_item_import(ticket,@xml)
      end
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "VendorQueryRs"
            logger.info "caling vendor query"
             sendquery.continueid = @xml['QBXMLMsgsRs']["VendorQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["VendorQueryRs"]["iteratorRemainingCount"]
        sendquery.save
        MerchantInfo.quickbook_vendor_import(@xml)
      end
      
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "ItemSalesTaxQueryRs"
            logger.info "caling ItemSalesTaxQueryRq query"
             Salestax.quickbook_sales_tax_import(@xml)
      end      
       
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "AccountQueryRs"
            logger.info "account q res"
            sendquery.continueid = @xml['QBXMLMsgsRs']["AccountQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXMLMsgsRs']["AccountQueryRs"]["iteratorRemainingCount"]
        sendquery.save
             if sendquery.querystatus == 'accountquery'
               Account.call_account_save(@xml)
             else
                   Account.call_account_type_save(@xml)
                 
             end
             
      end         
      
        
        
       
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "EmployeeQueryRs"
            logger.info "Employee queryyy"
              Employee.quickbook_employee_import(@xml)
      end
      
      if @xml['QBXMLMsgsRs'].keys[0].to_s == "PreferencesQueryRs"
              logger.info "Preference query response"
              Preference.quickbook_preference_import(@xml)
      end
      
      
      
      
      
      
    else
       logger.info "im herererfff34"
      if !@xml['QBXML'].blank?
        logger.info "wwwwwww2w"
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "CompanyQueryRs"
           logger.info "ccccccccc"
          Company.quickbook_company_import_parse(ticket,@xml)
        end
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "ItemQueryRs"
        sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["ItemQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["ItemQueryRs"]["iteratorRemainingCount"]
        sendquery.save
          Item.quickbook_item_import(ticket,@xml)
        end
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "TransactionQueryRs"
          sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["TransactionQueryRs"]["iteratorID"]
          sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["TransactionQueryRs"]["iteratorRemainingCount"]
          sendquery.save
          Txaction.quickbook_transaction_import(ticket,@xml)
        end
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "CustomerQueryRs"
        sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["CustomerQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["CustomerQueryRs"]["iteratorRemainingCount"]
        sendquery.save
          MerchantInfo.quickbook_customer_import(@xml)
        end
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "InvoiceQueryRs"
          logger.info "invoice is saved"
          sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["InvoiceQueryRs"]["iteratorID"]
          sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["InvoiceQueryRs"]["iteratorRemainingCount"]
          sendquery.save
           Invoice.quickbook_invoice_import(@xml)
         end
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "BillQueryRs"
        sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["BillQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["BillQueryRs"]["iteratorRemainingCount"]
        sendquery.save
          Bill.quickbook_bill_import(ticket,@xml)
        end
        if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "VendorQueryRs"
          sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["VendorQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["VendorQueryRs"]["iteratorRemainingCount"]
        sendquery.save
          MerchantInfo.quickbook_vendor_import(@xml) 
        end
        
         if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "ItemSalesTaxQueryRs"
            logger.info "caling ItemSalesTaxQueryRq query"
             Salestax.quickbook_sales_tax_import(@xml)
         end    
     
         if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "AccountQueryRs"
        sendquery.continueid = @xml['QBXML']['QBXMLMsgsRs']["AccountQueryRs"]["iteratorID"]
        sendquery.iteratorremaining = @xml['QBXML']['QBXMLMsgsRs']["AccountQueryRs"]["iteratorRemainingCount"]
        sendquery.save
       
                  if sendquery.querystatus == 'accountquery'
                    Account.call_account_save(@xml)
                  else
                        Account.call_account_type_save(@xml)
                       
                  end
         end                
         
         if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "EmployeeQueryRs"
            logger.info "Employee queryyy4545"
              Employee.quickbook_employee_import(@xml)
         end
         
      if @xml['QBXML']['QBXMLMsgsRs'].keys[0].to_s == "PreferencesQueryRs"
              logger.info "Preference query response"
              Preference.quickbook_preference_import(@xml)
      end
         
       end
    end
    sendquery = QuickbooksImportStatus.find_by_token("kedar.pathak@pragtech.co.in")
     sendquery.returnqid
  end


  # --- [ Facilitates QBWC to receive last web service error ] ---
  # Expects:
  #   * string ticket
  # Returns string:
  #   * error message describing last web service error
  def getLastError(ticket)
    logger.info "im in get last error"
    'An error occurred'
  end

  # --- [ QBWC will call this method at the end of a successful update session ] ---
  # Expects:
  #   * string ticket 
  # Returns string:
  #   * closeConnection result. Ex: "OK"
  def closeConnection(ticket)
    logger.info "im closing the connection"
    'OK'
  end
  
   
  private
    
  # The W3C SOAP docs state (http://www.w3.org/TR/2000/NOTE-SOAP-20000508/#_Toc478383528):
  #   "The SOAPAction HTTP request header field can be used to indicate the intent of
  #    the SOAP HTTP request. The value is a URI identifying the intent. SOAP places
  #    no restrictions on the format or specificity of the URI or that it is resolvable.
  #    An HTTP client MUST use this header field when issuing a SOAP HTTP Request."
  # Unfortunately the QBWC does not set this header and ActionWebService needs 
  # HTTP_SOAPACTION set correctly in order to route the incoming SOAP request.
  # So we set the header in this before filter.
  def set_soap_header
    if request.env['HTTP_SOAPACTION'].blank? || request.env['HTTP_SOAPACTION'] == %Q("")
      xml = REXML::Document.new(request.raw_post)
      element = REXML::XPath.first(xml, '/soap:Envelope/soap:Body/*')
      request.env['HTTP_SOAPACTION'] = element.name if element
    end
  end

  # Simple wrapping helper
  def wrap_qbxml_request(body)
    r_start = <<-XML
<?xml version="1.0" ?>
<?qbxml version="5.0" ?>
<QBXML>
  <QBXMLMsgsRq onError="stopOnError">
    XML
    r_end = <<-XML
  </QBXMLMsgsRq>
</QBXML>
    XML
    r_start + body + r_end
  end
 


end
