json.extract! transaction, :id, :monto, :metodo, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
