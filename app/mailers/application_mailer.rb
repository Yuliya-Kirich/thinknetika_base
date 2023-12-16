class ApplicationMailer < ActionMailer::Base
  default from: %("TestGuru" <from@example.com>)
  layout 'mailer'
end
