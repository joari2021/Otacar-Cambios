json.extract! mobile_payment, :id, :country, :bank, :number_phone, :document, :created_at, :updated_at
json.url mobile_payment_url(mobile_payment, format: :json)
