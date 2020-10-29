json.extract! digital_payment, :id, :name, :last_name, :number_phone, :payment_method, :created_at, :updated_at
json.url digital_payment_url(digital_payment, format: :json)
