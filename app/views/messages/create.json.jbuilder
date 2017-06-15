json.message do |json|
  json.name @message.user.name
  json.time @message.created_at.strftime("%Y/%m/%d/ %H:%M:%S")
  json.body @message.body
  json.image @message.image_url(:thumb).to_s
  json.id @message.id
end
