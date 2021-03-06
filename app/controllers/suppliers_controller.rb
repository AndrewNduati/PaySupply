class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :update, :destroy]

  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.all
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show
    @supplier
  end

  # GET /suppliers/new
  def new
    @banks = Payment.new
    @bank_names = @banks.get_banks
    @supplier = Supplier.new
  end

  # GET /suppliers/1/edit
  def edit
    @bank_names = Payment.new.get_banks
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)
    @recipient = Payment.new.create_recipient(supplier_params[:name],
                                              supplier_params[:account_number],
                                              supplier_params[:bank_name])
    # Add the created recipient on PayStack.
    @supplier.recipient_code = @recipient['data']['recipient_code']

    respond_to do |format|
      if @supplier.save && @recipient['status'] == true
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render :show, status: :created, location: @supplier }
      else
        format.html do  redirect_to new_supplier_url,
                                    notice: "There were errors saving you supplier. #{@recipient['message']}"
        end
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /suppliers/1
  # PATCH/PUT /suppliers/1.json
  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplier }
      else
        format.html { render :edit }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplier_params
      params.require(:supplier).permit(:name, :account_number, :bank_name, :contact)
    end
end
