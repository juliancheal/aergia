class NotificationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  
  def create
    message = AWS::SNS::Message.new(request.body.read)
    case message.type.to_s
      when "SubscriptionConfirmation"
        sns = Aws::SNS::Client.new(region: 'us-east-1')
        sns.confirm_subscription(topic_arn: message.topic_arn,
                                token: message.token,
                                authenticate_on_unsubscribe: 'true')
      when "UnsubscribeConfirmation"
      when "Notification"
        parsed = JSON.parse(message.message)
        records = []
        parsed['Records'].each do |record|
          value = {}
          value[:bucket]    = record['s3']['bucket']['name']
          value[:file_name] = record['s3']['object']['key']
          value[:size]      = record['s3']['object']['size']
          records << value
        end
        records.each do |record|
          EncoderWorker.perform_async(record, 5)
        end
      else
    end
    render nothing: true
  end
end
