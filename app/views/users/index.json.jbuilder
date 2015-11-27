json.array!(@users) do |user|
  json.extract! user, :id, :name, :uin, :email, :password
  json.url user_url(user, format: :json)
end
