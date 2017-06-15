
json.(@messages) do |message|
  json.id    message.id
  json.name  message.user.name
  json.body  message.body
  json.image message.image.url(:thumb).to_s
  json.time  message.created_at.strftime('%F %T')
end
