json.extract! wallet_with_user, :id, :country, :name, :last_name, :user, :wallet_name, :created_at, :updated_at
json.url wallet_with_user_url(wallet_with_user, format: :json)
