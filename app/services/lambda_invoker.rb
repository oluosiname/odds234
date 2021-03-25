class LambdaInvoker < ApplicationService
  def initialize(func: , async: , payload: "{}")
    @func = func
    @async = async
  end


  def call
    args = { function_name: @func, payload: @payload }
    args.merge({ invocation_type: "Event" }) if @async
    resp = client.invoke(args)

    puts resp

    puts resp.to_h
  end

  private

  def client
    @client ||= Aws::Lambda::Client.new(
      region: 'us-east-1',
      access_key_id: Rails.application.credentials.aws[:access_key_id],
      secret_access_key: Rails.application.credentials.aws[:secret_access_key]
    )
  end
end