json.extract! wallet, :id, :name, :last_name, :email, :country, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
