 class Payment
    include HTTParty

    base_uri 'https://api.paystack.co'

    HEADERS = {
        :Authorization => "Bearer #{Rails.application.credentials.paystack_test_key}",
        :'Content-Type' => "application/json"
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
      response = HTTParty.post("https://api.paystack.co/transferrecipient",
                               :headers => HEADERS,
                               :body => {:type => 'nuban',
                                         :name => name,
                                         :account_number => account_number,
                                         :bank_code => bank_code
                               }.to_json)
      response
     end

     # Confirms Name of supplier
     def create_transfer

     end
  end
#
# x = Payment.new()
#
# puts x.get_banks