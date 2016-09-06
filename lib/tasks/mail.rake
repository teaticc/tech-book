namespace :mail do
  desc "reminder mail process"
  task reminder_mail: :environment do
    dealings = Dealing.where(paid: false)
    dealings.each do |dealing|
      DealingMailer.reminder(dealing).deliver_now
    end
  end
end
