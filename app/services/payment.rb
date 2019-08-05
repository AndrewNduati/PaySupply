 class Payment
    include HTTParty

    base_uri 'https://api.paystack.co'

    HEADERS = {
        :Authorization => "Bearer #{Rails.application.credentials.paystack_test_key}",
        :'Content-Type' => 'application/json'
    }

     # Returns bank names and codes
     def get_banks
       response = self.class.get('/bank', {:headers => HEADERS}).parsed_response

       if response["status"]
         banks = Array.new(response["data"])
         # Should refactor to a more Ruby way.
         banks.map do |x|
           x.extract!("slug",
                    "longcode",
                    "gateway",
                    "pay_with_bank",
                    "active",
                    "is_deleted",
                    "country",
                    "currency",
                    "id",
                    "type",
                    "createdAt",
                    "updatedAt")
         end
       end
       banks
     end

     # Creating Supplier recipient.
     def create_recipient(name, account_number, bank_code)
      response = HTTParty.post('https://api.paystack.co/transferrecipient',
                               :headers => HEADERS,
                               :body => {:type => 'nuban',
                                         :name => name,
                                         :account_number => account_number,
                                         :bank_code => bank_code
                               }.to_json)
      response
     end

     # Creates a Transfer to supplier
     def create_transfer(recipient_code, amount)

       kobo = amount.to_i*100

       transfer = HTTParty.post('https://api.paystack.co/transfer',
                               :headers => HEADERS,
                               :body => {
                                   :amount => kobo,
                                   :recipient => recipient_code
                               }.to_json)
       transfer
     end

     #  Get all successful transfers
     def get_transfers
       response = self.class.get('/transfer', {:headers => HEADERS}).parsed_response

       if response["status"]
         transfers = Array.new(response["data"])
         # Should refactor to a more Ruby way.
         transfers.map do |x|
           x.extract!("currency",
                      "domain",
                      "failures",
                      "id",
                      "integration",
                      "reason",
                      "source",
                      "source_details",
                      "titan_code",
                      "metadata")
         end
       end
       transfers
     end
   private
   #  Checks for valid account.
   def check_account
     response = HTTParty.get('https://api.paystack.co/bank/resolve?account_number=0022728151&bank_code=063',
                             {:headers => HEADERS}).parsed_response
   end
  end
