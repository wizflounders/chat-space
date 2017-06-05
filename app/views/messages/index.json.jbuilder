json.array! @messages do |message|
  json.name message.user.name
  json.time message.time
  json.body message.body
  json.image message.image.url
end
