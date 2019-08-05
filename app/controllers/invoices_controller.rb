class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :payment, :pay]

  # GET /invoices
  # GET /invoices.json
  def index
   if  params[:supplier_id].present?
     @invoices = Supplier.find(params[:supplier_id]).invoices
   else
     @invoices = Invoice.all
   end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # Render Payment page
  def payment
    @supplier = @invoice.supplier
     render 'payment'
  end

  # All transfers
  def transfers
    @transfers = Payment.new.get_transfers
    @transfers
  end

  # Pay invoice off
  def pay
    @supplier = @invoice.supplier
    @account_details = Payment.new.create_transfer(@supplier.recipient_code,
                                                   @invoice.amount)
    if @account_details['data']['status'] == 'success'
      @invoice.update(:pay_status => 1)
      redirect_to supplier_invoices_path(:supplier_id => @supplier.id), notice: 'Invoice is being processed.'
    else
      render payment, notice: "Transfer not complete. Reason #{@account_details['message']}"
    end
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to supplier_invoices_path, notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_path, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:amount, :supplier_id, :pay_status)
    end
end
# Thou shall not scaffold blindly