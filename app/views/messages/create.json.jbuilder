json.array! @messages do |message|
  json.name message.user.name
  json.created_at message.created_at.strftime("%Y/%m/%d/ %H:%M:%S")
  json.body message.body
  json.image message.image.url(:thumb).to_s
end
