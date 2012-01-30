class Company < ActiveRecord::Base
  
  
  def self.quickbook_company_import(token,xml)
 #    logger.info "im inserting here the xmllll"
 #      logger.info xml
 #   @oor =  Ooor.new(:url => 'http://192.168.1.40:8069/xmlrpc', :database => 'Temp1', :username =>
 #    'admin', :password => 'admin')
 

 #   logger.info "5555555555754"
 #   logger.info xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyName']
 #      logger.info "55555555557"
 #   logger.info "im fom company database"
 #   resc = ResCompany.new
 #   logger.info resc.methods
 #   logger.info resc.attributes
    
    #company = self.find(:first,:conditions=>["name = ?",xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyName']])
 #   logger.info "im fom company database"
   # if company.blank?
#      logger.info "im fom company database"
#      company = ResCompany.new
#       logger.info xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyName']
#       logger.info "55555555"
#      company.name = xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyName']
#      company.contact_name_first = "contact name first"
#      company.contact_name_last = "Contact Name Last"
#      company.email = xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['Email']
#      company.email = "abc"+rand(100).to_s+"@gmail.com" if company.email.blank?
#      company.state = xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']['State'] if# xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']
#      company.city = xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']['City'] if ##xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']
#      company.telephone = xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['Phone']
#      company.fax = xml['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['Fax']
#      company.save
#      role = Role.new
#      role.company_id = company.id
#      role.role = 1
#      current_user = User.find_by_email("kedar.pathak@pragtech.co.in")
#      role.user_id = current_user.id
#      role.sender_id = current_user.id
#      role.recipient_email = current_user.email
#      role.save
#      subscription = Subscription.new
#      subscription.first_name = "demo name"
#      subscription.full_number = "526548"
#      subscription.last_name = "demo"
#      subscription.card_type = "visa"
#      subscription.company_id = company.id
#      subscription.save
#             
    #end
#    qbimst = QuickbooksImportStatus.find_by_token(token)
#    qbimst.company_id = company.id
#    qbimst.save
  end
  
  def self.quickbook_company_import_parse(token,xml)
 #      logger.info "im inserting here the xmllll"
 #      logger.info xml
 #       @oor =  Ooor.new(:url => 'http://localhost:8069/xmlrpc', :database => 'mybase', :username =>
 #    'admin', :password => 'admin')
 #   
 #    logger.info "5555555555775"
 #   logger.info xml['QBXML']['CompanyQueryRs']['CompanyRet']['CompanyName']
 #      logger.info "555555555547"
 #   company = Company.find(:first,:conditions=>["name = ?",xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['#CompanyRet']['CompanyName']])
     
#    if company.blank?
 #     
 #     company = self.new
 #     company.name = xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyName']
       
 #     company.contact_name_first = "contact name first"
 #     company.contact_name_last = "Contact Name Last"
 #     company.email = xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['Email']
 #     company.email = "abc"+rand(100).to_s+"@gmail.com" if company.email.blank?
 #     company.state = xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']['State'] if xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']
 #     company.city = xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']['City'] if xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['CompanyAddressForCustomer']
 #     company.telephone = xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['Phone']
 #     company.fax = xml['QBXML']['QBXMLMsgsRs']['CompanyQueryRs']['CompanyRet']['Fax']
 #     company.save
 #     role = Role.new
 #     role.company_id = company.id
 #     role.role = 1
 #     current_user = User.find_by_email("kedar.pathak@pragtech.co.in")
 #     role.user_id = current_user.id
 #     role.sender_id = current_user.id
 #     role.recipient_email = current_user.email
 #     role.save
 #     subscription = Subscription.new
 #     subscription.first_name = "demo name"
 #     subscription.full_number = "526548"
 #     subscription.last_name = "demo"
 #     subscription.card_type = "visa"
 #     subscription.company_id = company.id
 #     subscription.save
 #           
 #   else

 #   end
 #   qbimst = QuickbooksImportStatus.find_by_token(token)
 #   qbimst.company_id = company.id
 #   qbimst.save
  
  end
  
  
end