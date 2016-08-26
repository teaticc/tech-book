if Rails.env.test?
    CarrierWave.configure do |config|
        config.storage = :file
    end
else
    CarrierWave.configure do |config|
        config.fog_credentials = {
            provider: 'AWS',
            aws_access_key_id: ENV['ACCESS_KEY_ID'],
            aws_secret_access_key: ENV['SECRET_ACCESS_KEY'],
            region: 'ap-northeast-1',
            endpoint: "https://s3-ap-northeast-1.amazonaws.com"
        }
        case Rails.env
        when 'development'
            config.fog_directory  = 'tech-book-heroku.production/development'
        when 'production'
            config.fog_directory  = 'tech-book-heroku.production'
        end
    end
end
