require File.expand_path(File.dirname(__FILE__) + "/environment")

set :output, "log/contab.log"

set :environment, [:production, :development]

every 1.day, at: "13:45" do
  rake "mail:reminder_mail"
end
