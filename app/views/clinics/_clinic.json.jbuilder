json.extract! clinic, :id, :name, :address, :latitude, :longitude, :mobile, :created_at, :updated_at
json.url clinic_url(clinic, format: :json)