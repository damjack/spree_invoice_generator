module Spree
  require 'erb'
  class InvoicePrint < ActiveRecord::Base
    belongs_to :user
    belongs_to :order

    def generate_pdf
      @order        = self.order 
      html_template = File.open(File.expand_path(File.dirname(__FILE__)+"/../..") + "/views/invoice_prints/invoice_template.html.erb").read
      self.update_attribute(:counter, self.counter + 1)
      WickedPdf.new.pdf_from_string(ERB.new(html_template).result(binding).html_safe)
    end
  end
end
