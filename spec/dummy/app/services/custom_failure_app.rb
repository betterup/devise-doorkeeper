class CustomFailureApp < Devise::FailureApp
  # test that sublclassing FailureApp works properly
  def respond
    super
    Rails.logger.info('Testing error flow')
  end
end
