class DeviseMailer < Devise::Mailer
  def headers_for(action, opts)
    super.merge!(template_path: 'devise/mailer')
  end
end