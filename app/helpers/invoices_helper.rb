module InvoicesHelper
  def paid_invoice(invoice)
    if invoice.pay_status == 'paid'
      'Paid'
    else
      link_to 'Pay', pay_invoice_path(:id => invoice.id)
    end
  end
end
