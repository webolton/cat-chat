json.extract! author, :id, :email, :name, :created_at, :updated_at
json.url author_url(author, format: :json)
