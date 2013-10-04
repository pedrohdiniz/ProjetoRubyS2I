json.array!(@friends) do |friend|
  json.extract! friend, :name, :id_friend
  json.url friend_url(friend, format: :json)
end
