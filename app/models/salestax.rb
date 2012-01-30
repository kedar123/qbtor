class Salestax < ActiveRecord::Base
  
  def self.quickbook_sales_tax_import(xml)
    
#     if !xml['QBXMLMsgsRs'].blank?
#      xml['QBXMLMsgsRs']['ItemSalesTaxQueryRs']['ItemSalesTaxRet'].each do |itemsalestax|
#        
#          st = Salestax.new
#          st.name = itemsalestax['Name']
#          st.taxrate = itemsalestax['TaxRate']  
#          st.listid = itemsalestax['ListID']
#          st.save 
#      end  
#    elsif  !xml['QBXML'].blank?    
#      xml['QBXML']['QBXMLMsgsRs']['ItemSalesTaxQueryRs']['ItemSalesTaxRet'].each do |itemsalestax|
#       
#         st = Salestax.new
#         st.name = itemsalestax['Name']
#         st.taxrate = itemsalestax['TaxRate']
#         st.listid = itemsalestax['ListID']
#         st.save
#      end
#    end
    
  end

end
 
