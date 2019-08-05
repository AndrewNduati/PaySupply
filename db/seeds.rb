# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

supplier = Supplier.create({name: 'Wheat LTD',
                            account_number: '00000000000',
                            bank_name: '044',
                            recipient_code: 'RCP_8uppworlnuf5jqk',
                            contact:'07032068836' })

Invoice.create(amount: 1234, supplier:supplier, pay_status: 0)