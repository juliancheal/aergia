class NotificationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  
  def create
    sns = Aws::SNS::Client.new(region: 'us-east-1')  
    notif = JSON.parse(request.body.read)
    case notif['Type']
      when "SubscriptionConfirmation"
        sns.confirm_subscription(topic_arn: notif['TopicArn'],
                                  token: notif['Token'],
                                  authenticate_on_unsubscribe: 'true')
      when "UnsubscribeConfirmation"
        return '200'
      when "Notification"
        puts notif['Message']
      else
        puts notif
    end
    render nothing: true
  end
end
