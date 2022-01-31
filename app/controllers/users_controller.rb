class UsersController < ApplicationController

  def index
  end

  def search_result
    self.send_log

    @user = User.new(id: user_params[:id])
    @user_json_data = self.json_data(@user.generate_user_url)

    if @user_json_data.blank?
      flash[:alert] = "ユーザーが存在しません"
      return render("users/index")
    end
    @user.name = @user_json_data["attributes"]["name"]

    self.set_accounts
  end

  private
  def json_data(url)
    uri = URI.parse(url)
    res = Net::HTTP.get_response(uri)
    return if res.body.blank?

    JSON.parse(res.body)
  end

  def set_accounts
    @accounts = []
    @sum = 0
    account_json_data = self.json_data(@user.generate_accounts_url)

    account_json_data.each do |account_json|
      account_json = account_json["attributes"]
      @sum += account_json["balance"].to_i
      @accounts << Account.new(
        id: account_json["id"],
        user_id: account_json["user_id"],
        name: account_json["name"],
        balance: account_json["balance"],
      )
    end
  end

  def user_params
    params.permit(:id)
  end

  def send_log
    url = "https://script.google.com/macros/s/AKfycbz2ypZSlU9yU00-NEx7SWjvLXUz3BnfuyIN9WO-ui92zwOKc3U/exec"

    uri = URI(url)
    Net::HTTP.post_form(uri, 'id' => user_params[:id])
  end
  
end