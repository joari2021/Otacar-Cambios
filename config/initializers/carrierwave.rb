CarrierWave.configure do |config|
    config.fog_provider = 'fog/google'
    config.fog_credentials = {
        provider:                         'Google',
        google_storage_access_key_id:     'GOOGLQSP3IDOW3BGYA3SPWVU',
        google_storage_secret_access_key: 'SyuRk+V6FJwegdAbVWYytRb9zsK048MPiwGuWjhc'
    }
    config.fog_directory = 'bucket-img-otacarcambios'
end