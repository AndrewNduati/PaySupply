Rails.application.routes.draw do

  resources :suppliers do
    resources :invoices, shallow: true
  end

  # Render the invoice page
  get '/pay-invoice/', to: 'invoices#payment'
  get '/payment/', to: 'invoices#pay'
  get '/transfers/', to: 'invoices#transfers'
end
